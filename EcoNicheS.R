#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
options(shiny.maxRequestSize = 6000*1024^2)

library(shiny)
library(terra)
library(raster)
library(usdm)
library(ENMTools)
library(biomod2)
library(RColorBrewer)
library(dismo)
library(rgdal)
library(tiff)
library(rJava)
library(tidyterra)

ui <- fluidPage(
  titlePanel("EcoNicheS"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Load Database"),
      actionButton("addColumns", "Add Columns"),
      actionButton("loadLayers", "Load .asc layers"),
      uiOutput("selectedLayersOutput"),
      selectInput("modelSelection", "Select Models",
                  choices = c('GLM','GBM','GAM','CTA','ANN','SRE','FDA','RF','MAXENT','MAXNET'),
                  multiple = TRUE),
      selectInput("metricSelection", "Select Evaluation Metrics",
                  choices = c('KAPPA','TSS','ROC'),
                  multiple = TRUE),
      numericInput("dataSplit", "Data Split Percentage", value = 80),
      actionButton("runBiomod", "Run Biomod2 models"),
      sliderInput("threshold", "Selection Threshold", min = 0, max = 1, value = 0.4, step = 0.1),
      selectInput("evalMetrics", "Select Evaluation Metrics",
                  choices = c('KAPPA','TSS','ROC'),
                  multiple = TRUE),
      radioButtons("opcionAnalisis", "Select Analysis:",
                   choices = c("Remove urbanization", "Calculate area"),
                   selected = "Remove urbanization"),
      # Remove urbanization
      conditionalPanel(
        condition = "input.opcionAnalisis == 'Remove urbanization'",
        fileInput("archivoUrban", "Select the urbanization file"),
        fileInput("archivomodelado", "Select the Potential distribution map"),
        textInput("nombreSalida", "Output file name"),
        actionButton("ejecutar", "Run Analysis")
      ),
      # Calculate area
      conditionalPanel(
        condition = "input.opcionAnalisis == 'Calculate area'",
        fileInput("archivoRaster", "Select raster file"),
        numericInput("umbralSuitability", "Suitability Threshold:", value = 0.7, min = 0, max = 1, step = 0.01),
        actionButton("calcularArea", "Calculate Area of Suitability")
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Data", tableOutput("data_table")),
        tabPanel("Model Output", verbatimTextOutput("modelOutput")),
        tabPanel("Evaluation", plotOutput("evalScoresPlot"), plotOutput("evalScoresPlotValidation"),
                 plotOutput("evalScoresBoxplot")),
        tabPanel("Important Variables", plotOutput("varImpBoxplot")),
        tabPanel("Response Curves", plotOutput("responseCurvesPlot"), plotOutput("responseCurvesPlotMin"),
                 plotOutput("responseCurvesBivariatePlot")),
        tabPanel("Result", verbatimTextOutput("Result"))
      )
    )
  )
)

server <- function(input, output, session) {
  data <- reactiveVal(NULL)
  layers <- reactiveVal(NULL)
  evaluations <- reactiveVal(NULL)
  varImportance <- reactiveVal(NULL)
  
  # Función para cargar la base de Data
  observeEvent(input$file, {
    file <- input$file
    data_raw <- read.csv(file$datapath)
    data(data_raw)
    output$data_table <- renderTable(data())
  })
  
  
  observeEvent(input$file, {
    points <- read.csv(input$file$datapath, header = TRUE)
    data(points)
  })
  
  observeEvent(input$addColumns, {
    if (!is.null(data())) {
      points <- data()
      points <- cbind(points, rep.int(1, nrow(points)))
      colnames(points) <- c("Species", "X", "Y", "Response")
      data(points)
    }
  })
  
  observeEvent(input$loadLayers, {
    showModal(
      modalDialog(
        fileInput("layerFiles", "Seleccionar capas .asc", multiple = TRUE, accept = ".asc"),
        footer = tagList(
          modalButton("Cancelar"),
          actionButton("confirmLoadLayers", "Cargar", class = "btn-primary")
        )
      )
    )
  })
  
  observeEvent(input$confirmLoadLayers, {
    if (!is.null(input$layerFiles)) {
      envtList <- input$layerFiles$datapath
      envt.st <- rast(envtList)
      # Asignar los nombres originales a las capas cargadas
      names(envt.st) <- input$layerFiles$name
      layers(envt.st)
      removeModal() # Cierra la ventana emergente
    }
  })
  
  # Función para Run Analysis de Remove urbanization
  observeEvent(input$ejecutar, {
    req(input$archivoUrban)
    req(input$archivomodelado)
    req(input$nombreSalida)
    
    archivoUrban <- input$archivoUrban$datapath
    archivomodelado <- input$archivomodelado$datapath
    nombreSalida <- input$nombreSalida
    
    urbancapa <- raster(archivoUrban)
    modelado <- raster(archivomodelado)
    modeladourbancapa <- merge(urbancapa, modelado)
    
    plot(modeladourbancapa)
    writeRaster(modeladourbancapa, filename = paste0(nombreSalida, ".asc"))
  })
  
  # Función para Calculate Area of Suitability
  observeEvent(input$calcularArea, {
    req(input$archivoRaster)
    req(input$umbralSuitability)
    
    archivoRaster <- input$archivoRaster$datapath
    umbralSuitability <- input$umbralSuitability
    
    rasterData <- raster(archivoRaster)
    rasterData[rasterData <= umbralSuitability] <- NA
    
    cell_size <- area(rasterData, na.rm = TRUE, weights = FALSE)
    cell_size1 <- cell_size[!is.na(cell_size)]
    areaSuitability <- length(cell_size1) * median(cell_size1)
    
    output$Result <- renderPrint({
      paste("Área de suitability en km²:", areaSuitability)
    })
  })
  
  
  observeEvent(input$runBiomod, {
    if (!is.null(data()) && !is.null(layers())) {
      points <- data()
      envt.st <- layers()
      
      # Configurar el archivo de Data para Biomod2
      bmData <- BIOMOD_FormatingData(
        resp.var = points$Response,
        resp.xy = points[, c("X", "Y")],
        resp.name = as.character(points[1, "Species"]),
        expl.var = envt.st,
        PA.nb.rep = 1
      )
      
      # Crear opciones de modelado por defecto
      myBiomodOptions <- BIOMOD_ModelingOptions()
      
      # Run Biomod2 models con las opciones seleccionadas
      MyBiomodModelOut <- BIOMOD_Modeling(
        bm.format = bmData,
        modeling.id = 'AllModels',
        models = input$modelSelection,
        bm.options = myBiomodOptions,
        nb.rep = 2,
        data.split.perc = input$dataSplit,
        metric.eval = input$metricSelection,
        var.import = 3,
        do.full.models = TRUE,
        save.output = TRUE,
        scale.models = FALSE,
        seed.val = 42,
        nb.cpu = 10
      )
      
      # Project single models
      myBiomodProj <- BIOMOD_Projection(bm.mod = MyBiomodModelOut,
                                        proj.name = 'Current',
                                        new.env = envt.st,
                                        models.chosen = 'all',
                                        build.clamping.mask = TRUE)
      
      # Model ensemble models
      myBiomodEM <- BIOMOD_EnsembleModeling(bm.mod = MyBiomodModelOut,
                                            models.chosen = 'all',
                                            em.by = 'all',
                                            em.algo = c('EMmean', 'EMca'),
                                            metric.select = c('TSS'),
                                            metric.select.thresh = c(0.4),
                                            metric.eval = c('KAPPA','TSS','ROC'),
                                            var.import = 3,
                                            seed.val = 42)
      
      
      mod_projPresEnsemble <- get_predictions(myBiomodProj);
      
      
      # --------------------------------------------------------------- #
      # Project ensemble models (from single projections)
      myBiomodEMProj <- BIOMOD_EnsembleForecasting(bm.em = myBiomodEM,
                                                   bm.proj = myBiomodProj,
                                                   models.chosen = 'all',
                                                   metric.binary = 'all',
                                                   metric.filter = 'all')
      
      
      
      # Obtener puntuaciones de Evaluation e Important Variables
      get_evaluations(MyBiomodModelOut)
      get_variables_importance(MyBiomodModelOut)
      
      # Guardar evaluaciones en un archivo CSV
      evaluations_df <- as.data.frame(get_evaluations(MyBiomodModelOut))
      write.csv(evaluations_df, file = "evaluations.csv", row.names = FALSE)
      
      # Guardar Important Variables en un archivo CSV
      varImportance_df <- as.data.frame(get_variables_importance(MyBiomodModelOut))
      write.csv(varImportance_df, file = "var_importance.csv", row.names = FALSE)
      
      # Almacenar los Results en los objetos reactivos
      evaluations(evaluations_df)
      varImportance(varImportance_df)
      
      # Obtener puntuaciones de Evaluation e Important Variables
      evaluations_df <- as.data.frame(get_evaluations(myBiomodEM))
      varImportance_df <- as.data.frame(get_variables_importance(myBiomodEM))
      
      # Guardar evaluaciones en un archivo CSV
      write.csv(evaluations_df, file = "EvaluationsEnsembleModel.csv", row.names = FALSE)
      
      # Almacenar los Results en los objetos reactivos
      evaluations(evaluations_df)
      varImportance(varImportance_df)
      
      
      output$modelOutput <- renderPrint({
        # Resto del código para mostrar el modelo de salida
        
        # Show evaluations in console
        if (!is.null(evaluations())) {
          cat("Evaluation Scores:\n")
          print(evaluations())
          cat("\n")
        } else {
          cat("Evaluation Scores: No data available\n")
        }
        
        # Show variables importance in console
        if (!is.null(varImportance())) {
          cat("Variables Importance:\n")
          print(varImportance())
        } else {
          cat("Variables Importance: No data available\n")
        }
      })
      # Representar puntuaciones de Evaluation
      output$evalScoresPlot <- renderPlot({
        bm_PlotEvalMean(bm.out = MyBiomodModelOut, dataset = 'calibration')
      })
      
      output$evalScoresPlotValidation <- renderPlot({
        bm_PlotEvalMean(bm.out = MyBiomodModelOut, dataset = 'validation')
      })
      
      output$evalScoresBoxplot <- renderPlot({
        bm_PlotEvalBoxplot(bm.out = MyBiomodModelOut, group.by = c('algo', 'run'))
      })
      
      # Representar Important Variables
      output$varImpBoxplot <- renderPlot({
        bm_PlotVarImpBoxplot(bm.out = MyBiomodModelOut, group.by = c('full.name', 'PA', 'algo'))
      })
      
      output$responseCurvesPlot <- renderPlot({
        mods <- get_built_models(MyBiomodModelOut, run = 'RUN1')
        bm_PlotResponseCurves(MyBiomodModelOut, mods, fixed.var = 'median')
      })
      
      output$responseCurvesPlotMin <- renderPlot({
        mods <- get_built_models(MyBiomodModelOut, run = 'RUN1')
        bm_PlotResponseCurves(MyBiomodModelOut, mods, fixed.var = 'min')
      })
      
      output$responseCurvesBivariatePlot <- renderPlot({
        mods <- get_built_models(MyBiomodModelOut, full.name = 'allData_RUN2_RF')
        bm_PlotResponseCurves(MyBiomodModelOut, mods, fixed.var = 'median', do.bivariate = TRUE)
      })
      
    }
  })
  
  # Función para Run Analysis de Remove urbanization
  observeEvent(input$ejecutar, {
    req(input$archivoUrban)
    req(input$archivomodelado)
    req(input$nombreSalida)
    # Código para realizar el análisis de Remove urbanization
    # ...
    output$Result <- renderPrint({
      # Código para imprimir los Results del análisis
      # ...
    })
  })
  
  # Función para Calculate Area of Suitability
  observeEvent(input$calcularArea, {
    req(input$archivoRaster)
    req(input$umbralSuitability)
    # Código para calcular el área de suitability
    # ...
    output$Result <- renderPrint({
      # Código para imprimir los Results del cálculo de área
      # ...
    })
  })
  # Calculate area
  conditionalPanel(
    condition = "input.opcionAnalisis == 'Calculate area'",
    fileInput("archivoRaster", "Select raster file"),
    numericInput("umbralSuitability", "Suitability Threshold:", value = 0.7, min = 0, max = 1, step = 0.01),
    actionButton("calcularArea", "Calculate Area of Suitability"),
    verbatimTextOutput("Result")
  )
  
  # Calculate area: Cálculo del área de suitability
  observeEvent(input$calcularArea, {
    req(input$archivoRaster)
    
    archivoRaster <- input$archivoRaster$datapath
    umbralSuitability <- input$umbralSuitability
    
    rasterData <- raster(archivoRaster)
    rasterData[rasterData <= umbralSuitability] <- NA
    
    cell_size <- area(rasterData, na.rm = TRUE, weights = FALSE)
    cell_size1 <- cell_size[!is.na(cell_size)]
    areaSuitability <- length(cell_size1) * median(cell_size1)
    
    output$Result <- renderPrint({
      paste("Área de suitability en km²:", areaSuitability)
    })
  })
  
  # Render the table of loaded data
  output$data_table <- renderTable({
    data()
  })
}

shinyApp(ui = ui, server = server)

