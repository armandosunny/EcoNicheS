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
library(countrycode)
library(CoordinateCleaner)
library(dplyr)
library(ggplot2)
library(rgbif)
library(sf)
library(rnaturalearthdata)
library(spThin)
library(shinyjs)
library(leaflet)
library(DT)
library(shinyBS)
library(prettymapr)
library(ntbox)
library(gt)
library(tidyverse)
library(gtExtras)


# Definir UI de la aplicación principal
ui <- dashboardPage(
  dashboardHeader(title = 'EcoNicheS',
                  tags$li(class = "dropdown",
                          tags$style(HTML("
             .skin-pink .main-header {
               background-color: #FFC0CB; 
             }
           "))
                  ),
                  tags$li(
                    class = "dropdown",
                    a(href = "https://github.com/armandosunny/EcoNicheS",
                      icon("github"),
                      "USER MANUAL"
                    )
                  )
  ), #aqui le moví
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = HTML("<i class='fa-solid fa-frog'></i> EcoNicheS"), tabName = "tab1"),
      menuItem(text = HTML("<i class='fas fa-globe'></i> Occurrence processing"), tabName = "tab2",
               menuSubItem("Get and clean GBIF data", tabName = "subtab1"),
               menuSubItem("Clean my own database", tabName = "subtab2")),
      menuItem(text = HTML("<i class='fas fa-map'></i> Load and Plot Maps"), tabName = "tab3"),
      menuItem(text = HTML("<i class='fas fa-chart-line'></i> Correlation layers"), tabName = "tab4"),
      menuItem(text = HTML("<i class='fas fa-dot-circle'></i> Points and pseudoabsences"), tabName = "tab5"),
      menuItem(text = HTML("<i class='fas fa-cogs'></i> biomod2"), tabName = "tab6"),
      menuItem(text = HTML("<i class='fas fa-map'></i> Load and Plot Maps"), tabName = "tab7"),
      menuItem(text = HTML("<i class='fas fa-chart-bar'></i> Partial ROC Analysis"), tabName = "tab8"),
      menuItem(text = HTML("<i class='fas fa-trash-alt'></i> Remove urbanization"), tabName = "tab9"),
      menuItem(text = HTML("<i class='fas fa-calculator'></i> Calculate area"), tabName = "tab10"),
      menuItem(text = HTML("<i class='fas fa-chart-line'></i> Gains and Losses Plot"), tabName = "tab11"),
      menuItem(text = HTML("<i class='fa-solid fa-frog'></i> ENMTools"), tabName = "tab12")
    )
  ),
  dashboardBody(
    tags$style(HTML("
    .content-wrapper {
      background-color: white;
    }
  ")),
    useShinyjs(),
    tabItems(
      
      ###################################################################################
      
      tabItem(tabName = "tab1",
              fluidPage(
                
                
                ##############
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#limit_occ").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(1000);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#km").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(100);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#Year_Y").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(2000);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#study_area").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(40);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#km_redonda").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(1);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#dataSplit").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(80);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#dataRep").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(10);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#iter").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(500);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#omission").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(0.1);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#randper").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(50);
          }
        });
      });
    ')
                ),
                tags$head(
                  tags$script('
      $(document).on("shiny:connected", function() {
        $("#umbralSuitability").on("change", function() {
          if ($(this).val() === "") {
            $(this).val(0.7);
          }
        });
      });
    ')
                ),
                
                
                ### tooltip
                
                tags$head(
                  tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css")
                ),
                tags$style(HTML("
      .box-title {
        display: flex;
        align-items: center;
      }
      .fa-question-circle {
        margin-left: 5px;
        color: #337ab7;
        cursor: help;
      }
    ")),
                
                ##cosos
                
                h1("Welcome to EcoNicheS!", style = "font-size: 48px; text-align: center; font-weight: bold; font-family: Arial;"),
                img(src = "https://user-images.githubusercontent.com/25662791/244543343-ac0a9b00-a873-469d-ac33-4b49cba48a90.png", height = "250px",  style = "display: block; margin: 0 auto;"),
                p("Thanks for using our app! We hope you enjoy your experience.", style = "font-size: 36px; text-align: center;font-family: Arial;"),
                p("Please cite as:", style = "font-size: 24px; text-align: center;font-weight: bold; font-family: Arial;"),
                p("Marmolejo C, López-Vidal R, Díaz-Sánchez LE, Sunny A (2024). EcoNicheS: Empowering Ecological Niche Modeling Analysis with Shinydashboard and R Package. GitHub. https://github.com/armandosunny/EcoNicheS", style = "font-size: 16px; text-align: center;font-family: Arial;")
                ## creo que estos parentesis de abajo son los que cierran el tab
              )
      ),
      #############3333
      
      
      
      tabItem(tabName = "subtab1",
              fluidPage(
                titlePanel("Get and clean GBIF data"),
                fluidRow(
                  column(width = 4,
                         box(
                           title = div("Species Search", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is the species search engine that allows you to obtain data directly from GBIF. Make sure you enter the correct name composed of the genus and the species as you will not be able to cancel the action until the data search is complete.")),
                           width = NULL,
                           
                           textInput("species_name", "Species scientific name:"),
                           numericInput("limit_occ", "Data Limit", value =1000),
                           actionButton("runOcc", "Obtain occurrences")
                         ), #box
                         
                         
                         ## pls dios
                         # Quite el conditional panel un momento
                         
                         box(
                           title = div("Filters", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                           width = NULL,
                           conditionalPanel(condition = "output.wmPlot === undefined || output.wmPlot === null",
                                            
                                            "This box will display the filters available to clean the occurrence data once the data search is complete.",
                           ),
                           conditionalPanel(
                             condition = "output.wmPlot !== undefined && output.wmPlot !== null",
                             
                             numericInput("km", "Limit (km)", value = 100),
                             numericInput("Year_Y", "Year from which the information is desired", value = 2000),
                             selectInput("geographicfilter", "Select a filter type", choices = c('Filter by country', 'Filter by latitude and longitude'), multiple = TRUE),
                             conditionalPanel(
                               condition = "input.geographicfilter.indexOf('Filter by latitude and longitude') !== -1",                        
                               numericInput("study_area", "Maximum latitude (Y)", value=40),
                               numericInput("study_long", "Maximum longitude (X)", value=180)
                             ), #conditional panel
                             conditionalPanel(
                               condition = "input.geographicfilter.indexOf('Filter by country') !== -1", 
                               uiOutput("country_select")
                             ),
                             actionButton("Remove_l_p_r", "Filter occurrences")
                           ) #gbif y uotput
                           
                         ) # box
                         
                  ), #colum
                  column(width = 8,
                         box(
                           width = NULL,
                           title = "Geographic distribution of the species",
                           leafletOutput("wmPlotleaf"),
                           plotOutput("wmPlot"),
                           conditionalPanel(
                             condition = "output.wmPlot !== undefined && output.wmPlot !== null", 
                             plotOutput("plotflag_output"),
                             plotOutput("plot_remove"),
                             dataTableOutput("Countryr_R"),
                             tableOutput("Year_R")
                             
                             
                             
                             
                           )#mainp creo que este es box
                         ) #box y este column 
                  ) #column
                ) #fluidrow
              )
      ),
      
      
      
      ######################################################################################
      #############3333
      tabItem(tabName = "subtab2",
              fluidPage(
                titlePanel("Clean my own database"),
                fluidRow(
                  column(width = 4,
                         box(         
                           title = div("Clean data out of GBIF", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                           width = NULL,
                           fileInput("file_for_cleaning", "Load Database with occurrencesin (.csv)", accept = ".csv"), 
                           textInput("LAT", "Column name with latitudes (Y)"),
                           textInput("LONG", "Column name with longitudes (X)"),
                           textInput("SPEC", "Column name with species name"),
                           textInput("nameSPEC", "Species name"),
                           numericInput("km_redonda", "Limit (km)", value = 1),
                           textInput("cleaned_name", "Cleaned database output name:", value = "SpeciesOccurrences"),
                           actionButton("check", "Check that the data matches"),
                           verbatimTextOutput("status_message_display"),
                           
                           actionButton("clean_my_odb", "Clean database"),
                           actionButton("vis_map", "View on a map"),
                           tags$script("shinyjs::disable(\"clean_my_odb\")")
                           
                         ) #box
                  ), #column
                  
                  column(width = 8,
                         box(
                           width = NULL,
                           tableOutput("onlyclean_table"),
                           leafletOutput("mywonPlotleaf")
                         ) # box
                  ) # column
                ) #fluidrow
              ) #fluidpage
      ), #tabitem
      ##########################################################3
      #############################################################
      
      tabItem(tabName = "tab3",
              fluidPage(
                titlePanel("Load and Plot Maps"),
                column(width = 4,
                       box(
                         title = div("Attach the file to view", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         fileInput("file_maps", "Select map file:",
                                   accept = c('.tiff','.tif', '.asc', '.bil')),
                         actionButton("load_leaflet_button", "Load Leaflet Map")
                       ) #box
                ), #column
                column(width = 4,
                       box(
                         title = div("Interactive Plot", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         leafletOutput("leaflet_map"))),
                column(width = 4,
                       box(
                         title = div("PDF preview", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         plotOutput("mapPlot"),
                         conditionalPanel(
                           condition = "output.mapPlot !== undefined && output.mapPlot !== null", 
                           downloadButton("download_pdf_button", "Download Map as PDF", disabled = TRUE))
                       ))
              ) #fluidpage
      ), #tabitem
      ##################################################3
      ##########################################33
      
      tabItem(tabName = "tab4",
              fluidPage(
                titlePanel("Correlation Layers"),
                column(width = 4,
                       box(
                         title = div("Obtain the Pearson correlation and Variance inflation factor", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         fileInput("file_input", "Select .asc files", multiple = TRUE, accept = ".asc"),
                         sliderInput("threshold_hm", "Umbral (th)", min = 0, max = 1, value = 0.7, step = 0.1),
                         actionButton("analyze_button", "Calculate Correlation")
                       ) #box
                ), #column
                column(width = 8,
                       box(
                         title = div("Heatmap", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         uiOutput("cor_output"),
                         uiOutput("v2_output"),
                         plotOutput("cor_plot"),
                         conditionalPanel(
                           condition = "output.cor_plot !== undefined && output.cor_plot !== null",                    
                           downloadButton("download_heatmap_pdf", "Download Heatmap (PDF)")
                         )
                       ) #box
                ) #column
              ) #fluidpage
      ),  
      ##################################################3
      ##########################################33
      
      
      tabItem(tabName = "tab5",
              fluidPage(
                titlePanel("Points and pseudoabsences"),
                fluidRow(
                  column(width = 4,
                         box(
                           title = div("Occurrences", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Aquí habrá información útil cuando se me ocurra algo porque ahorita ya tengo el cerebro fundido, molido y licuado.")),
                           width = NULL,
                           fileInput("occurrences", "Select occurrence points file (CSV):", accept = ".csv"),
                           fileInput("mask", "Select mask file (ASC):", accept = ".asc"),
                           textInput("num_points", "Number of random points:", value = "1000"),
                           textInput("output_name", "Database output name:", value = "Speciespointspa.csv"),
                           actionButton("run_script", "Run script")
                         ) #box 
                  ), #column
                  column(width = 8,
                         box(
                           title = "Pseudoabsences Results",
                           width = NULL,
                           plotOutput("abs_output"),
                           conditionalPanel(
                             condition = "output.abs_output !== undefined && output.abs_output !== null",   
                             downloadButton("download_pdfpseudo", "Download PDF"))
                         ), #box
                         box(
                           width = NULL,
                           leafletOutput("abs_output_inte")
                         )#box
                         
                  ) #column
                ) #fluidrow
              )
      ), #tabitem
      
      
      ####################333
      ###################33
      #######33
      
      tabItem(tabName = "tab6",
              fluidPage(
                titlePanel("biomod2"),
                fluidRow(
                  column(width = 4,
                         box(
                           title = div("Database repository", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Aquí habrá información útil cuando se me ocurra algo porque ahorita ya tengo el cerebro fundido, molido y licuado.")),
                           width = NULL,
                           fileInput("file", "Load Database"),
                           fileInput("layerFiles", "Select .asc files", multiple = TRUE, accept = ".asc")
                         ), #box1
                         box(
                           title = div("Configuration of models for niche analysis", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Aquí habrá información útil cuando se me ocurra algo porque ahorita ya tengo el cerebro fundido, molido y licuado.")),
                           width = NULL,
                           selectInput("modelSelection", "Select Models",
                                       choices = c('GLM','GBM','GAM','CTA','ANN','SRE','FDA','RF','MAXENT','MAXNET','MARS','XGBOOST'),
                                       multiple = TRUE),
                           selectInput("strategy_Selection", "Select Strategy",
                                       choices = c('random','k-fold','block','strat','env','user.defined'),
                                       multiple = FALSE),
                           selectInput("metricSelection", "Select Evaluation Metrics",
                                       choices = c('KAPPA','TSS','ROC','ACCURACY','BIAS','POD','FAR','POFD','SR','CSI','ETS','HK','HSS','OR','ORSS','BOYCE','MPA'),
                                       multiple = TRUE),
                           numericInput("dataSplit", "Data Split Percentage", value = 80),
                           numericInput("dataRep", "Number of Repetitions", value = 10),
                           sliderInput("threshold", "Selection Threshold", min = 0, max = 1, value = 0.4, step = 0.1),
                           selectInput("evalMetrics", "Select Evaluation Metrics",
                                       choices = c('KAPPA','TSS','ROC','ACCURACY','BIAS','POD','FAR','POFD','SR','CSI','ETS','HK','HSS','OR','ORSS','BOYCE','MPA'),
                                       multiple = TRUE),
                           actionButton("runBiomod", "Run biomod2 models")
                         ) #box2
                  ), #column
                  
                  column(width = 8,
                         box(
                           title = "Model Results",
                           width = NULL,
                           tabsetPanel(
                             tabPanel("Database", tableOutput("data_table")),
                             tabPanel("Model Output", verbatimTextOutput("modelOutput")),
                             tabPanel("Evaluation", 
                                      plotOutput("evalScoresPlot"),
                                      downloadButton("downloadEvalScoresPlotPDF", "Descargar PDF")),
                             tabPanel("Important Variables", 
                                      plotOutput("varImpBoxplot"),
                                      downloadButton("downloadVarImpBoxplotPDF", "Descargar PDF")),
                             tabPanel("Response Curves", 
                                      plotOutput("responseCurvesPlot"),
                                      downloadButton("downloadResponseCurvesPlotPDF", "Descargar PDF"),
                                      plotOutput("responseCurvesPlotMin"),
                                      downloadButton("downloadResponseCurvesPlotMinPDF", "Descargar PDF"),
                                      plotOutput("responseCurvesBivariatePlot"),
                                      downloadButton("downloadResponseCurvesBivariatePlotPDF", "Descargar PDF"))                    
                           ) #tabset
                         )) # column y box
                ) #fluidrow
              ) #fluidpage
      ), # tab      
      
      
      #################################
      #############################################3
      #######################################################3
      
      tabItem(tabName = "tab7",
              fluidPage(
                titlePanel("Load and Plot Maps"),
                column(width = 4,
                       box(
                         title = div("Attach the file to view", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         fileInput("file_maps2", "Select map file:",
                                   accept = c('.tiff','.tif', '.asc', '.bil')),
                         actionButton("load_leaflet_button_2", "Load Leaflet Map")
                       ) #box
                ), #column
                column(width = 4,
                       box(
                         title = div("Interactive Plot", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         leafletOutput("leaflet_map_2"))),
                column(width = 4,
                       box(
                         title = div("PDF preview", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         plotOutput("mapPlot_2"),
                         conditionalPanel(
                           condition = "output.mapPlot_2 !== undefined && output.mapPlot_2 !== null", 
                           downloadButton("download_pdf_button_2", "Download Map as PDF", disabled = TRUE))
                       ))
              ) #fluidpage
      ), #tabitem
      
      #################################
      #############################################3
      #######################################################3
      
      tabItem(tabName = "tab8",
              fluidPage(
                titlePanel("Partial ROC Analysis"),
                column(width = 4,
                       box(
                         title = div("Upload your databases", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         fileInput("sdm_mod", "Upload Prediction Raster (Raster file in .asc or .tif format)", accept = c('.tiff','.tif', '.asc')),
                         fileInput("occ_proc", "Upload Validation Data (CSV file)", accept = ".csv"),
                         numericInput("iter", "Number ofbootstrap iterations ", value = 500),
                         numericInput("omission", "Threshold", value = 5),
                         numericInput("randper", "Percent", value = 50),
                         actionButton("runButton", "Run Analysis"),
                       ) #box
                ), #column
                column(width = 8,
                       box(
                         title = "Results",
                         width = NULL,
                         tableOutput("summaryroc"),
                         dataTableOutput("resultsroc")
                       ) #box
                ) #column
              ) #fluidpage
      ), 
      
      
      #
      
      tabItem(tabName = "tab9",
              fluidPage(
                titlePanel("Remove urbanization"),
                column(width = 4,
                       box(
                         title = div("Environmental data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         fileInput("archivoUrban", "Select the urbanization file",
                                   accept = c('.tiff','.tif', '.asc', '.bil')),
                         fileInput("archivomodelado", "Select the Potential distribution map",
                                   accept = c('.tiff','.tif', '.asc', '.bil')),
                         textInput("nombreSalida", "Output file name"),
                         actionButton("ejecutar", "Run Analysis")
                       )
                ), #column
                column(width = 8,
                       box(
                         title = "Urbanization",
                         width = NULL,
                         leafletOutput("mapa_urban")
                       ),
                       box(
                         title = "Potencial distribution",
                         width = NULL,
                         leafletOutput("mapa_modelado")
                       ),
                       box(
                         title = "Result",
                         width = NULL,
                         leafletOutput("mapa_urbancapa")
                       )
                ) #column 8
              ) #fluidpage
      ),
      #            
      
      tabItem(tabName = "tab10",
              fluidPage(
                titlePanel("Calculate area"),
                column(width = 4,
                       box(
                         title = div("Data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         condition = "input.opcionAnalisis == 'Calculate area'",
                         fileInput("archivoRaster", "Select raster file"),
                         numericInput("umbralSuitability", "Suitability Threshold:", value = 0.7, min = 0, max = 1, step = 0.01),
                         actionButton("calcularArea", "Calculate Area of Suitability")
                       )
                ),
                column(width = 8,
                       box(
                         title = "Result",
                         width = NULL, 
                         verbatimTextOutput("Result")
                       ),
                )
              )
      ),
      
      #
      
      tabItem(tabName = "tab11",
              fluidPage(
                titlePanel("Gains and Losses Plot"),
                column(width = 4,
                       box(
                         title = div("Maps", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                         width = NULL,
                         fileInput("mapa_presente_input", "Load Present Map (asc)", accept = ".asc"),
                         fileInput("mapa_futuro_input", "Load Future Map (asc)", accept = ".asc"),
                         actionButton("run_analysis_btn", "Run Analysis")
                       )
                ),
                column(width = 4,
                       box(
                         width = NULL,
                         title = "Gains Plot",
                         status = "primary",
                         plotOutput("Gains_plot"),
                         conditionalPanel(
                           condition = "output.Gains_plot !== undefined && output.Gains_plot !== null",
                           downloadButton("download_Gains", "Download Gains Map")
                         )
                       )
                ),#column
                column(width = 4,
                       box(
                         width = NULL,
                         title = "Losses Plot",
                         status = "danger",
                         plotOutput("Losses_plot"),
                         conditionalPanel(
                           condition = "output.Losses_plot !== undefined && output.Losses_plot !== null",
                           downloadButton("download_Losses", "Download Losses Map")
                         )
                       )
                ) #column
              )
      ),
      
      tabItem(tabName = "tab12",
              fluidPage(
                titlePanel("Niche Overlap Analysis via ENMTools"),
                fluidRow(
                  column(width = 4,
                         box(
                           title = div("Databases", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Aquí habrá información útil cuando se me ocurra algo porque ahorita ya tengo el cerebro fundido, molido y licuado.")),
                           width = NULL,
                           fileInput("sp1_enmtools", "Load Database for Species 1", accept = ".csv"),
                           fileInput("sp2_enmtools", "Load Database for Species 2", accept = ".csv"),
                           fileInput("layerFilesENM", "Select .asc files", multiple = TRUE, accept = ".asc"),
                           selectInput("model_niche", "Select Model (s)",
                                       choices = c('glm','gam','dm','bc','maxent'),
                                       multiple = TRUE)
                         ),
                         box(title = "Hypothesis testing",
                             width = NULL,
                             solidHeader = TRUE,
                             checkboxGroupInput("checkbox_opciones", "Select the analyzes to perform:",
                                                choices = list("Niche identity or equivalency test" = 1, "Background or similarity test (Asymmetric)" = 2, "Background or similarity test (Symmetric)" = 3),
                                                selected = 1),
                             selectInput("model_niche_s", "Select Model (s)",
                                         choices = c('glm','gam','dm','bc','maxent'),
                                         multiple = TRUE)
                         ), #bx
                         box(title = "Rangebreak tests",
                             width = NULL,
                             solidHeader = TRUE,
                             radioButtons("options_rblmodel", "Selecciona una opción:",
                                          choices = list("GLM" = 1, "GAM" = 2, "DM" = 3, "BC" = 4, "MAXENT" = 5),
                                          selected = 1)
                         ), #bx
                         box(
                           width = NULL,
                           solidHeader = TRUE,
                           actionButton("run_enmtools", "Run ENMTools")
                         ) #box
                  ), #columne
                  column(width = 8,
                         box(
                           title = "Model Results",
                           width = NULL,
                           tabsetPanel(
                             tabPanel("Model Summary",
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('glm')",
                                        box( title = "GLM model",
                                             width = NULL,
                                             plotOutput("modelPlot_glm"),
                                             downloadButton("downloadPdf_glmmodel", "Descargar PDF"),                
                                             verbatimTextOutput("modelSummary_glm")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('gam')",
                                        box( title = "GAM model",
                                             width = NULL,
                                             plotOutput("modelPlot_gam"), 
                                             downloadButton("downloadPdf_gammodel", "Descargar PDF"),                
                                             verbatimTextOutput("modelSummary_gam")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('dm')", 
                                        box( title = "DM model",
                                             width = NULL,
                                             plotOutput("modelPlot_dm"), 
                                             downloadButton("downloadPdf_dmmodel", "Descargar PDF"),                 
                                             verbatimTextOutput("modelSummary_dm")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('bc')",
                                        box( title = "BC model",
                                             width = NULL,
                                             plotOutput("modelPlot_bc"),      
                                             downloadButton("downloadPdf_bcmodel", "Descargar PDF"),            
                                             verbatimTextOutput("modelSummary_bc")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('maxent')",
                                        box( title = "MX model",
                                             width = NULL,
                                             plotOutput("modelPlot_mx"),      
                                             downloadButton("downloadPdf_mxmodel", "Descargar PDF"),            
                                             verbatimTextOutput("modelSummary_mx")
                                        )
                                      )
                                      
                                      
                             ),
                             tabPanel("Model responses",                           
                                      
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('glm')",
                                        box( title = "GLM model",
                                             width = NULL,
                                             plotOutput("resp_plot_glm"),
                                             plotOutput("test_data_glm")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('gam')",
                                        box( title = "GAM model",
                                             width = NULL,
                                             plotOutput("resp_plot_gam"),
                                             plotOutput("test_data_gam")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('dm')",
                                        box( title = "DM model",
                                             width = NULL,
                                             plotOutput("resp_plot_dm"),
                                             plotOutput("test_data_dm")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('bc')",
                                        box( title = "BC model",
                                             width = NULL,
                                             plotOutput("resp_plot_bc"),
                                             plotOutput("test_data_bc")
                                        )
                                      ),
                                      conditionalPanel(
                                        condition = "input.model_niche.includes('maxent')",
                                        box( title = "MX model",
                                             width = NULL,
                                             plotOutput("resp_plot_mx"),
                                             plotOutput("test_data_mx")
                                        )
                                      )
                             ),
                             
                             tabPanel("Points",         
                                      tags$h3(style = "color: black; font-size: 16px;", "Species 1"),
                                      leafletOutput("map_sp1"),         
                                      tags$h3(style = "color: black; font-size: 16px;", "Species 2"),
                                      leafletOutput("map_sp2")),
                             
                             
                             tabPanel("Hypothesis testing",
                                      conditionalPanel(
                                        condition = "input.checkbox_opciones.includes('1')",
                                        box( title = "MX model",
                                             width = NULL,
                                             plotOutput("plot_idtest"),                
                                             verbatimTextOutput("summary_idtest")
                                        ) #box
                                      ), #conditionalpanel
                                      
                                      conditionalPanel(
                                        condition = "input.checkbox_opciones.includes('2')",
                                        box( title = "MX model",
                                             width = NULL,
                                             plotOutput("plot_bctest"),                
                                             verbatimTextOutput("summary_bctest")
                                        ) #box
                                      ), #conditionalpanel
                                      
                                      conditionalPanel(
                                        condition = "input.checkbox_opciones.includes('2')",
                                        box( title = "MX model",
                                             width = NULL,
                                             plotOutput("plot_sym"),                
                                             verbatimTextOutput("summary_sym"),
                                        ) #box
                                      ) #conditionalpanel
                             ),
                             tabPanel("Ecospat test",                           
                                      plotOutput("plot1"),
                                      downloadButton("downloadPdf_ecospat", "Descargar PDF"),
                                      verbatimTextOutput("summary_nicheover"),
                                      plotOutput("plot_rbl"),        
                                      downloadButton("downloadPdf_rbl"),        
                                      verbatimTextOutput("summary_rbl")
                             )
                           )) #box
                  )# column 
                ) #fluidrow
              ) #fluidpage
      ) #tabpanel
      
      
      #
      
    )
  )
)


server <- function(input, output, session) {
  
  
  ##############################################################################################################3
  observeEvent(input$runOcc, {
    
    if (!is.character(input$species_name) || input$species_name == "") {
      showModal(modalDialog(
        title = "Error",
        "You need to fill in the fields to continue."
      ))
    } else {
      
      ########################modalito abierto
      
      showModal({
        modalDialog(
          "Corroborating the existence of records in the database...",
          footer = NULL
        )
      })
      
      ########################
      
      ####################INTERNET
      tryCatch({    
        
        ####################INTERNET
        
        
        dat <- occ_search(
          scientificName = input$species_name, 
          limit = input$limit_occ, 
          hasCoordinate = TRUE
        )
        
        
        #######################****************************************#############################3
        #######################****************************************#############################3
        #######################****************************************#############################3
        
        if (length(dat$data) == 0) {
          
          ################### modalito cierre
          removeModal()
          ###################
          
          showModal(
            modalDialog(
              title = "Error",
              "No records found."
              
            )
          )
        } else {
          
          ########################modalito abierto
          
          showModal({
            modalDialog(
              "Corroborating the existence of records in the database...",
              footer = NULL
            )
          })
          
          ########################
          
          #######################****************************************#############################3
          #######################****************************************#############################3
          ######################################*********************#########
          dat <- dat$data
          
          ###################### perro natasha
          
          if (!("coordinateUncertaintyInMeters" %in% colnames(dat))) {
            # Seleccionar las columnas si existen
            ################### modalito cierre
            removeModal()
            ###################
            
            showModal(modalDialog(
              title = "Error",
              "One of the metadata used for data cleaning is not available. This is probably because there is a large amount of data on the matter, the data cannot be recorded, is not accurate or is very old data. The data cannot be processed beyond deleting records without coordinates. The corresponding database was saved in the working directory."
            ))
            dat_e <- dat %>%
              dplyr::select(species, decimalLongitude, 
                            decimalLatitude)
            
            dat_e <- dat_e %>%
              filter(!is.na(decimalLongitude)) %>%
              filter(!is.na(decimalLatitude))
            
            timestampe <- format(Sys.time(), "%Y%m%d%H%M%S")
            
            write.csv(dat_e, file = paste0("simple coordinates", "_", input$species_name, "_", timestampe , ".csv"), row.names = FALSE)
            
          } else {
            
            ########################modalito abierto
            
            removeModal()
            
            
            withProgress(message = 'Doing important stuff...', value = 0, {
              total_iterations <- 1
              total_progress <- 1
              # Aquí va el código para realizar el análisis
              # Actualiza el valor de la barra de progreso en porcentaje
              for (i in 1:total_iterations) {
                
                
                ########################
                
                #########33perro natasha
                
                
                columnas <- c("species", "decimalLongitude", "decimalLatitude",
                              "countryCode", "individualCount", "gbifID",
                              "family", "taxonRank", "coordinateUncertaintyInMeters",
                              "year", "basisOfRecord", "institutionCode", "datasetName")
                
                # Filtrar solo las columnas que existen
                columnas_existen <- columnas[ sapply(columnas, function(col) exists(col, where = dat)) ]
                
                # Seleccionar solo las columnas que existen en el dataframe
                dat <- dat %>%
                  dplyr::select(all_of(columnas_existen))
                
                incProgress(1/10, detail = "Analyzing...")
                
                dat <- dat %>%
                  filter(!is.na(decimalLongitude)) %>%
                  filter(!is.na(decimalLatitude))
                
                output$wmPlotleaf <- renderLeaflet({
                  leaflet() %>%
                    addProviderTiles("OpenStreetMap.Mapnik") %>%
                    addMarkers(data = dat,
                               lng = ~decimalLongitude,
                               lat = ~decimalLatitude,
                               popup = ~paste("Lat:", decimalLatitude, "<br>Lon:", decimalLongitude),
                               clusterOptions = markerClusterOptions())
                })
                
                wmPlot <- borders("world", colour = "gray50", fill = "gray50")
                output$wmPlot <- renderPlot({
                  ggplot() +
                    coord_fixed() +
                    wmPlot +
                    geom_point(data = dat,
                               aes(x = decimalLongitude, y = decimalLatitude),
                               colour = "darkred",
                               size = 3) +
                    theme_bw() 
                })
                
                
                dat_coordinates <- dat %>%
                  dplyr::select(species, decimalLongitude, decimalLatitude)
                
                dat$countryCode <-  countrycode(dat$countryCode, 
                                                origin =  'iso2c',
                                                destination = 'iso3c')
                
                incProgress(1/10, detail = "Analyzing...")
                
                incProgress(2/10, detail = "Analyzing...") 
                
                incProgress(2/10, detail = "Analyzing...")
                incProgress(1/10, detail = "Analyzing...")
                #flag problems
                
                dat <- data.frame(dat)
                flags <- clean_coordinates(x = dat, 
                                           lon = "decimalLongitude", 
                                           lat = "decimalLatitude",
                                           countries = "countryCode",
                                           species = "species",
                                           tests = c("capitals", "centroids",
                                                     "equal", "zeros", "countries")) # most test are on by default
                
                
                incProgress(1/10, detail = "Analyzing...")
                
                sumflag <- summary(flags)
                incProgress(1/10, detail = "Analyzing...")
                plotflags <- plot(flags, lon = "decimalLongitude", lat = "decimalLatitude")
                
                #Exclude problematic records
                dat_cl <- dat[flags$.summary,]
                
                #The flagged records
                dat_fl <- dat[!flags$.summary,]
                
                summaryTable <- data.frame(Resultado = names(sumflag), Valor = as.numeric(sumflag))
                
                ################### modalito cierre
                
                ###################
                
                
                output$plotflag_output <- renderPlot({plotflags})
                
                remove_plot <- dat_cl %>% 
                  mutate(Uncertainty = coordinateUncertaintyInMeters / 1000) %>% 
                  ggplot(aes(x = Uncertainty)) + 
                  geom_histogram() +
                  xlab("Coordinate uncertainty in meters") +
                  theme_bw()
                
                output$plot_remove <- renderPlot({remove_plot})
                
                
                Country_r <- table(dat_cl$countryCode)
                output$Countryr_R <- DT::renderDataTable({
                  data.frame(Country = names(Country_r), Amount_of_Records = as.numeric(Country_r)) %>%
                    DT::datatable(options = list(dom = 't', paging = FALSE, ordering = FALSE))
                })
                
                
                Yea_r <- table(dat_cl$year)
                output$Year_R <- renderTable({
                  data.frame(Year=names(Yea_r), Amount_of_Records=as.numeric(Yea_r))
                })
                
                output$country_select <- renderUI({
                  selectInput("country_selection", "Select a country:",
                              choices = c("All", unique(dat_cl$countryCode)),
                              selected = "All",
                              multiple = TRUE)
                })
                
                ############################################################ Guardar los archivos en la carpeta "output_files"
                ############################################################
                ############################################################
                timestamp2 <- format(Sys.time(), "%Y%m%d%H%M%S")
                out_dir <- paste0(input$species_name, "_files_", timestamp2)    
                
                
                clean_proj <- file.path(getwd(), out_dir)
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
                
                incProgress(1/10, detail = "Analyzing...")
                incProgress(total_progress, detail = "Proceso completado")
                
              }
            })
            # aqui termina progress
            ###################ahora aqui lo puse
            observeEvent(input$Remove_l_p_r, {
              
              
              #100 km
              dat_cl_uncertanity <- dat_cl %>%
                filter(coordinateUncertaintyInMeters / 1000 <= input$km | is.na(coordinateUncertaintyInMeters))
              
              # Remove unsuitable data sources, especially fossils 
              # which are responsible for the majority of problems in this case
              
              
              
              ################################year
              
              dat_cl_bof_ic_y <-       dat_cl_uncertanity %>%
                filter(year > input$Year_Y) 
              
              ####filtro geografico
              
              if ('Filter by latitude and longitude' %in% input$geographicfilter) {
                
                dat_cl_bof_ic_y_f_fin <- filter(dat_cl_bof_ic_y, decimalLatitude < input$study_area & decimalLongitude < input$study_long)
                
              } else {
                
                if ('Filter by country' %in% input$geographicfilter)
                  
                  # cambio aqui
                  if("All" %in% input$country_selection && length(input$country_selection) > 1) {
                    showModal(
                      modalDialog(
                        title = "Error",
                        "Sorry, if you select the 'All' option you cannot indicate countries to filter."
                      )
                    )
                    return() 
                  } else {
                    #cambio aqui
                    
                    if ('All' %in% input$country_selection) {
                      dat_cl_bof_ic_y_f_fin <- dat_cl_bof_ic_y
                    } else {      
                      
                      
                      selected_countries <- input$country_selection
                      sorted_countries <- sort(selected_countries)
                      dat_cl_bof_ic_y_f_fin <- filter(dat_cl_bof_ic_y, countryCode %in% sorted_countries)
                      
                      
                      
                      
                    }
                  } # ya por favor aqui esta all 
              }
              
              
              
              ################################Latitude
              #exclude based on study area
              
              
              c_f_coordinates <- dat_cl_bof_ic_y_f_fin %>%
                dplyr::select(species, decimalLongitude, decimalLatitude)
              colnames(c_f_coordinates) <- c("Species", "X", "Y")
              
              timestampe <- format(Sys.time(), "%Y%m%d%H%M%S")
              
              fil_cle_da <-paste0("Filtered and cleaned data_", input$species_name, input$km, input$Year_Y, "_", timestampe, ".csv")
              fil_cle_ocu <- paste0("Filtered and cleaned occurrences_", input$species_name, input$km, input$Year_Y, "_", timestampe, ".csv")         
              observe ({write.csv(dat_cl_bof_ic_y_f_fin, file =fil_cle_da, row.names = FALSE)})
              observe ({write.csv(c_f_coordinates, file =fil_cle_ocu, row.names = FALSE)})
              
              showModal(modalDialog(
                title = "Success",
                "Database created successfully!"
              ))      
              
              
            })
          } ##################añadido al cuadrado
        } ###################añadido lo añadi añadí aquí
        
      }, error = function(e) {
        # Error handling for a bad internet connection
        if (inherits(e, "error")) {
          
          showModal(
            modalDialog(
              title = "Error",
              paste("Something went wrong:", e$message),
              easyClose = TRUE,
              footer = NULL
            )
          )
        }
      }) #######3internet
    }###############################quetzal
  })
  
  #####################################################################33
  
  ## my own
  
  observeEvent(input$file_for_cleaning, {
    
    tryCatch({
      file_clean_mio1 <- input$file_for_cleaning
      filecleaningonly1 <- read.csv(file_clean_mio1$datapath)
      output$onlyclean_table <- renderUI({
        fluidPage(
          column(
            width = 12,
            h4("Tabla de datos limpios:"),
            div(style = "overflow-x: auto;", DT::dataTableOutput("table"))
          )
        )
      })
      
      output$table <- DT::renderDataTable({
        datatable(filecleaningonly1, 
                  options = list(scrollX = TRUE))
      })
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
  })
  
  
  observeEvent(input$check, {
    dataMatch <- reactiveVal(FALSE)
    cleanedFlag <- reactiveVal(FALSE)
    
    if (is.null(input$file_for_cleaning)) {
      showModal(modalDialog(
        title = "Error",
        "You need to upload a database to continue."
      ))
    } else {
      
      
      
      cleanedFlag <- reactiveVal(TRUE)
      observeEvent(input$file_for_cleaning, {
        file_clean_mio <-input$file_for_cleaning
        filecleaningonly <- read.csv(file_clean_mio$datapath)
        
        #############################################################################################
        #############################################################################################
        #############################################################################################
        
        
        if (!is.null(input$file_for_cleaning)) {
          filecleaningonly <- read.csv(input$file_for_cleaning$datapath)
          
          
          if (!is.character(input$LAT) || !is.character(input$LONG) || !is.character(input$SPEC) ||
              input$LAT == "" || input$LONG == "" || input$SPEC == "") {
            showModal(modalDialog(
              title = "Error",
              "You need to fill in the fields to continue."
            ))
          } else {
            
            
            if (input$LAT %in% colnames(filecleaningonly) && 
                input$LONG %in% colnames(filecleaningonly) && 
                input$SPEC %in% colnames(filecleaningonly)) {
              dataMatch(TRUE)
              shinyjs::enable("clean_my_odb")
            } else {
              dataMatch(FALSE)
              shinyjs::disable("clean_my_odb")
            }
          }}
      })
      
      output$status_message_display <- renderPrint({
        if (dataMatch()) {
          "The data match"
        } else {
          "The data does not match"
        }
      })
    }############################AQUIIIII FFFFFFFFFFFFFFFFFFFFFFFFF################
    
  })############################AQUIIIII FFFFFFFFFFFFFFFFFFFFFFFFF################
  
  ##############################3
  
  
  observeEvent(input$clean_my_odb, {
    tryCatch({ 
      if (!input$check) {
        showModal(modalDialog(
          title = "Error",
          "Before performing this action you need to verify that the data matches"
        ))
      } else {
        
        
        if (is.null(input$file_for_cleaning)) {
          showModal(modalDialog(
            title = "Error",
            "You need to upload a database to continue."
          ))
        } else {
          if (!is.character(input$LAT) || !is.character(input$LONG) || !is.character(input$SPEC) ||
              input$LAT == "" || input$LONG == "" || input$SPEC == "") {
            showModal(modalDialog(
              title = "Error",
              "You need to fill in the fields to continue."
            ))
          } else {
            
            
            ########################################################33
            
            file_clean_mio_2 <-input$file_for_cleaning
            filecleaningonly_2 <- read.csv(file_clean_mio_2$datapath)         
            
            timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
            out_base <- paste0(input$nameSPEC, "_", timestamp)
            out_dir <- paste0(input$cleaned_name, "_", timestamp)
            out_log <-  paste0(input$cleaned_name, "_log_", timestamp, ".txt")
            
            thin(
              filecleaningonly_2,
              lat.col = input$LAT,
              long.col = input$LONG,
              spec.col = input$SPEC,
              thin.par=as.numeric(input$km_redonda),
              reps=1,
              locs.thinned.list.return = FALSE,
              write.files = TRUE,
              max.files = 5,
              out.dir=out_dir,
              out.base = out_base,
              write.log.file = TRUE,
              log.file = out_log,
              verbose = TRUE)
            
            
            showModal(modalDialog(
              title = "Success",
              "Results have been saved."
            ))
            # aqui quite un parentesis y llave
          }
        }
      }##############################3acabas de poner esto añadido
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  })
  
  #######3333mywon mapa
  
  observeEvent(input$vis_map, {
    showModal(modalDialog(
      title = "Selecciona el archivo .csv",
      fileInput("mapFile", "Selecciona el archivo .csv"),
      footer = actionButton("selectviewButton", "View"),
      clickable = TRUE
    ))
  })
  
  observeEvent(input$selectviewButton, {
    removeModal()
    map_mywon <- input$mapFile
    df_map_mywon <- read.csv(map_mywon$datapath, stringsAsFactors = FALSE)
    
    # Seleccionar las columnas indicadas por el usuario
    df_map_mywon <- df_map_mywon[, c(input$SPEC, input$LONG, input$LAT)]
    
    # Renombrar las columnas
    colnames(df_map_mywon) <- c("Species", "Longitude", "Latitude")
    
    
    output$mywonPlotleaf <- renderLeaflet({
      leaflet() %>%
        addProviderTiles("OpenStreetMap.Mapnik") %>%
        addMarkers(data = df_map_mywon,
                   lng = ~Longitude,
                   lat = ~Latitude,
                   popup = ~paste("Lat:", Latitude, "<br>Lon:", Longitude),
                   clusterOptions = markerClusterOptions())
    })
  })
  
  ######33mywonmapa
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  
  
  observeEvent(input$load_leaflet_button, {
    #############Inicia aquí
    
    tryCatch({ 
      
      if (is.null(input$file_maps)) {
        showModal(modalDialog(
          title = "Error",
          "You need to upload a database to continue."
        ))
      } else {
        
        withProgress(message = 'Loading maps...', value = 0, {
          total_iterations_leaf1 <- 1
          total_progress_leaf1 <- 1
          # Aquí va el código para realizar el análisis
          # Actualiza el valor de la barra de progreso en porcentaje
          for (i in 1:total_iterations_leaf1) {
            incProgress(5/10, detail = "Loading for viewing...")
            
            ############pausa
            leaflet_data <- reactiveValues(map = NULL)
            
            output$leaflet_map <- renderLeaflet({
              leaflet_data$map
            })
            
            incProgress(5/10, detail = "Loading for viewing...")
            incProgress(total_progress_leaf1, detail = "Finished")
          }
        })
        
        
        output$mapPlot <- renderPlot({
          req(input$file_maps)
          
          withProgress(message = 'Loading maps...', value = 0, {
            total_iterations_leaf11 <- 1
            total_progress_leaf11 <- 1
            # Aquí va el código para realizar el análisis
            # Actualiza el valor de la barra de progreso en porcentaje
            for (i in 1:total_iterations_leaf11) {
              incProgress(5/10, detail = "Loading for viewing...")
              
              # Read raster file
              raster_file <- raster(input$file_maps$datapath)
              
              # Plot the map
              plot(raster_file)
              
              incProgress(5/10, detail = "Loading for viewing...")
              # If a Leaflet map is loaded, overlay it
              if (!is.null(leaflet_data$map)) {
                
                leafletProxy("leaflet_map") %>%
                  addRasterImage(raster_file)
                
                
              }
              incProgress(5/10, detail = "Loading for viewing...")
              incProgress(total_progress_leaf11, detail = "Finished")
            }
          })
        })
        
        #######Pausa2
        leaflet_data$map <- leaflet() %>%
          addTiles() %>%
          setView(0, 0, zoom = 1)
        
        ###pausa3 pausa 3
        observeEvent(input$file_maps, {
          shinyjs::toggleState("download_pdf_button", !is.null(input$file_maps))
        })
        
        output$download_pdf_button <- downloadHandler(
          filename = function() {
            paste(gsub("\\.[^.]*$", "", input$file_maps$name), ".pdf")
          },
          content = function(file) {
            pdf(file)
            plot(raster(input$file_maps$datapath))
            dev.off()
          }
        )
        
      }
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    #################3termina aqui leaf
  })
  
  
  ####################################--------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  
  
  
  
  ####################################################################################
  
  #correlation layers
  
  observeEvent(input$file_input, {
    
    tryCatch({ 
      file_list1 <- input$file_input$datapath
      names(file_list1) <- input$file_input1$name
      bioFinal <- stack(file_list1)
      
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  })
  
  observeEvent(input$analyze_button, {
    
    tryCatch({ 
      
      if (is.null(input$file_input)) {
        showModal(modalDialog(
          title = "Error",
          "You need to upload a database to continue."
        ))
      } else {
        
        file_list <- input$file_input$datapath
        names(file_list) <- input$file_input$name
        bioFinal <- stack(file_list)
        
        withProgress(message = 'Evaluating...', value = 0, {
          total_iterationsheat <- 1
          total_progressheat <- 1
          # Aquí va el código para realizar el análisis
          # Actualiza el valor de la barra de progreso en porcentaje
          for (i in 1:total_iterationsheat) {
            
            if (!is.null(bioFinal)) {
              incProgress(1/10, detail = "Evaluating...")
              cor_matrix <- raster.cor.matrix(bioFinal, method = "pearson")
              incProgress(1/10, detail = "Evaluating...")
              cor_plot_done <- raster.cor.plot(bioFinal)
              incProgress(3/10, detail = "Evaluating...")
              bioFinal2<-as.data.frame(bioFinal)
              incProgress(3/10, detail = "Evaluating...")
              v2 <- vifcor(bioFinal2, th = input$threshold_hm)
              
              ###
              output$cor_output <- renderUI({
                if (!is.null(cor_matrix)) {
                  fluidRow(
                    box( width=NULL, 
                         div(style="overflow-x: auto;", 
                             dataTableOutput("cor_table"))
                    )
                  )
                }
              })
              
              output$v2_output <- renderUI({
                if (!is.null(v2)) {
                  fluidRow(
                    box( width=NULL,
                         div(style="overflow-x: auto;", 
                             verbatimTextOutput("v2_text"))
                    )
                  )
                }
              })
              
              output$cor_table <- renderDataTable({
                if (!is.null(cor_matrix)) {
                  cor_matrix
                }
              })
              
              output$v2_text <- renderPrint({
                if (!is.null(v2)) {
                  v2
                }
              })
              
              ##############
              
              output$cor_plot <- renderPlot({
                if (!is.null(cor_plot_done)) {
                  plot(cor_plot_done$cor.heatmap)
                }
              })
              
              output$download_heatmap_pdf <- downloadHandler(
                filename = function() {
                  "heatmap.pdf"
                },
                content = function(file) {
                  pdf(file)
                  plot(cor_plot_done$cor.heatmap)
                  dev.off()
                }
              )
              
              
              
            }
            incProgress(2/10, detail = "Evaluating...")
            incProgress(total_progressheat, detail = "Finished")
            
          }
        })
        
      }
      
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
  })
  ###########################Correlation
  
  #Occurrence points and pseudousences generator
  data <- reactiveVal(NULL)
  layers <- reactiveVal(NULL)
  evaluations <- reactiveVal(NULL)
  varImportance <- reactiveVal(NULL)
  
  # Función para cargar la base de datos
  observeEvent(input$file, {
    
    tryCatch({ 
      file <- input$file
      data_raw <- read.csv(file$datapath)
      data(data_raw)
      output$data_table <- renderTable(data())
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  }) #inputfile
  
  
  observeEvent(input$file, {
    
    tryCatch({ 
      points <- read.csv(input$file$datapath, header = TRUE)
      data(points)
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  }) #input file datapoit
  
  observeEvent(input$addColumns, {
    
    tryCatch({ 
      if (!is.null(data())) {
        points <- data()
        points <- cbind(points, rep.int(1, nrow(points)))
        colnames(points) <- c("Species", "X", "Y", "Response")
        data(points)
      }
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  }) ###add columns
  
  
  
  # Occurrence points and pseudousences generator
  observeEvent(input$run_script, {
    
    tryCatch({ 
      
      withProgress(message = 'Generating the background data and creating the corresponding database...', value = 0, {
        total_iterations_leafps <- 1
        total_progress_leafps <- 1
        for (i in 1:total_iterations_leafps) {
          
          req(input$occurrences, input$mask, input$num_points, input$output_name)
          
          occurrences <- read.csv(input$occurrences$datapath)
          
          incProgress(2/10, detail = "Loading...")
          
          mask <- raster(input$mask$datapath)
          
          pseudoabsences <- randomPoints(mask, n = as.integer(input$num_points), ext = mask, extf = 1)
          
          incProgress(2/10, detail = "Loading...")
          
          pseudo_ab_plot <- ggplot(data = pseudoabsences, aes(x = x, y = y)) +
            geom_point()
          
          incProgress(2/10, detail = "Loading...")
          
          pa <- as.data.frame(pseudoabsences)
          occurrences$Response <- 1
          pa$Response <- 0
          incProgress(2/10, detail = "Loading...")
          
          pa2 <- cbind(Species = "Speciespoints", pa)
          colnames(pa2) <- c("Species", "X", "Y", "Response")
          combined_data <- rbind(occurrences, pa2)
          
          write.csv(combined_data, input$output_name)
          
          incProgress(2/10, detail = "Loading...")
          incProgress(total_progress_leafps, detail = "Finished")
        }
      })
      
      
      output$abs_output <- renderPlot({pseudo_ab_plot})
      
      output$abs_output_inte <- renderLeaflet({
        # Crear capas separadas para los puntos rojos y azules
        red_points <- combined_data[combined_data$Response == 1, ]
        blue_points <- combined_data[combined_data$Response == 0, ]
        
        # Crear el mapa con las capas
        map <- leaflet() %>%
          addTiles() %>%
          addCircleMarkers(data = red_points, ~X, ~Y, popup = ~as.character(Species), color = "#FF007F", group = "Presence points") %>%
          addCircleMarkers(data = blue_points, ~X, ~Y, popup = ~as.character(Species), color = "purple", group = "Pseudoabsences") %>%
          addLayersControl(overlayGroups = c("Presence points", "Pseudoabsences"), options = layersControlOptions(collapsed = FALSE))
        
        # Retornar el mapa
        return(map)
      })
      
      ########### cambio mapa pseudo
      output$download_pdfpseudo <- downloadHandler(
        filename = function() {
          "Pseudoabsences.pdf"
        },
        content = function(file) {
          ggsave(file, plot = pseudo_ab_plot, device = "pdf")
        }
      )
      ##########3 cambio mapa pseudo
      
      showModal(modalDialog(
        title = "Success",
        "The database has been generated and saved in the working directory."
      ))
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
  }) #points and pseudo
  
  
  #####################################
  # Biomod2 and more
  ####################################
  ####################################
  # Biomod2 and more
  
  # Load Database
  observeEvent(input$file, {
    tryCatch({  
      file <- input$file
      data_raw <- read.csv(file$datapath)
      data(data_raw)
      output$data_table <- renderTable(data())
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    }) #######trycatch
  })
  
  observeEvent(input$file, {
    tryCatch({  
      points <- read.csv(input$file$datapath, header = TRUE)
      data(points)
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    }) #######trycatch
  })
  
  observeEvent(input$addColumns, {
    tryCatch({  
      if (!is.null(data())) {
        points <- data()
        points <- cbind(points, rep.int(1, nrow(points)))
        colnames(points) <- c("Species", "X", "Y", "Response")
        data(points)
      }
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    }) #######trycatch
  })
  # Load .asc layers
  
  # Run Biomod2 models
  observeEvent(input$runBiomod, {
    tryCatch({  
      
      ########################33prueba cargando biomod2
      if (is.null(input$file) || is.null(input$layerFiles)) {
        showModal(modalDialog(
          title = "Error",
          "You need to upload a database to continue."
          
        ))
        
        
      } else {
        
        
        envtList <- input$layerFiles$datapath
        envt.st <- rast(envtList)
        # Asignar los nombres originales a las capas cargadas
        names(envt.st) <- input$layerFiles$name
        layers(envt.st)
        #########################333prueba cargando biomod2
        
        withProgress(message = 'Running selected models...', value = 0, {
          total_iterationsbio <- 1
          total_progressbio <- 1
          # Aquí va el código para realizar el análisis
          # Actualiza el valor de la barra de progreso en porcentaje
          for (i in 1:total_iterationsbio) {
            
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
              incProgress(1/10, detail = "Running selected models...")
              # Crear opciones de modelado por defecto
              
              
              # Run Biomod2 models con las opciones seleccionadas
              MyBiomodModelOut <- BIOMOD_Modeling(
                bm.format = bmData,
                modeling.id = 'AllModels',
                models = input$modelSelection,
                CV.strategy = input$strategy_Selection,
                CV.nb.rep = input$dataRep,
                CV.perc = 0.8,
                bm.options = NULL,
                nb.rep = input$dataRep,
                data.split.perc = input$dataSplit,
                metric.eval = input$metricSelection,
                var.import = 3,
                do.full.models = TRUE,
                scale.models = FALSE,
                seed.val = 42,
                nb.cpu = 10
              )
              incProgress(1/10, detail = "Running selected models...")
              # Project single models
              myBiomodProj <- BIOMOD_Projection(bm.mod = MyBiomodModelOut,
                                                proj.name = 'Current',
                                                new.env = envt.st,
                                                models.chosen = 'all',
                                                build.clamping.mask = TRUE)
              incProgress(1/10, detail = "Running selected models...")
              # Model ensemble models
              myBiomodEM <- BIOMOD_EnsembleModeling(bm.mod = MyBiomodModelOut,
                                                    models.chosen = 'all',
                                                    em.by = 'all',
                                                    em.algo = c('EMmean', 'EMca'),
                                                    metric.select = c('TSS'),
                                                    metric.select.thresh = input$threshold,
                                                    metric.eval = c('KAPPA','TSS','ROC'),
                                                    var.import = 3,
                                                    seed.val = 42)
              
              incProgress(1/10, detail = "Running selected models...")
              mod_projPresEnsemble <- get_predictions(myBiomodProj);
              
              
              # --------------------------------------------------------------- #
              # Project ensemble models (from single projections)
              myBiomodEMProj <- BIOMOD_EnsembleForecasting(bm.em = myBiomodEM,
                                                           bm.proj = myBiomodProj,
                                                           models.chosen = 'all',
                                                           metric.binary = 'all',
                                                           metric.filter = 'all')
              
              
              incProgress(1/10, detail = "Running selected models...")
              # Obtener puntuaciones de Evaluation e Important Variables
              get_evaluations(MyBiomodModelOut)
              get_variables_importance(MyBiomodModelOut)
              
              # Guardar evaluaciones en un archivo CSV
              evaluations_df <- as.data.frame(get_evaluations(MyBiomodModelOut))
              write.csv(evaluations_df, file = "evaluations.csv", row.names = FALSE)
              incProgress(1/10, detail = "Running selected models...")
              # Guardar Important Variables en un archivo CSV
              varImportance_df <- as.data.frame(get_variables_importance(MyBiomodModelOut))
              write.csv(varImportance_df, file = "var_importance.csv", row.names = FALSE)
              
              # Almacenar los Results en los objetos reactivos
              evaluations(evaluations_df)
              varImportance(varImportance_df)
              incProgress(1/10, detail = "Running selected models...")
              # Obtener puntuaciones de Evaluation e Important Variables
              evaluations_df <- as.data.frame(get_evaluations(myBiomodEM))
              varImportance_df <- as.data.frame(get_variables_importance(myBiomodEM))
              incProgress(1/10, detail = "Running selected models...")
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
                incProgress(1/10, detail = "Running selected models...")
                # Show variables importance in console
                if (!is.null(varImportance())) {
                  cat("Variables Importance:\n")
                  print(varImportance())
                } else {
                  cat("Variables Importance: No data available\n")
                }
              })
              # Representar puntuaciones de Evaluation
              ##Aqui va progress biomod
              
              ##3
              
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
              
              ######## pdf biomod2
              
              # Agregar renderPlot y renderText para las otras salidas
              
              # Descargar PDF para el gráfico de Evaluation
              output$downloadEvalScoresPlotPDF <- downloadHandler(
                filename = function() {
                  "evalScoresPlot.pdf"
                },
                content = function(file) {
                  pdf(file)
                  print(bm_PlotEvalMean(bm.out = MyBiomodModelOut, dataset = 'calibration'))
                  dev.off()
                }
              )
              
              # Descargar PDF para el gráfico de Important Variables
              output$downloadVarImpBoxplotPDF <- downloadHandler(
                filename = function() {
                  "varImpBoxplot.pdf"
                },
                content = function(file) {
                  pdf(file)
                  print(bm_PlotVarImpBoxplot(bm.out = MyBiomodModelOut, group.by = c('full.name', 'PA', 'algo')))
                  dev.off()
                }
              )
              
              # Descargar PDF para el gráfico de Response Curves
              output$downloadResponseCurvesPlotPDF <- downloadHandler(
                filename = function() {
                  "responseCurvesPlot.pdf"
                },
                content = function(file) {
                  pdf(file)
                  mods <- get_built_models(MyBiomodModelOut, run = 'RUN1')
                  bm_PlotResponseCurves(MyBiomodModelOut, mods, fixed.var = 'median')
                  dev.off()
                }
              )
              
              # Descargar PDF para el gráfico de Response Curves Min
              output$downloadResponseCurvesPlotMinPDF <- downloadHandler(
                filename = function() {
                  "responseCurvesPlotMin.pdf"
                },
                content = function(file) {
                  pdf(file)
                  mods <- get_built_models(MyBiomodModelOut, run = 'RUN1')
                  bm_PlotResponseCurves(MyBiomodModelOut, mods, fixed.var = 'min')
                  dev.off()
                }
              )
              
              # Descargar PDF para el gráfico de Response Curves Bivariate
              output$downloadResponseCurvesBivariatePlotPDF <- downloadHandler(
                filename = function() {
                  "responseCurvesBivariatePlot.pdf"
                },
                content = function(file) {
                  pdf(file)
                  mods <- get_built_models(MyBiomodModelOut, full.name = 'allData_RUN2_RF')
                  bm_PlotResponseCurves(MyBiomodModelOut, mods, fixed.var = 'median', do.bivariate = TRUE)
                  dev.off()
                }
              )
              
              incProgress(1/10, detail = "Running selected models...")
              incProgress(total_progressbio, detail = "Finished")
              
            }
          }
        })
        ########3
        
        
      } #########añadido aqui este añadido este biomod2
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    }) #######trycatch
  })
  
  
  
  
  ####################################--------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  
  
  
  
  
  
  observeEvent(input$load_leaflet_button_2, {
    #############Inicia aqui
    tryCatch({ 
      
      if (is.null(input$file_maps2)) {
        showModal(modalDialog(
          title = "Error",
          "You need to upload a database to continue."
        ))
      } else {
        
        showModal({
          modalDialog(
            "Loading for viewing...",
            footer = NULL
          )
        })
        
        ############pausa
        leaflet_data_2 <- reactiveValues(map = NULL)
        
        output$leaflet_map_2 <- renderLeaflet({
          leaflet_data_2$map
        })
        
        output$mapPlot_2 <- renderPlot({
          req(input$file_maps2)
          
          # Read raster file
          raster_file2 <- raster(input$file_maps2$datapath)
          
          # Plot the map
          plot(raster_file2)
          
          removeModal()
          
          # If a Leaflet map is loaded, overlay it
          if (!is.null(leaflet_data_2$map)) {
            showModal({
              modalDialog(
                "Getting the interactive map...",
                footer = NULL
              )
            })
            leafletProxy("leaflet_map_2") %>%
              addRasterImage(raster_file2)
            removeModal()
          }
        })
        
        #######Pausa2
        leaflet_data_2$map <- leaflet() %>%
          addTiles() %>%
          setView(0, 0, zoom = 1)
        
        ###pausa3 pausa 3
        observeEvent(input$file_maps2, {
          shinyjs::toggleState("download_pdf_button_2", !is.null(input$file_maps2))
        })
        
        output$download_pdf_button_2 <- downloadHandler(
          filename = function() {
            paste(gsub("\\.[^.]*$", "", input$file_maps2$name), ".pdf")
          },
          content = function(file) {
            pdf(file)
            plot(raster(input$file_maps2$datapath))
            dev.off()
          }
        )
        
      }
      
      
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    #################3termina aqui leaf
  })
  
  
  
  
  
  ####################################--------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  ####################################-------------------------------------------------
  
  
  # Remove urbanization
  observeEvent(input$ejecutar, {
    
    tryCatch({ 
      
      withProgress(message = 'Loading maps...', value = 0, {
        total_iterationsurb <- 1
        total_progressurb <- 1
        # Aquí va el código para realizar el análisis
        # Actualiza el valor de la barra de progreso en porcentaje
        for (i in 1:total_iterationsurb) {
          
          incProgress(1/10, detail = "Ploting...")
          
          req(input$archivoUrban)
          req(input$archivomodelado)
          req(input$nombreSalida)
          archivoUrban <- input$archivoUrban$datapath
          archivomodelado <- input$archivomodelado$datapath
          nombreSalida <- input$nombreSalida
          incProgress(2/10, detail = "Ploting...")
          
          urbancapa <- raster(archivoUrban)
          modelado <- raster(archivomodelado)
          modeladourbancapa <- merge(urbancapa, modelado)
          incProgress(2/10, detail = "Ploting...")
          
          plot(modeladourbancapa)
          writeRaster(modeladourbancapa, filename = paste0(nombreSalida, ".asc"))
          
          incProgress(2/10, detail = "Ploting...")
          
          ###
          
          output$mapa_urbancapa <- renderLeaflet({
            leaflet() %>%
              addTiles() %>%
              addRasterImage(modeladourbancapa, opacity = 0.8) %>%
              setView(lng = -90, lat = 30, zoom = 3)
          })
          incProgress(1/10, detail = "Ploting...")
          output$mapa_urban <- renderLeaflet({
            leaflet() %>%
              addTiles() %>%
              addRasterImage(urbancapa, opacity = 0.8) %>%
              setView(lng = -90, lat = 30, zoom = 3)
          })
          incProgress(1/10, detail = "Ploting...")
          output$mapa_modelado <- renderLeaflet({
            leaflet() %>%
              addTiles() %>%
              addRasterImage(modelado, opacity = 0.8) %>%
              setView(lng = -90, lat = 30, zoom = 3)
          })
          ###
          incProgress(1/10, detail = "Ploting...")
          incProgress(total_progressurb, detail = "Proceso completado")
          
        }
      })
      
      showModal(modalDialog(
        title = "Success",
        "Database created successfully!"
      )) 
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  })
  
  #############################3 remove urban
  
  # Calculate Area
  observeEvent(input$calcularArea, {
    
    tryCatch({ 
      
      req(input$archivoRaster)
      withProgress(message = 'Calculating...', value = 0, {
        total_iterationsarea <- 1
        total_progressarea <- 1
        # Aquí va el código para realizar el análisis
        # Actualiza el valor de la barra de progreso en porcentaje
        for (i in 1:total_iterationsarea) {
          
          archivoRaster <- input$archivoRaster$datapath
          umbralSuitability <- input$umbralSuitability
          
          incProgress(2/10, detail = "Calculating...")
          
          rasterData <- raster(archivoRaster)
          
          incProgress(2/10, detail = "Calculating...")
          rasterData[rasterData <= umbralSuitability] <- NA
          
          cell_size <- area(rasterData, na.rm = TRUE, weights = FALSE)
          
          incProgress(2/10, detail = "Calculating...")
          
          cell_size1 <- cell_size[!is.na(cell_size)]
          areaSuitability <- length(cell_size1) * median(cell_size1)
          
          incProgress(2/10, detail = "Calculating...")
          
          output$Result <- renderPrint({
            paste("Area of Suitability in km²:", areaSuitability)
          })
          
          incProgress(2/10, detail = "Calculating...")
          incProgress(total_progressarea, detail = "Proceso completado")
          
        }
      })
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  })
  
  
  ############################# present future
  
  
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
  
  
  #################################
  #############################################3
  #######################################################3
  ######################################### Partial roc
  
  observeEvent(input$runButton, {
    
    tryCatch({ 
      
      withProgress(message = 'Carrying out statistical evaluations...', value = 0, {
        total_iterationsroc <- 1
        total_progressroc <- 1
        # Aquí va el código para realizar el análisis
        # Actualiza el valor de la barra de progreso en porcentaje
        incProgress(1/10, detail = "Starting analysis...")
        
        # Coloca tu código para cargar los datos aquí
        test_data <- read.csv(input$occ_proc$datapath)
        test_data <- test_data[, -1]
        
        # Renombra la columna "X" a "longitude" y "Y" a "latitude"
        colnames(test_data)[colnames(test_data) == "X"] <- "longitude"
        colnames(test_data)[colnames(test_data) == "Y"] <- "latitude"
        
        continuous_mod <- raster(input$sdm_mod$datapath)
        
        incProgress(2/10, detail = "Data loaded...")
        
        analisisproc <- pROC(
          continuous_mod,
          test_data,
          n_iter = input$iter,
          E_percent = input$omission,
          boost_percent = input$randper,
          parallel = FALSE,
          ncores = 4,
          rseed = FALSE,
          sub_sample = FALSE,
          sub_sample_size = 10000
        )
        
        output$summaryroc <- renderUI({
          
          suroc<-analisisproc$pROC_summary
          suroc_df <- as.data.frame(t(suroc))
          
          tableroc <- suroc_df %>%
            gt() %>%
            gt_highlight_rows(rows = 1, font_weight = "normal")
          
          
          tableroc
        })
        
        output$resultsroc <- renderDataTable({
          analisisproc$pROC_results
        })
        
        incProgress(7/10, detail = "Analysis complete.")
      }) # withProgress
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong:", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    })
    
  }) # observeEvent
  
  
  #################################
  #############################################3
  #######################################################3
  ######################################### Partial roc
  
  
  #################################################################################################################
  #################################################ENMTools########################################################
  #################################################################################################################
  
  observeEvent(input$run_enmtools, {
    
    tryCatch({ 
      
      if (is.null(input$sp1_enmtools) || is.null(input$sp2_enmtools) || is.null(input$layerFilesENM) || is.null(input$model_niche) || length(input$model_niche) == 0 || is.null(input$options_rblmodel)) {
        showModal(modalDialog(
          title = "Error",
          "You need to fill out the required fields to continue."
        ))
        
      } else {
        
        withProgress(message = 'Loading maps...', value = 0, {
          total_iterationsurb <- 1
          total_progressurb <- 1
          # Aquí va el código para realizar el análisis
          # Actualiza el valor de la barra de progreso en porcentaje
          for (i in 1:total_iterationsurb) {
            
            incProgress(1/10, detail = "Ploting...")
            
            req(input$layerFilesENM)
            
            # Leer todos los archivos .asc seleccionados
            env <- lapply(input$layerFilesENM$datapath, terra::rast)
            
            # Apilar las capas raster en un objeto 'SpatRaster'
            env <- do.call(c, env)
            
            # Asignar nombres a las capas
            names(env) <- input$layerFilesENM$name
            
            env <- setMinMax(env)
            env <- check.env(env)
            
            incProgress(1/10, detail = "Ploting...")
            
            # Cargar el archivo csv
            datosBP_input <- input$sp1_enmtools
            datosBP <- read.csv(datosBP_input$datapath)
            
            
            # Filtrar las filas donde Response sea 0
            datos_filtradosPP <- subset(datosBP, Response == 1)
            
            # Renombrar las columnas a lon y lat
            names(datos_filtradosPP)[names(datos_filtradosPP) == "X"] <- "lon"
            names(datos_filtradosPP)[names(datos_filtradosPP) == "Y"] <- "lat"
            
            # Crear el objeto species para ENMTools
            sp1 <- enmtools.species(species.name = "sp1", 
                                    presence.points = vect(datos_filtradosPP[, c("lon", "lat")]))
            
            
            
            datos_filtradosBP <- subset(datosBP, Response == 0)
            names(datos_filtradosBP)[names(datos_filtradosBP) == "X"] <- "lon"
            names(datos_filtradosBP)[names(datos_filtradosBP) == "Y"] <- "lat"
            crs(sp1$presence.points) <- crs(env)
            sp1$range <- background.raster.buffer(sp1$presence.points, 50000, mask = env)
            
            
            background_sp <- SpatialPoints(coords = datos_filtradosBP[, c("lon", "lat")])
            
            crs(background_sp) <- crs(env)
            
            bp_spatvector <- as(background_sp, "SpatVector")
            
            sp1$background.points <- bp_spatvector
            sp1 <- check.species(sp1) 
            
            
            incProgress(1/10, detail = "Ploting...")
            
            
            
            ############3ESPECIE 2
            datosBP2_input <- input$sp2_enmtools
            datosBP2 <- read.csv(datosBP2_input$datapath)
            
            # Filtrar las filas donde Response sea 0
            datos_filtradosPP_2 <- subset(datosBP2, Response == 1)
            
            # Renombrar las columnas a lon y lat
            names(datos_filtradosPP_2)[names(datos_filtradosPP_2) == "X"] <- "lon"
            names(datos_filtradosPP_2)[names(datos_filtradosPP_2) == "Y"] <- "lat"
            
            # Crear el objeto species para ENMTools
            sp2 <- enmtools.species(species.name = "sp2", 
                                    presence.points = vect(datos_filtradosPP_2[, c("lon", "lat")]))
            
            
            
            datos_filtradosBP_2 <- subset(datosBP2, Response == 0)
            names(datos_filtradosBP_2)[names(datos_filtradosBP_2) == "X"] <- "lon"
            names(datos_filtradosBP_2)[names(datos_filtradosBP_2) == "Y"] <- "lat"
            crs(sp2$presence.points) <- crs(env)
            sp2$range <- background.raster.buffer(sp2$presence.points, 50000, mask = env)
            
            
            background_sp_2 <- SpatialPoints(coords = datos_filtradosBP_2[, c("lon", "lat")])
            
            crs(background_sp_2) <- crs(env)
            
            bp_spatvector_2 <- as(background_sp_2, "SpatVector")
            
            sp2$background.points <- bp_spatvector_2
            sp2 <- check.species(sp2) 
            
            incProgress(1/10, detail = "Ploting...")
            
            
            ##########
            
            ### sp1
            map <- leaflet() %>%
              # Añadir mapa base
              addProviderTiles("OpenStreetMap.Mapnik") %>%
              # Añadir el rango de la especie
              addRasterImage(sp1$range, colors = "green", opacity = 0.5) %>%
              # Añadir los puntos de presencia
              addCircleMarkers(data = sp1$presence.points, color = "red", radius = 3, group = "Presence Points") %>%
              # Añadir los puntos de fondo
              addCircleMarkers(data = sp1$background.points, color = "blue", radius = 3, group = "Background Points") %>%
              # Añadir capas de control para activar/desactivar las capas
              addLayersControl(overlayGroups = c("Presence Points", "Background Points"),
                               options = layersControlOptions(collapsed = FALSE))
            
            
            output$map_sp1 <- renderLeaflet({    
              map
            })
            
            ###sp2
            map2 <- leaflet() %>%
              # Añadir map2a base
              addProviderTiles("OpenStreetMap.Mapnik") %>%
              # Añadir el rango de la especie
              addRasterImage(sp2$range, colors = "green", opacity = 0.5) %>%
              # Añadir los puntos de presencia
              addCircleMarkers(data = sp2$presence.points, color = "red", radius = 3, group = "Presence Points") %>%
              # Añadir los puntos de fondo
              addCircleMarkers(data = sp2$background.points, color = "blue", radius = 3, group = "Background Points") %>%
              #Añadir capas de control para activar/desactivar las capas
              addLayersControl(overlayGroups = c("Presence Points", "Background Points"),
                               options = layersControlOptions(collapsed = FALSE))
            
            
            output$map_sp2 <- renderLeaflet({    
              map2
            })
            
            ####################################3 modelos
            
            models_selected <- input$model_niche
            
            if ("glm" %in% models_selected) {
              sp1.glm <- enmtools.glm(species = sp1, env = env, test.prop = 0.2)
              output$modelPlot_glm <- renderPlot({ sp1.glm })
              output$modelSummary_glm <- renderPrint({ sp1.glm })
              output$resp_plot_glm <- renderPlot({sp1.glm$response.plots})
              output$test_data_glm <- renderPlot({
                visualize.enm(sp1.glm, env, plot.test.data = TRUE)
              })
              
              output$downloadPdf_glmmodel <- downloadHandler(
                filename = function() {
                  "GLM Model.pdf"
                },
                content = function(file) {
                  glm_plot_pdf<-plot(sp1.glm)
                  ggsave(file, plot = glm_plot_pdf, device = "pdf")
                }
              )
            }
            
            if ("gam" %in% models_selected) {
              sp1.gam <- enmtools.gam(sp1, env, test.prop = 0.2)
              output$modelPlot_gam <- renderPlot({ sp1.gam })
              output$modelSummary_gam <- renderPrint({ sp1.gam })
              output$resp_plot_gam <- renderPlot({sp1.gam$response.plots})
              output$test_data_gam <- renderPlot({
                visualize.enm(sp1.gam, env, plot.test.data = TRUE)
              })
              output$downloadPdf_gammodel <- downloadHandler(
                filename = function() {
                  "GAM Model.pdf"
                },
                content = function(file) {
                  gam_plot_pdf<-plot(sp1.gam)
                  ggsave(file, plot = gam_plot_pdf, device = "pdf")
                }
              )
              
            }
            
            if ("dm" %in% models_selected) {
              sp1.dm <- enmtools.dm(sp1, env, test.prop = 0.2)
              output$modelPlot_dm <- renderPlot({ sp1.dm })
              output$modelSummary_dm <- renderPrint({ sp1.dm })
              output$resp_plot_dm <- renderPlot({sp1.dm$response.plots})
              output$test_data_dm <- renderPlot({
                visualize.enm(sp1.dm, env, plot.test.data = TRUE)
              })
              
              output$downloadPdf_dmmodel <- downloadHandler(
                filename = function() {
                  "DM Model.pdf"
                },
                content = function(file) {
                  dm_plot_pdf<-plot(sp1.dm)
                  ggsave(file, plot = dm_plot_pdf, device = "pdf")
                }
              )
            }
            
            if ("bc" %in% models_selected) {
              sp1.bc <- enmtools.bc(sp1, env, test.prop = 0.2)
              output$modelPlot_bc <- renderPlot({ sp1.bc })
              output$modelSummary_bc <- renderPrint({ sp1.bc })
              output$resp_plot_bc <- renderPlot({sp1.bc$response.plots})
              output$test_data_bc <- renderPlot({
                visualize.enm(sp1.bc, env, plot.test.data = TRUE)
              })
              output$downloadPdf_bcmodel <- downloadHandler(
                filename = function() {
                  "BC Model.pdf"
                },
                content = function(file) {
                  bc_plot_pdf<-plot(sp1.bc)
                  ggsave(file, plot = bc_plot_pdf, device = "pdf")
                }
              )
            }
            
            if ("maxent" %in% models_selected) {
              sp1.mx <- enmtools.maxent(sp1, env, test.prop = 0.2)
              output$modelPlot_mx <- renderPlot({ sp1.mx })
              output$modelSummary_mx <- renderPrint({ sp1.mx })
              output$resp_plot_mx <- renderPlot({sp1.mx$response.plots})
              output$test_data_mx <- renderPlot({
                visualize.enm(sp1.mx, env, plot.test.data = TRUE)
              })
              output$downloadPdf_mxmodel <- downloadHandler(
                filename = function() {
                  "Maxent Model.pdf"
                },
                content = function(file) {
                  mx_plot_pdf<-plot(sp1.mx)
                  ggsave(file, plot = mx_plot_pdf, device = "pdf")
                }
              )
            }
            
            
            
            #######################3 modelos
            if (1 %in% input$checkbox_opciones) {
              # Realizar Niche identity or equivalency test
              id.glm <- identity.test(species.1 = sp1, species.2 = sp2, env = env, type = input$model_niche_s, nreps = 4)
              
              output$summary_idtest <- renderPrint({
                id.glm
              })
              # Mostrar los resultados en la UI
              output$plot_idtest <- renderPlot({
                id.glm
              })
            }
            
            if (2 %in% input$checkbox_opciones) {
              # Realizar Background or similarity test (Asymmetric)
              bg.bc.asym <- background.test(species.1 = sp1, species.2 = sp2, env = env, type = input$model_niche_s, nreps = 4, test.type = "asymmetric")
              
              output$summary_bctest <- renderPrint({
                bg.bc.asym
              })
              # # Mostrar los resultados en la UI
              output$plot_bctest <- renderPlot({
                bg.bc.asym
              })
            }
            
            if (3 %in% input$checkbox_opciones) {
              # Realizar Background or similarity test (Symmetric)
              bg.dm.sym <- background.test(species.1 = sp1, species.2 = sp2, env = env, type = input$model_niche_s, nreps = 4, test.type = "symmetric")
              output$summary_sym <- renderPrint({
                bg.dm.sym
              })
              # Mostrar los resultados en la UI
              output$plot_sym <- renderPlot({
                bg.dm.sym
              })
            }
            
            
            model_type_rbl <- switch(input$options_rblmodel,
                                     "1" = "glm",
                                     "2" = "gam",
                                     "3" = "dm",
                                     "4" = "bc",
                                     "5" = "maxent")
            
            rbl.glm <- rangebreak.linear(sp1, sp2, env, type = model_type_rbl, nreps = 4)
            
            
            esp.bg.sym <- enmtools.ecospat.bg(sp1, sp2, env, test.type = "symmetric")
            incProgress(1/10, detail = "Ploting...")
            
            output$summary_nicheover <- renderPrint({
              esp.bg.sym
            })
            
            
            # Mostrar los resultados en la UI
            output$plot1 <- renderPlot({
              print(esp.bg.sym)
            })
            
            
            
            
            output$downloadPdf_ecospat <- downloadHandler(
              filename = function() {
                paste("mi_plot_esp_bg_sym", Sys.Date(), ".pdf", sep = "")
              },
              content = function(file) {
                # Abre el dispositivo gráfico PDF
                pdf(file)
                
                # Genera el gráfico
                plot(esp.bg.sym)
                
                # Cierra el dispositivo gráfico PDF
                dev.off()
              }
            )
            
            
            
            output$summary_rbl <- renderPrint({
              rbl.glm
            })
            
            
            # Mostrar los resultados en la UI
            output$plot_rbl <- renderPlot({
              rbl.glm
            })
            
            
            
            
            output$downloadPdf_rbl <- downloadHandler(
              filename = function() {
                paste("Rangebreak tests", Sys.Date(), ".pdf", sep = "")
              },
              content = function(file) {
                # Abre el dispositivo gráfico PDF
                pdf(file)
                
                # Genera el gráfico
                plot(rbl.glm)
                
                # Cierra el dispositivo gráfico PDF
                dev.off()
              }
            )
            
            incProgress(1/10, detail = "Ploting...")
            incProgress(total_progressurb, detail = "Proceso completado")
            
          }
        }) #withprogress
        
        
      } #upload
      
    }, error = function(e) {
      # Error handling for a bad internet connection
      if (inherits(e, "error")) {
        
        showModal(
          modalDialog(
            title = "Error",
            paste("Something went wrong.", e$message),
            easyClose = TRUE,
            footer = NULL
          )
        )
      }
    }) #######trycatch
    
  })
  
  #################################################################################################################
  #################################################ENMTools########################################################
  #################################################################################################################
  
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)
