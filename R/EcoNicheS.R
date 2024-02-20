#This is a Shiny web application. You can run the application by clicking the 'Run App' button above.

#Find out more about building applications with Shiny here:

#http://shiny.rstudio.com/




options(shiny.maxRequestSize = 6000*1024^2)

library(shiny)
library(terra)
library(usdm)
library(ENMTools)
library(biomod2)
library(RColorBrewer)
library(dismo)
library(tiff)
library(rJava)
library(tidyterra)
library(shinydashboard)
library(pROC)
library(R.utils)
library(ENMGadgets)
library(countrycode)
library(CoordinateCleaner)
library(dplyr)
library(ggplot2)
library(rgbif)
library(sf)
library(rnaturalearthdata)

# Definir UI de la aplicación principal
ui <- dashboardPage(
  dashboardHeader(title = "EcoNicheS"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Coordinate cleaner", tabName = "tab1"),
      menuItem("Correlation layers", tabName = "tab2"),
      menuItem("Points and pseudoabsences", tabName = "tab3"),
      menuItem("Biomod2", tabName = "tab4"),
      menuItem("Partial ROC Analysis", tabName = "tab5"),
      menuItem("Remove urbanization", tabName = "tab6"),
      menuItem("Calculate area", tabName = "tab7"),
      menuItem("Gains and Losses Plot", tabName = "tab8")
    )
  ),
  dashboardBody(
    tabItems(
      
      ###################################################################################
      tabItem(tabName = "tab1",
              fluidPage(
                titlePanel("Coordinate cleaner"),
                sidebarLayout(
                  sidebarPanel(
                    textInput("species_name", "Species scientific name:"),
                    numericInput("limit_occ", "Data Limit", value = 5000),
                    actionButton("runOcc", "Obtain occurrences"),
                    conditionalPanel(
                      condition = "output.wmPlot !== undefined && output.wmPlot !== null",
                      numericInput("km", "Limit (km)", value = 100),
                      numericInput("Year_Y", "Year from which the information is desired", value = 2000),
                      numericInput("study_area", "Maximum latitude", value=40),
                      actionButton("Remove_l_p_r", "Filter occurrences")
                    )
                  ),
                  mainPanel(
                    tabPanel("Coordinate Cleaner",
                             verbatimTextOutput("db_created_output"),                    
                             plotOutput("wmPlot"),
                             conditionalPanel(
                               condition = "output.wmPlot !== undefined && output.wmPlot !== null", 
                               plotOutput("plotflag_output"),
                               plotOutput("plot_remove"),
                               tableOutput("Year_R")
                               
                               
                               
                             )
                    )
                  ) #mainpanel
                ) #sidebarla
              )#fluigp
      ),#tabitem
      
      
      ######################################################################################
      
      
      tabItem(tabName = "tab2",
              fluidPage(
                titlePanel("Correlation layers"),
                sidebarLayout(
                  sidebarPanel(
                    fileInput("file_input", "Select .asc files", multiple = TRUE, accept = ".asc"),
                    sliderInput("threshold", "Umbral (th)", min = 0, max = 1, value = 0.4, step = 0.1),
                    actionButton("analyze_button", "Calculate Correlation"),
                    verbatimTextOutput("cor_output"),
                    verbatimTextOutput("v2_output"),
                    downloadButton("download_heatmap_pdf", "Download Heatmap (PDF)")
                  ),
                  mainPanel(
                    plotOutput("cor_plot")
                  )
                )
              )),
      
      
      
      
      
      
      
      
      tabItem(tabName = "tab3",
              fluidPage(
                titlePanel("Points and pseudoabsences"),
                sidebarLayout(
                  sidebarPanel(
                    fileInput("occurrences", "Select occurrence points file (CSV):"),
                    fileInput("mask", "Select mask file (ASC):"),
                    textInput("num_points", "Number of random points:", value = "1000"),
                    textInput("output_name", "Database output name:", value = "Speciespointspa.csv"),
                    actionButton("run_script", "Run script")
                  ),
                  mainPanel(
                    verbatimTextOutput("console_output")
                  )
                )
              )),
      
      
      
      
      
      
      
      
      tabItem(tabName = "tab4",
              fluidPage(
                titlePanel("Biomod2"),
                sidebarLayout(
                  sidebarPanel(
                    fileInput("file", "Load Database"),
                    actionButton("loadLayers", "Load .asc layers"),
                    uiOutput("selectedLayersOutput"),
                    selectInput("modelSelection", "Select Models",
                                choices = c('GLM','GBM','GAM','CTA','ANN','SRE','FDA','RF','MAXENT','MAXNET'),
                                multiple = TRUE),
                    selectInput("metricSelection", "Select Evaluation Metrics",
                                choices = c('KAPPA','TSS','ROC'),
                                multiple = TRUE),
                    numericInput("dataSplit", "Data Split Percentage", value = 80),
                    numericInput("dataRep", "Number of Repetitions", value = 10),
                    sliderInput("threshold", "Selection Threshold", min = 0, max = 1, value = 0.4, step = 0.1),
                    selectInput("evalMetrics", "Select Evaluation Metrics",
                                choices = c('KAPPA','TSS','ROC'),
                                multiple = TRUE),
                    actionButton("runBiomod", "Run Biomod2 models")
                    
                  ),
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Database", tableOutput("data_table")),
                      tabPanel("Model Output", verbatimTextOutput("modelOutput")),
                      tabPanel("Evaluation", plotOutput("evalScoresPlot"), plotOutput("evalScoresPlotValidation"),
                               plotOutput("evalScoresBoxplot")),
                      tabPanel("Important Variables", plotOutput("varImpBoxplot")),
                      tabPanel("Response Curves", plotOutput("responseCurvesPlot"), plotOutput("responseCurvesPlotMin"),
                               plotOutput("responseCurvesBivariatePlot")),
                    )
                  )
                ))
      ),
      
      
      #
      
      
      tabItem(tabName = "tab5",
              fluidPage(
                titlePanel("Partial ROC Analysis"),
                sidebarLayout(
                  sidebarPanel(
                    fileInput("sdm_mod", "Upload Prediction Raster (Raster file in .asc or .tif format)"),
                    fileInput("occ_proc", "Upload Validation Data (CSV file)"),
                    numericInput("iter", "Number of Simulations", value = 500),
                    numericInput("omission", "Omission Threshold", value = 0.1),
                    numericInput("randper", "Random Percent", value = 50),
                    actionButton("runButton", "Run Analysis"),
                  ),
                  fluidPage(
                    mainPanel(
                      verbatimTextOutput("pStats"),
                      dataTableOutput("rocPart"),
                      plotOutput("rocPartPlot")
                    ))
                )
              )
      ),
      
      
      
      
      #
      
      tabItem(tabName = "tab6",
              fluidPage(
                titlePanel("Remove urbanization"),
                sidebarLayout(
                  sidebarPanel(
                    fileInput("archivoUrban", "Select the urbanization file"),
                    fileInput("archivomodelado", "Select the Potential distribution map"),
                    textInput("nombreSalida", "Output file name"),
                    actionButton("ejecutar", "Run Analysis")
                  ),
                  mainPanel(
                    verbatimTextOutput("rem_urba_output")
                  ))
              )
      ),
      #            
      
      tabItem(tabName = "tab7",
              fluidPage(
                titlePanel("Calculate area"),
                sidebarLayout(
                  sidebarPanel(
                    condition = "input.opcionAnalisis == 'Calculate area'",
                    fileInput("archivoRaster", "Select raster file"),
                    numericInput("umbralSuitability", "Suitability Threshold:", value = 0.7, min = 0, max = 1, step = 0.01),
                    actionButton("calcularArea", "Calculate Area of Suitability")
                  ),
                  mainPanel(
                    tabPanel("Result", verbatimTextOutput("Result"))
                  ))
              )
      ),
      
      #
      
      tabItem(tabName = "tab8",
              fluidPage(
                titlePanel("Gains and Losses Plot"),
                sidebarLayout(
                  sidebarPanel(
                    fileInput("mapa_presente_input", "Load Present Map (asc)"),
                    fileInput("mapa_futuro_input", "Load Future Map (asc)"),
                    actionButton("run_analysis_btn", "Run Analysis")
                  ),
                  fluidPage(
                    mainPanel(
                      box(
                        title = "Gains Plot",
                        status = "primary",
                        plotOutput("Gains_plot")
                      ),
                      box(
                        title = "Losses Plot",
                        status = "danger",
                        plotOutput("Losses_plot")
                      )
                    ),
                    fluidPage(
                      downloadButton("download_Gains", "Download Gains Map"),
                      downloadButton("download_Losses", "Download Losses Map")
                    ))
                )
              )
      )
      
      
      
      #
      
    )
  )
)


server <- function(input, output, session) {
  
  ##############################################################################################################3
  observeEvent(input$runOcc, {
    dat <- occ_search(
      scientificName = input$species_name, 
      limit = input$limit_occ, 
      hasCoordinate = TRUE
    )
    dat <- dat$data
    
    dat<- dat %>%
      dplyr::select(species, decimalLongitude, 
                    decimalLatitude, countryCode, individualCount,
                    gbifID, family, taxonRank, coordinateUncertaintyInMeters,
                    year, basisOfRecord, institutionCode, datasetName)
    
    dat <- dat %>%
      filter(!is.na(decimalLongitude)) %>%
      filter(!is.na(decimalLatitude))
    
    wmPlot <- borders("world", colour = "gray50", fill = "gray50")
    output$wmPlot <- renderPlot({
      ggplot() +
        coord_fixed() +
        wmPlot +
        geom_point(data = dat,
                   aes(x = decimalLongitude, y = decimalLatitude),
                   colour = "darkred",
                   size = 3) +
        theme_bw() })
    
    dat_coordinates <- dat %>%
      dplyr::select(species, decimalLongitude, decimalLatitude)
    
    dat$countryCode <-  countrycode(dat$countryCode, 
                                    origin =  'iso2c',
                                    destination = 'iso3c')
    #flag problems
    dat <- data.frame(dat)
    flags <- clean_coordinates(x = dat, 
                               lon = "decimalLongitude", 
                               lat = "decimalLatitude",
                               countries = "countryCode",
                               species = "species",
                               tests = c("capitals", "centroids",
                                         "equal", "zeros", "countries")) # most test are on by default
    sumflag <- summary(flags)
    plotflags <- plot(flags, lon = "decimalLongitude", lat = "decimalLatitude")
    
    #Exclude problematic records
    dat_cl <- dat[flags$.summary,]
    
    #The flagged records
    dat_fl <- dat[!flags$.summary,]
    
    summaryTable <- data.frame(Resultado = names(sumflag), Valor = as.numeric(sumflag))
    
    
    output$plotflag_output <- renderPlot({plotflags})
    
    remove_plot <- dat_cl %>% 
      mutate(Uncertainty = coordinateUncertaintyInMeters / 1000) %>% 
      ggplot(aes(x = Uncertainty)) + 
      geom_histogram() +
      xlab("Coordinate uncertainty in meters") +
      theme_bw()
    
    output$plot_remove <- renderPlot({remove_plot})
    
    
    
    Yea_r <- table(dat_cl$year)
    output$Year_R <- renderTable({
      data.frame(Year=names(Yea_r), Amount_of_Records=as.numeric(Yea_r))
    })
    
    
    ############################################################ Guardar los archivos en la carpeta "output_files"
    ############################################################
    ############################################################
    
    clean_proj <- file.path(getwd(), "output_files")
    if (!file.exists(clean_proj)) {
      dir.create(clean_proj)
    }
    
    data_file <- file.path(clean_proj, paste0("Raw Data_", input$species_name, ".csv"))
    coordinates_file <- file.path(clean_proj, paste0("Raw Coordinates_", input$species_name, ".csv"))
    cleaned_data <- file.path(clean_proj, paste0("Cleaned Data_", input$species_name, ".csv"))
    flagged_data <-file.path(clean_proj, paste0("Flagged Data_", input$species_name, ".csv"))
    flag_record <- file.path(clean_proj, paste0("Flagged records test_", input$species_name, ".csv"))
    observe ({write.csv(dat, file = data_file, row.names = FALSE)})
    observe ({write.csv(dat_coordinates, file = coordinates_file, row.names = FALSE)})
    observe ({write.csv(dat_cl, file = cleaned_data, row.names = FALSE)})
    observe ({write.csv(dat_fl, file = flagged_data, row.names = FALSE)})
    observe ({write.csv(summaryTable, file= flag_record, row.names = FALSE)})
    
    
    observeEvent(input$Remove_l_p_r, {
      #100 km
      dat_cl_uncertanity <- dat_cl %>%
        filter(coordinateUncertaintyInMeters / 1000 <= input$km | is.na(coordinateUncertaintyInMeters))
      
      # Remove unsuitable data sources, especially fossils 
      # which are responsible for the majority of problems in this case
      
      
      ################################year
      dat_cl_bof_ic_y <-       dat_cl_uncertanity %>%
        filter(year > input$Year_Y) 
      
      
      ################################Latitude
      #exclude based on study area
      
      dat_cl_bof_ic_y_f_fin <- filter(dat_cl_bof_ic_y, decimalLatitude < input$study_area)
      c_f_coordinates <- dat_cl_bof_ic_y_f_fin %>%
        dplyr::select(species, decimalLongitude, decimalLatitude)
      colnames(c_f_coordinates) <- c("Species", "X", "Y")
      
      
      fil_cle_da <-paste0("Filtered and cleaned data_", input$species_name, input$km, input$Year_Y, input$study_area, ".csv")
      fil_cle_ocu <- paste0("Filtered and cleaned occurrences_", input$species_name, input$km, input$Year_Y, input$study_area, ".csv")         
      observe ({write.csv(dat_cl_bof_ic_y_f_fin, file =fil_cle_da, row.names = FALSE)})
      observe ({write.csv(c_f_coordinates, file =fil_cle_ocu, row.names = FALSE)})
      
      observe({
        output$db_created_output <- renderPrint("Database created successfully!")
        
      })
    })
    
  })
  
  
  
  
  
  
  
  ####################################################################################
  
  #correlation layers
  values <- reactiveValues(
    bioFinal = NULL,
    cor_matrix = NULL,
    cor_plot = NULL,
    v2 = NULL
  )
  
  observeEvent(input$file_input, {
    file_list <- input$file_input$datapath
    names(file_list) <- input$file_input$name
    values$bioFinal <- stack(file_list)
  })
  
  observeEvent(input$analyze_button, {
    if (!is.null(values$bioFinal)) {
      values$cor_matrix <- raster.cor.matrix(values$bioFinal, method = "pearson")
      values$cor_plot <- raster.cor.plot(values$bioFinal)
      values$bioFinal2<-as.data.frame(values$bioFinal)
      values$v2 <- vifcor(values$bioFinal2, th = input$threshold)
    }
  })
  
  output$cor_output <- renderPrint({
    if (!is.null(values$cor_matrix)) {
      values$cor_matrix
    }
  })
  
  output$v2_output <- renderPrint({
    if (!is.null(values$v2)) {
      values$v2
    }
  })
  
  output$cor_plot <- renderPlot({
    if (!is.null(values$cor_plot)) {
      plot(values$cor_plot$cor.heatmap)
    }
  })
  
  output$download_heatmap_pdf <- downloadHandler(
    filename = function() {
      "heatmap.pdf"
    },
    content = function(file) {
      pdf(file)
      plot(values$cor_plot$cor.heatmap)
      dev.off()
    }
  )
  
  #Occurrence points and pseudousences generator
  data <- reactiveVal(NULL)
  layers <- reactiveVal(NULL)
  evaluations <- reactiveVal(NULL)
  varImportance <- reactiveVal(NULL)
  
  # Función para cargar la base de datos
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
  
  
  
  # Occurrence points and pseudousences generator
  observeEvent(input$run_script, {
    req(input$occurrences, input$mask, input$num_points, input$output_name)
    
    occurrences <- read.csv(input$occurrences$datapath)
    
    mask <- raster(input$mask$datapath)
    
    pseudoabsences <- randomPoints(mask, n = as.integer(input$num_points), ext = mask, extf = 1)
    
    plot(pseudoabsences)
    
    pa <- as.data.frame(pseudoabsences)
    occurrences$Response <- 1
    pa$Response <- 0
    
    pa2 <- cbind(Species = "Speciespoints", pa)
    colnames(pa2) <- c("Species", "X", "Y", "Response")
    combined_data <- rbind(occurrences, pa2)
    
    write.csv(combined_data, input$output_name)
    
    output$console_output <- renderPrint({
      "The database has been generated and saved in the working directory."
    })
  })
  # Biomod2 and more
  
  # Load Database
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
  # Load .asc layers
  observeEvent(input$loadLayers, {
    showModal(
      modalDialog(
        fileInput("layerFiles", "Select .asc files", multiple = TRUE, accept = ".asc"),
        footer = tagList(
          modalButton("Cancel"),
          actionButton("confirmLoadLayers", "Upload", class = "btn-primary")
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
  
  # Run Biomod2 models
  observeEvent(input$runBiomod, {
    if (!is.null(data()) && !is.null(layers())) {
      points <- data()
      envt.st <- layers()
      
      # Configurar el archivo de datos para Biomod2
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
        nb.rep = input$dataRep,
        data.split.perc = input$dataSplit,
        metric.eval = input$metricSelection,
        var.import = 3,
        do.full.models = TRUE,
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
  
  # Remove urbanization
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
    output$rem_urba_output <- renderPrint({
      "The database has been generated and saved in the working directory."
    })
  })
  
  # Calculate Area
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
      paste("Area of Suitability in km²:", areaSuitability)
    })
  })
  
  
  present_map <- reactiveVal(NULL)
  future_map <- reactiveVal(NULL)
  
  observeEvent(input$mapa_presente_input, {
    present_map(raster(input$mapa_presente_input$datapath))
  })
  
  observeEvent(input$mapa_futuro_input, {
    future_map(raster(input$mapa_futuro_input$datapath))
  })
  
  observeEvent(input$run_analysis_btn, {
    if (!is.null(present_map()) && !is.null(future_map())) {
      Gains <- future_map() - present_map()
      Losses <- present_map() - future_map()
      
      output$Gains_plot <- renderPlot({
        plot(Gains, main = "Gains: Future - Present")
      })
      
      output$Losses_plot <- renderPlot({
        plot(Losses, main = "Losses: Present - Future")
      })
    }
  })
  
  output$download_Gains <- downloadHandler(
    filename = function() {
      "Gains.asc"
    },
    content = function(file) {
      if (!is.null(present_map()) && !is.null(future_map())) {
        Gains <- future_map() - present_map()
        writeRaster(Gains, file)
      }
    }
  )
  
  output$download_Losses <- downloadHandler(
    filename = function() {
      "Losses.asc"
    },
    content = function(file) {
      if (!is.null(present_map()) && !is.null(future_map())) {
        Losses <- present_map() - future_map()
        writeRaster(Losses, file)
      }
    }
  )
  
  dat_raster <- reactive({
    if (is.null(input$sdm_mod))
      return(NULL)
    else if (any(grepl('\\.(asc|tif)$', input$sdm_mod$name)))
      return(input$sdm_mod$datapath)
  })
  
  dat_presence <- reactive({
    if (is.null(input$occ_proc))
      return(NULL)
    else if (identical(input$occ_proc$type, "application/vnd.ms-excel") ||
             identical(input$occ_proc$type, "text/csv"))
      return(input$occ_proc$datapath)
  })
  
  partialRoc <- eventReactive(input$runButton, {
    sims <- as.numeric(input$iter)
    error <- 1 - as.numeric(input$omission)
    if (!is.null(dat_presence()) && !is.null(dat_raster())) {
      output_file <- paste0("partialROC_output_", format(Sys.time(), "%Y%m%d%H%M%S"), ".csv")
      pRoc <- PartialROC(PresenceFile = dat_presence(),
                         PredictionFile = dat_raster(),
                         OmissionVal = error, RandomPercent = input$randper,
                         NoOfIteration = sims, OutputFile = output_file)
      if (is.data.frame(pRoc) && "AUC_at_Value_0.9" %in% names(pRoc)) {
        return(pRoc)
      } else {
        return(NULL)
      }
    }
    return(NULL)
  })
  
  output$rocPart <- renderDataTable({
    if (!is.null(partialRoc())) {
      return(partialRoc())
    } else {
      return(NULL)
    }
  }, options = list(aLengthMenu = c(5, 10, 25, 50, 100, 500), iDisplayLength = 5))
  
  output$rocPartPlot <- renderPlot({
    # ... (código para rocPartPlot)
  })
  
  pRocStats <- eventReactive(input$runButton, {
    dataP <- partialRoc()
    if (!is.null(dataP)) {
      if ("AUC_at_Value_0.9" %in% names(dataP) &&
          "AUC_at_0.5" %in% names(dataP) &&
          "AUC_ratio" %in% names(dataP)) {
        mean_AUC_0.9 <- mean(dataP$AUC_at_Value_0.9, na.rm = TRUE)
        mean_AUC_0.5 <- mean(dataP$AUC_at_0.5, na.rm = TRUE)
        mean_AUC_ratio <- mean(dataP$AUC_ratio, na.rm = TRUE)
        
        cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
        cat('                         Statistics for Partial Roc                                 \n')
        cat('                          after', input$iter, 'simulations                          \n')
        cat('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n')
        
        cat('The mean value for AUC at 0.05 is:', mean_AUC_0.9, '\n\n')
        cat('The mean value for AUC at 0.5 is:', mean_AUC_0.5, '\n\n')
        cat('The mean value for AUC ratio at 0.05 is:', mean_AUC_ratio, '\n\n')
      }
    }
    return(NULL)
  })
  
  output$pStats <- renderPrint({
    stats <- pRocStats()
    if (!is.null(stats)) {
      return(stats)
    }
  })
  
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)
