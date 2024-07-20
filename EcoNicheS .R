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
library(MIAmaxent)
library(shinyBS)
library(leaflet.extras)
library(geodata)
library(viridis)
library(ggthemes)
library(sp)
library(rgeos)
library(gdistance)


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
            menuItem(text = HTML("<i class='fa-solid fa-cloud-sun'></i> Environmental Data"), tabName = "tab2"),
menuItem(text = HTML("<i class='fas fa-globe'></i> Occurrence processing"), tabName = "tab3",
        menuSubItem("Get and clean GBIF data", tabName = "subtab1"),
        menuSubItem("Clean my own database", tabName = "subtab2")),
menuItem(text = HTML("<i class='fas fa-map'></i> Load and Plot Maps"), tabName = "tab4"),
menuItem(text = HTML("<i class='fa-solid fa-clipboard-check'></i> Correlation layers"), tabName = "tab5"),
menuItem(text = HTML("<i class='fas fa-dot-circle'></i> Points and pseudoabsences"), tabName = "tab6"),
menuItem(text = HTML("<i class='fas fa-cogs'></i> biomod2"), tabName = "tab7"),
menuItem(text = HTML("<i class='fas fa-map'></i> Load and Plot Maps"), tabName = "tab8"),
menuItem(text = HTML("<i class='fas fa-chart-bar'></i> Partial ROC Analysis"), tabName = "tab9"),
menuItem(text = HTML("<i class='fa-solid fa-mountain-city'></i> Remove urbanization"), tabName = "tab10"),
menuItem(text = HTML("<i class='fa-solid fa-mountain-sun'></i> Calculate area"), tabName = "tab11"),
menuItem(text = HTML("<i class='fas fa-chart-line'></i> Gains and Losses Plot"), tabName = "tab12"),
menuItem(text = HTML("<i class='fa-solid fa-mountain'></i> ENMTools"), tabName = "tab13"),
menuItem(text = HTML("<i class='fa-solid fa-route'></i> Connectivity"), tabName = "tab14")
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
          img(src = "https://armandosunny.weebly.com/uploads/9/8/0/6/98067990/published/logo-shiny2.png?1721439587", height = "250px",  style = "display: block; margin: 0 auto;"),
          p("Thanks for using our app! We hope you enjoy your experience.", style = "font-size: 36px; text-align: center;font-family: Arial;"),
          p("Please cite as:", style = "font-size: 24px; text-align: center;font-weight: bold; font-family: Arial;"),
          p("Marmolejo C, Bolom-Huet R, López-Vidal R, Díaz-Sánchez LE, Sunny A (2024). EcoNicheS: Empowering Ecological Niche Modeling Analysis with Shinydashboard and R Package. GitHub. https://github.com/armandosunny/EcoNicheS", style = "font-size: 16px; text-align: center;font-family: Arial;")
## creo que estos parentesis de abajo son los que cierran el tab
)
),
#############3333


            tabItem(tabName = "tab2",
                    fluidPage(
                        titlePanel("Environmental Data"),
                        column(width = 4,
                               box(
                                   title = "Environmental variables", 
                                   width = NULL,
  radioButtons("options_env_mode", div("Select a work method", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Choose a method to download WorldClim data for the geographic area of ​​interest or select the last option to provide your own data.")), choices = list("Worldclim Global" = 1, "Worldclim by Country" = 2, "Interactive map" = 3, "Use my own files" = 4), selected = 1),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 2",
                                       textInput("country_env", div("Country of interest", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Only names in English, written with upper or lower case, are accepted.")))
                                   ),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 1 || input.options_env_mode == 2 || input.options_env_mode == 3",
                                   selectInput("varclim_options", div("Select environmental variables", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "These are the WorldClim monthly average climate data. Please refer to the user manual to see its description and units.")),
                                               choices = list("tmin", "tmax", "tavg", "prec", "wind", "vapr", "bio"), multiple=FALSE),
                                   radioButtons("resoltion_env", div("Spatial Resolution (minutes of a degree)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please refer to the user manual to see its description.")),
                                                choices = list("10" = 1, "5" = 2, "2.5" = 3, "0.5" = 4), selected = 1))
                               ), #box
                               box(
                                   title = div("Edition and storage", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "You can crop the area contained in your environmental files or work with the files without editing them.")),
                                   width = NULL,
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 1",
                                       radioButtons("options_crop_global", div("Select an editing/cropping method", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Using longitude and latitude requires that you know their maximum values ​​or values ​​within the geographic area.")),
                                                    choices = list("Get the data without editing" = 1, "Use longitude and latitude" = 2), selected = 1)),

                                   conditionalPanel(
                                       condition = "input.options_env_mode == 2",
                                       radioButtons("options_crop", div("Select an editing/cropping method", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Using longitude and latitude requires that you know their maximum values ​​or values ​​within the geographic area. The mask file and shape files are created with other apps. Remember that to crop with a shapefile you need to upload all the related files, even if they have different extensions.")),
                                                    choices = list("Get the data without editing" = 1, "Use longitude and latitude" = 2, "Use a mask(.asc)" = 3), selected = 1)),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 4",
                                       radioButtons("options_crop_myown", div("Select an editing/cropping method", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Remember that to crop with a shapefile you need to upload all the related files, even if they have different extensions.")),
                                                    choices = list("Use a mask" = 1, "Use shape files" = 2), selected = 1)),
                                       conditionalPanel(
                                           condition = "input.options_crop == 2 && input.options_env_mode == 2|| input.options_crop_global == 2 && input.options_env_mode == 1",
                                           numericInput("xmin", "Minimum longitude (xmin, west)", value =-10),
                                           numericInput("xmax", "Maximum longitude (xmax, east)", value =17),
                                           numericInput("ymin", "Minimum latitude (ymin, south)", value =39),
                                           numericInput("ymax", "Maximum latitude (ymax, north)", value =48)
                                       ),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 1 && input.options_crop_global == 1 || input.options_env_mode == 2 && input.options_crop == 1",
                                       radioButtons("save_data", div("Data saving", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This option will automatically save the downloaded layers in .asc format along with their complementary files to your working directory. You can also choose not to save the data if you are just exploring your data or the options that EcoNicheS offers.")),
                                                    choices = list("Save layers" = 1, "Do not save" = 2), selected = 1)),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 1 && input.options_crop_global == 2 || input.options_env_mode == 2 && input.options_crop == 2",
                                       radioButtons("save_data_env", div("Data saving", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This option will automatically save the downloaded layers in .asc format along with their complementary files to your working directory. You can also choose to save only the edited layers or not save the data if you are just exploring your data or the options that EcoNicheS offers.")),
                                                    choices = list("Save all layers" = 1, "Save edited layers" = 2, "Do not save" = 3), selected = 1)),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 3",
                                       radioButtons("save_data_env_inter", div("Data saving", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This option will automatically save the downloaded layers in .asc format along with their complementary files to your working directory. You can also choose not to save the data if you are just exploring your data or the options that EcoNicheS offers.")),
                                                    choices = list("Save layers" = 1, "Do not save" = 2), selected = 1)),
                                       conditionalPanel(
                                           condition = "input.options_env_mode == 1 && input.save_data == 1 && input.options_crop_global == 1 || input.options_env_mode == 1 && input.save_data_env == 1 && input.options_crop_global == 2 ",
                                       textInput("identifier_env", div("Identifier", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please enter some useful identifier for you. This helps us to store the data in order and avoid its loss.")))),
                                       conditionalPanel(
                                           condition = "input.options_env_mode == 1 && input.options_crop_global == 2 && input.save_data_env == 1 || input.options_env_mode == 1 && input.options_crop_global == 2 && input.save_data_env == 2",
                                       textInput("identifier_env_crop", div("Identifier Edited Files", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please enter some useful identifier for you. This helps us to store the data in order and avoid its loss.")))),

                                       conditionalPanel(
                                           condition = "input.options_env_mode == 2 && input.save_data == 1 && input.options_crop == 1 || input.options_env_mode == 2 && input.save_data_env == 1 && input.options_crop == 2",
                                       textInput("identifier_country", div("Identifier", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please enter some useful identifier for you. This helps us to store the data in order and avoid its loss.")))),
                                       conditionalPanel(
                                           condition = "input.options_env_mode == 2 && input.options_crop == 2 && input.save_data_env == 1 || input.options_env_mode == 2 && input.options_crop == 2 && input.save_data_env == 2",
                                       textInput("identifier_country_crop", div("Identifier Edited Files", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please enter some useful identifier for you. This helps us to store the data in order and avoid its loss.")))),
                                       conditionalPanel(
                                           condition = "input.options_env_mode == 3 && input.save_data_env_inter == 1",
                                       textInput("identifier_interactive", div("Identifier Edited Files", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please enter some useful identifier for you. This helps us to store the data in order and avoid its loss.")))),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 1 && input.options_crop_global == 1 || input.options_env_mode == 1 && input.options_crop_global == 2 || input.options_env_mode == 2 && input.options_crop == 1 || input.options_env_mode == 2 && input.options_crop == 2",
                                       actionButton("envRun", "Obtain data")),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 3",
                                       actionButton("envRun2", "Obtain data"))
                               ), #box

                               box(
                                   width = NULL,
                                   conditionalPanel(
                                       condition = "input.options_crop == 3",
            fileInput("mask_file_eco", div("Upload mask file (.asc)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the .asc file that will act as a mask to crop the layers downloaded from WorldClim.")), accept = ".asc"),
            actionButton("process_mask_eco", "Process and Mask Layers p")
),
                                   conditionalPanel(
                                       condition = "input.options_crop_myown == 1 && input.options_env_mode == 4",
 fileInput("layers_set", div("Upload environmental layers (.asc)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the layers in .asc format that you want to edit using another .asc file as a reference for cropping.")), multiple = TRUE, accept = ".asc"),
            fileInput("mask_file", div("Upload mask file (.asc)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the .asc file that will act as a mask to crop the layers.")), accept = ".asc"),
            actionButton("process_mask", "Process and Mask Layers")
),
                                   conditionalPanel(
                                       condition = "input.options_crop_myown == 2 && input.options_env_mode == 4",
                                   fileInput("shape_set", div("Upload shape files", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload all files related to the.shp file.")), multiple = TRUE),
                                   fileInput("maskCut", div("Upload environmental layers (.asc)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the layers in .asc format that you want to edit using another .asc file as a reference for cropping.")), accept = ".asc", multiple = TRUE),
              textInput("output_maskcut", div("Output Identifier", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please enter some useful identifier for you. This helps us to store the data in order and avoid its loss.")), value = "Edited-Crop"),
                                   actionButton("shape_cut", "Process and Mask Layers")
)
) #box
                        ), #column
                        column(width = 8,
                               box(
                                   width = NULL,
                                   title = div("Visualization", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "You will be able to see a graphical preview of the downloaded data through maps. In addition, here you can delimit the geographical area of ​​your interest through an interactive map if you select that option.")),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 1 && input.options_crop_global == 1 || input.options_env_mode == 1 && input.options_crop_global == 2",
                                       plotOutput("env_plot_all")),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 2 && input.options_crop == 3",
                                       plotOutput("env_plot_all_mask")),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 2 && input.options_crop == 1 || input.options_env_mode == 2 && input.options_crop == 2",
                                       plotOutput("env_plot_country")),
                                   conditionalPanel(
                                       condition = "input.options_crop == 2 && input.options_env_mode == 2",
                                       plotOutput("env_plot_crop")),
                                   conditionalPanel(
                                       condition = "input.options_crop_global == 2 && input.options_env_mode == 1",
                                       plotOutput("env_plot_crop_all")),
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 3",
                                       leafletOutput("map_envlayers") # Mapa interactivo para recortar
                                   ),    
                                   conditionalPanel(
                                       condition = "input.options_env_mode == 3",
                                       plotOutput("env_plot_crop_all_map")
                                   ),
                                   conditionalPanel(
                                       condition = "input.options_crop_myown == 1 && input.options_env_mode == 4",
                                       plotOutput("env_plot_mask_mo")),
                                   conditionalPanel(
                                       condition = "input.options_crop == 3 && input.options_env_mode == 2",
                                       plotOutput("env_plot_mask__eco")),
                                   conditionalPanel(
                                       condition = "input.options_crop_myown == 2 && input.options_env_mode == 4",
                                   plotOutput("cropshp_output", height = "800px"))
                               ) #box
                        ) #column
                    ) #fluipage
            ), #tabitem



########## environmental

tabItem(tabName = "subtab1",
        fluidPage(
          titlePanel("Get and clean GBIF data"),
          fluidRow(
            column(width = 4,
          box(
            title = div("Species Search", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is the species search engine that allows you to obtain data directly from GBIF. Make sure you enter the correct name composed of the genus and the species as you will not be able to cancel the action until the data search is complete.")),
        width = NULL,
            
            textInput("species_name",  div("Species scientific name", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Enter the scientific name of the species of interest with a space between the genus and the species. The search engine is not case sensitive."))),
            numericInput("limit_occ",  div("Data Limit", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "It is the amount of data that will be downloaded from GBIF. The download is carried out prioritizing the most current data in case the number entered does not cover all the records.")), value =1000),
            actionButton("runOcc", "Obtain occurrences")
          ), #box


## pls dios
# Quite el conditional panel un momento

        box(
         title = div("Filters", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "The raw data of the geographical distribution of the searched species is saved automatically, once you obtain the search results, you can filter it by geographical area and year in this section.")),
        width = NULL,
conditionalPanel(condition = "output.wmPlot === undefined || output.wmPlot === null",

"This box will display the filters available to clean the occurrence data once the data search is complete.",
             ),
conditionalPanel(
              condition = "output.wmPlot !== undefined && output.wmPlot !== null",

              numericInput("km", "Limit (km)", value = 100),
              numericInput("Year_Y", div("Year from which the information is desired", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Data older than the year entered will be deleted.")), value = 2000),
              selectInput("geographicfilter", div("Select a geographic filter type", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "You can limit the distribution data to the geographic area of ​​your interest using latitude and longitude data or using a country or set of countries of interest.")), choices = c('Filter by country', 'Filter by latitude and longitude'), multiple = TRUE),
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
            title = div("Visualization of Geographic distribution of the species", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Here you can see through maps and tables a summary of the distribution of the species of interest.")),
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
title = div("Clean data out of GBIF", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "In this section you can process the GBIF data using the spThin library. The data is filtered such that within a certain number of kilometers around there is only one record.")),
                     width = NULL,
                fileInput("file_for_cleaning", "Load Database with occurrences (.csv)", accept = ".csv"), 
                actionButton("vis_map", div("View on a map", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "PView presence data on a map before processing it."))),
                textInput("LAT", div("Column name with latitudes (Y)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Enter the name of the column in your file where the latitude data is located. Respect uppercase, lowercase, spaces and numbers."))),
                textInput("LONG", div("Column name with longitudes (X)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Enter the name of the column in your file where the longitude data is located. Respect uppercase, lowercase, spaces and numbers."))),
                textInput("SPEC", div("Column name with species name", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Enter the name of the column in your file where the name of your species is located. Respect uppercase, lowercase, spaces and numbers."))),
                textInput("nameSPEC", "Species name"),
                numericInput("km_redonda", div("Limit (km)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Number of kilometers around where you expect to filter to keep a single record.")), value = 1),
                textInput("cleaned_name", "Cleaned database output name:", value = "SpeciesOccurrences"),
                actionButton("check", div("Check that the data matches", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Please first use this button to verify that the requested data matches your database. Confirm the information provided if this is not the case."))
),
                verbatimTextOutput("status_message_display"),
                
                actionButton("clean_my_odb", "Clean database"),
                tags$script("shinyjs::disable(\"clean_my_odb\")")
                
            ) #box
), #column

            column(width = 8,
          box(
title = div("Visualization", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "View your data before processing it.")),
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

tabItem(tabName = "tab4",
        fluidPage(
          titlePanel("Load and Plot Maps"),
          column(width = 4,
                 box(
title = "Upload map for visualization",
                     width = NULL,
                   fileInput("file_maps", "Select map file:",
                             accept = c('.tiff','.tif', '.asc', '.bil')),
                   actionButton("load_leaflet_button", "Load Leaflet Map")
                 ) #box
                 ), #column
                 column(width = 4,
                        box(
title = div("Interactive Plot", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "In this section you can view your file on an interactive map after you have loaded the map.")),
                     width = NULL,
leafletOutput("leaflet_map"))),
                 column(width = 4,
                        box(
title = div("PDF preview", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "You will be able to see a visualization of the graph of your map, and you will also be able to download the same graph in pdf.")),
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
      
tabItem(tabName = "tab5",
        fluidPage(
          titlePanel("Correlation Layers"),
          column(width = 4,
                 box(
                   title = div("Obtain the Pearson correlation and Variance inflation factor", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "The raster layers are processed, the result allows you to discard highly correlated variables.")),
                   width = NULL,
                   fileInput("file_input", div("Upload the environmental variables", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Multiple file selection button, the allowed formats are '.tiff', '.tif', '.asc' and '.bil'.")), multiple = TRUE, accept = c('.tiff','.tif', '.asc', '.bil')),
                   sliderInput("threshold_hm", div("Umbral (th)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Correlation threshold above which the correlation between the variables will be determined.")), min = 0, max = 1, value = 0.7, step = 0.1),
                   actionButton("analyze_button", "Calculate Correlation")
                 ) #box
          ), #column
          column(width = 8,
                 box(
                   title = div("Heatmap", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "The heatmap graph will be shown here in addition to the complementary data that provides information about the variables with respect to them.")),
                   width = NULL,
                   plotOutput("cor_plot"),
                  uiOutput("cor_output"),
                 uiOutput("v2_output"),
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
            
    
tabItem(tabName = "tab6",
        fluidPage(
          titlePanel("Points and pseudoabsences"),
fluidRow(
  column(width = 4,
         box(
           title = div("Distribution base data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "In this section, pseudo-absences are generated from the distribution data. This data serves as background for niche modeling.")),
           width = NULL,
              fileInput("occurrences", div("Upload occurrence data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Provides the file with the points of presence of the species. The file must be processed and filtered if applicable, always in .csv format. For data obtained outside of EcoNiches, remember to edit the file so that the column names match those required for analyzes in the application. Visit the user manual for more information.")), accept = ".csv"),
              fileInput("mask", div("Upload an .asc file", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload any of the environmental layers relevant to your study. The accepted formats are '.tiff','.tif', '.asc' and '.bil'.")), accept = c('.tiff','.tif', '.asc', '.bil')),
              textInput("num_points", div("Number of random points", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Number of pseudo-absence data that will be generated. This data will be assigned a response, 0, while the original presence points will show the value 1 as a response. The execution time depends on the number entered, if you are carrying out tests we recommend carrying them out with small values.")), value = "1000"),
              textInput("output_name", div("Database output name", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Enter a valid name to save the database, a .csv file where, in addition to the original data, you will find the Pseudoabsences generated and the responses of both data. Doing this makes it easier to create and store the data.")), value = "Speciespointspa.csv"),
              actionButton("run_script", "Generate data")
         ) #box 
            ), #column
  column(width = 8,
         box(
           title = div("Pseudoabsences Results", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "In this section you can view the results with the data generated through maps.")),
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
      
      tabItem(tabName = "tab7",
              fluidPage(
                titlePanel("biomod2"),
          fluidRow(
            column(width = 4,
          box(
            title = div("Database repository", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Provides the databases necessary for ecological niche modeling. For more information click on the user manual.")),
        width = NULL,
                    fileInput("file", div("Presence - Pseudoabsence Data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the file generated in the previous section of EcoNiches (Points and Pseudoabsences). The points of presence with the generated pseudo-absences and their response in .csv format are required.")), accept = ".csv"),
            fileInput("layerFiles", div("Environmental variables", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload related environmental variables. In EcoNiches these are pre-processed in the 'Correlation Layers' section. The accepted formats are '.tiff','.tif', '.asc' and '.bil'.")), multiple = TRUE, accept = c('.tiff','.tif', '.asc', '.bil'))
), #box1
          box(
            title = div("Configuration of models for niche analysis", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Adjust the parameters for Ecological Niche Modeling. For more information and details visit the User Manual.")),
        width = NULL,
                    selectInput("modelSelection", div("Single Models", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Choose the models or algorithms used during the analysis and evaluation. These are the single models functions, for more information go to the User Manual and/or visit the biomod2 vignette on github.")),
                                choices = c('GLM','GBM','GAM','CTA','ANN','SRE','FDA','RF','MAXENT','MAXNET','MARS','XGBOOST'),
                                multiple = TRUE),
                    selectInput("strategy_Selection", div("Select Strategy", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Strategy used during the calibration and validation of the models, for more information go to the User Manual and/or visit the biomod2 vignette on github.")),
                                choices = c('random','k-fold','block','strat','env','user.defined'),
                                multiple = FALSE),
                    selectInput("metricSelection", div("Select Evaluation Metrics", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Model performance and accuracy evaluation metrics, for more information go to the User Manual and/or visit the biomod2 vignette on github.")),
                                choices = c('KAPPA','TSS','ROC'),
                                multiple = TRUE),
                    numericInput("dataSplit", div("Data Split Percentage", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Number of 'pieces' into which the data will be divided for the calibration of the models, for more information go to the User Manual and/or visit the biomod2 vignette on github.")), value = 80),
                    numericInput("dataRep", div("Number of Repetitions", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Repetitions applied for each of the selected models, for more information go to the User Manual and/or visit the biomod2 vignette on github.")), value = 10),
                    sliderInput("threshold", div("Selection Threshold", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Evaluation and selection threshold applied in the evaluation of the response of the models, for more information go to the User Manual and/or visit the biomod2 vignette on github.")), min = 0, max = 1, value = 0.4, step = 0.1),
                    selectInput("evalMetrics", div("Select Evaluation Metrics", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Adjust the parameters for Ecological Niche Modeling.")),
                                choices = c('KAPPA','TSS','ROC'),
                                multiple = FALSE),
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
                 downloadButton("downloadEvalScoresPlotPDF", "Download PDF")),
        tabPanel("Important Variables", 
                 plotOutput("varImpBoxplot"),
                 downloadButton("downloadVarImpBoxplotPDF", "Download PDF")),
        tabPanel("Response Curves", 
                 plotOutput("responseCurvesPlot"),
                 downloadButton("downloadResponseCurvesPlotPDF", "Download PDF"),
                 plotOutput("responseCurvesPlotMin"),
                 downloadButton("downloadResponseCurvesPlotMinPDF", "Download PDF"),
                 plotOutput("responseCurvesBivariatePlot"),
                 downloadButton("downloadResponseCurvesBivariatePlotPDF", "Download PDF"))                    
                  ) #tabset
                )) # column y box
              ) #fluidrow
      ) #fluidpage
), # tab      
  

#################################
#############################################3
#######################################################3

      tabItem(tabName = "tab8",
              fluidPage(
          titlePanel("Load and Plot Maps"),
          column(width = 4,
                 box(
title = "Upload map for visualization",
                     width = NULL,
    fileInput("file_maps2", "Select map file:",
              accept = c('.tiff','.tif', '.asc', '.bil')),
    actionButton("load_leaflet_button_2", "Load Leaflet Map")
                 ) #box
                 ), #column
                 column(width = 4,
                        box(
title = div("Interactive Plot", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "In this section you can view your file on an interactive map after you have loaded the map.")),
                     width = NULL,
leafletOutput("leaflet_map_2"))),
                 column(width = 4,
                        box(
title = div("PDF preview", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "You will be able to see a visualization of the graph of your map, and you will also be able to download the same graph in pdf.")),
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

tabItem(tabName = "tab9",
        fluidPage(
          titlePanel("Partial ROC Analysis"),
            column(width = 4,
                   box(
                     title = div("Upload your databases", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is a tooltip for the title")),
                     width = NULL,
              fileInput("sdm_mod", div("Upload prediction raster", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the consensus map obtained during the Ecological Niche Modeling. Visit the user manual for more information.")), accept = c('.tiff','.tif', '.asc')),
              fileInput("occ_proc", div("Upload Validation Data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the file that contains only the presence points of the species of interest. The format must be (.csv).")), accept = ".csv"),
              numericInput("iter", div("Number of bootstrap iterations ", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Iterations to be performed. Visit the user manual for more information.")), value = 500),
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
      
tabItem(tabName = "tab10",
        fluidPage(
          titlePanel("Remove urbanization"),
          column(width = 4,
                 box(
                   title = div("Environmental data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This section allows you to remove information from your environmental layers using another file as a reference. Below you can upload the necessary files.")),
                   width = NULL,
              fileInput("archivoUrban", div("Select the urbanization file", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This file should contain the data you want to remove. The allowed extensions are '.tiff','.tif', '.asc' and '.bil'.")),
              accept = c('.tiff','.tif', '.asc', '.bil')),
              fileInput("archivomodelado", div("Select the Potential distribution map", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "This is the file you want to be edited. The allowed extensions are '.tiff','.tif', '.asc' and '.bil'.")),
              accept = c('.tiff','.tif', '.asc', '.bil')),
              textInput("nombreSalida", div("Output file name", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "The edited version will be automatically saved in your working directory, enter the output name for easy storage and identification."))),
              actionButton("ejecutar", "Run Analysis")
            )
            ), #column
          column(width = 8,
                 box(
                   title = div("Urbanization", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Visualization of the map with urbanization data.")),
                   width = NULL,
              leafletOutput("mapa_urban")
                 ),
              box(
                title = div("Potencial distribution", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Visualization of the map with potential distribution data before editing.")),
                width = NULL,
              leafletOutput("mapa_modelado")
              ),
              box(
                title = div("Result", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Visualization of the edited raster layer.")),
                width = NULL,
              leafletOutput("mapa_urbancapa")
              )
            ) #column 8
          ) #fluidpage
        ),
      #            
      
tabItem(tabName = "tab11",
        fluidPage(
          titlePanel("Calculate area"),
          column(width = 4,
                 box(
                   title = div("Data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload a raster file for the calculation of the area of ​​suitability. The allowed formats are '.tiff', '.tif', '.asc', and '.bil'.")),
                   width = NULL,
              condition = "input.opcionAnalisis == 'Calculate area'",
              fileInput("archivoRaster", "Select raster file", accept = c('.tiff','.tif', '.asc', '.bil')),
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
      
tabItem(tabName = "tab12",
        fluidPage(
          titlePanel("Gains and Losses Plot"),
          column(width = 4,
                 box(
                   title = div("Environmental data from different periods", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "You can obtain prediction of environmental changes from different raster layers.")),
                   width = NULL,
              fileInput("mapa_presente_input", div("Load Present Map", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the file with the current environmental data. The allowed formats are '.tiff','.tif', '.asc' and '.bil'.")), accept = c('.tiff','.tif', '.asc', '.bil')),
              fileInput("mapa_futuro_input", div("Load Future Map", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the file with the environmental prediction data for the future. The allowed formats are '.tiff','.tif', '.asc' and '.bil'.")), accept = c('.tiff','.tif', '.asc', '.bil')),
              actionButton("run_analysis_btn", "Run Analysis")
            )
            ),
          column(width = 4,
                box(
                  width = NULL,
                  title = div("Gains Plot", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Through a graph you will observe the evaluation of the quantitative changes concerning the gains in the landscape.")),
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
                  title = div("Losses Plot", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Through a graph you will observe the evaluation of the quantitative changes concerning the losses in the landscape.")),
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

      tabItem(tabName = "tab13",
              fluidPage(
                titlePanel("Niche Overlap Analysis via ENMTools"),
                fluidRow(
                  column(width = 4,
                         box(
                           title = div("Upload data for analysis", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Provides the databases for the analysis and construction of models and niche overlap analysis through ENMTools.")),
                           width = NULL,
                           fileInput("sp1_enmtools", div("Distribution data of Species 1", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Database with the points of presence and pseudo-absences of species 1 in .csv format. The column names should be Species, X and Y. X refers to the longitude data and Y to the latitude data.")), accept = ".csv"),
                           fileInput("sp2_enmtools", div("Distribution data of Species 2", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Database with the points of presence and pseudo-absences of species 2 in .csv format. The column names should be Species, X and Y. X refers to the longitude data and Y to the latitude data.")), accept = ".csv"),
                           fileInput("layerFilesENM", div("Upload environmental layers", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the environmental variables relevant to your study (evaluated through correlation).")), multiple = TRUE, accept = c('.tiff','.tif', '.asc', '.bil')),
                    selectInput("model_niche", div("Select Model (s)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Model for the construction and projection of ENMs. You can select multiple models, the selection will apply to both species, since both data will be subjected to analysis and evaluation individually in the first instance.")),
                                choices = c('glm','gam','dm','bc','maxent'),
                                multiple = TRUE),
                    radioButtons("options_species_model", "Would you like to build an ENM for both species?",
                                 choices = list("Yes" = 1, "No, species 2 data is for overlap analysis only." = 2),
                                 selected = 1)
                         ),
                box(title = div("Hypothesis testing", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Different tests can be performed to evaluate niche overlap. For questions and details, go to the user manual or visit ENMTools on Github.")),
                           width = NULL,
                    solidHeader = TRUE,
                    checkboxGroupInput("checkbox_opciones", "Select the analyzes to perform:",
                                       choices = list("Niche identity or equivalency test" = 1, "Background or similarity test (Asymmetric)" = 2, "Background or similarity test (Symmetric)" = 3),
                                       selected = 1),
                     selectInput("model_niche_s", div("Select Model (s)", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Type of model to be built in the selected tests.")),
                                choices = c('glm','gam','dm','bc','maxent'),
                                multiple = TRUE)
), #bx
                box(title = div("Rangebreak tests", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Select a model to carry out the test according to Glor and Warren (2011). Please refer to the user manual or visit ENMTools on Github for questions and details.")),
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

###cambio aqui resultados
           column(width = 8,
                   box(
                     title = "Model Results",
                     width = NULL,
                     tabsetPanel(
                       tabPanel("Model Summary Sp1",
                                conditionalPanel(
                                  condition = "input.model_niche.includes('glm')",
                                  box( title = "GLM model",
                                       width = NULL,
                                       plotOutput("modelPlot_glm"),
                                       downloadButton("downloadPdf_glmmodel", "Download PDF"),                
                                       verbatimTextOutput("modelSummary_glm")
                                  )
                                ),
                                conditionalPanel(
                                  condition = "input.model_niche.includes('gam')",
                                  box( title = "GAM model",
                                       width = NULL,
                                       plotOutput("modelPlot_gam"), 
                                       downloadButton("downloadPdf_gammodel", "Download PDF"),                
                                       verbatimTextOutput("modelSummary_gam")
                                  )
                                ),
                                conditionalPanel(
                                  condition = "input.model_niche.includes('dm')", 
                                  box( title = "DM model",
                                       width = NULL,
                                       plotOutput("modelPlot_dm"), 
                                       downloadButton("downloadPdf_dmmodel", "Download PDF"),                 
                                       verbatimTextOutput("modelSummary_dm")
                                  )
                                ),
                                conditionalPanel(
                                  condition = "input.model_niche.includes('bc')",
                                  box( title = "BC model",
                                       width = NULL,
                                       plotOutput("modelPlot_bc"),      
                                       downloadButton("downloadPdf_bcmodel", "Download PDF"),            
                                       verbatimTextOutput("modelSummary_bc")
                                  )
                                ),
                                conditionalPanel(
                                  condition = "input.model_niche.includes('maxent')",
                                  box( title = "MX model",
                                       width = NULL,
                                       plotOutput("modelPlot_mx"),      
                                       downloadButton("downloadPdf_mxmodel", "Download PDF"),            
                                       verbatimTextOutput("modelSummary_mx")
                                  )
                                )
                                
                                
                       ),
                       tabPanel("Model responses Sp1",                           
                                
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
                       
                       
                       
                         tabPanel("Model Summary Sp2",
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('glm')",
                                    box( title = "GLM model",
                                         width = NULL,
                                         plotOutput("modelPlot_glm2"),
                                         downloadButton("downloadPdf_glmmodel2", "Download PDF"),                
                                         verbatimTextOutput("modelSummary_glm2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('gam')",
                                    box( title = "GAM model",
                                         width = NULL,
                                         plotOutput("modelPlot_gam2"), 
                                         downloadButton("downloadPdf_gammodel2", "Download PDF"),                
                                         verbatimTextOutput("modelSummary_gam2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('dm')", 
                                    box( title = "DM model",
                                         width = NULL,
                                         plotOutput("modelPlot_dm2"), 
                                         downloadButton("downloadPdf_dmmodel2", "Download PDF"),                 
                                         verbatimTextOutput("modelSummary_dm2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('bc')",
                                    box( title = "BC model",
                                         width = NULL,
                                         plotOutput("modelPlot_bc2"),      
                                         downloadButton("downloadPdf_bcmodel2", "Download PDF"),            
                                         verbatimTextOutput("modelSummary_bc2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('maxent')",
                                    box( title = "MX model",
                                         width = NULL,
                                         plotOutput("modelPlot_mx2"),      
                                         downloadButton("downloadPdf_mxmodel2", "Download PDF"),            
                                         verbatimTextOutput("modelSummary_mx2")
                                    )
                                  )
                                  
                                  
                         
                       ),
                       

                         tabPanel("Model responses Sp2",                           
                                  
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('glm')",
                                    box( title = "GLM model",
                                         width = NULL,
                                         plotOutput("resp_plot_glm2"),
                                         plotOutput("test_data_glm2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('gam')",
                                    box( title = "GAM model",
                                         width = NULL,
                                         plotOutput("resp_plot_gam2"),
                                         plotOutput("test_data_gam2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('dm')",
                                    box( title = "DM model",
                                         width = NULL,
                                         plotOutput("resp_plot_dm2"),
                                         plotOutput("test_data_dm2")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('bc')",
                                    box( title = "BC model",
                                         width = NULL,
                                         plotOutput("resp_plot_bc2"),
                                         plotOutput("test_data_bc")
                                    )
                                  ),
                                  conditionalPanel(
                                    condition = "input.model_niche.includes('maxent')",
                                    box( title = "MX model",
                                         width = NULL,
                                         plotOutput("resp_plot_mx2"),
                                         plotOutput("test_data_mx2")
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
                       conditionalPanel(
                         condition = "output.plo1 !== undefined && output.plot1 !== null",
                                downloadButton("downloadPdf_ecospat", "Download PDF")),
                                verbatimTextOutput("summary_nicheover"),
                                plotOutput("plot_rbl"),
                       conditionalPanel(
                         condition = "output.plot_rbl !== undefined && output.plot_rbl !== null",        
                                downloadButton("downloadPdf_rbl", "Download PDF")),        
                                verbatimTextOutput("summary_rbl")
                       )
                     )) #box
            )#column
###cambio aqui resultados
                ) #fluidrow
              ) #fluidpage
      ), #tabitem
      
      
      tabItem(tabName = "tab14",
fluidPage(
                titlePanel("Ecological connectivity"),
        fluidRow(
          column(width = 4,
            box(
              width = NULL,
              title = div("Environmental and biological data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Section where you can upload the geographic distribution data and the potential distribution map necessary to perform the connectivity analysis which allows you to obtain the ecological flow of your species. This analysis requires high computing power, see the user manual for more details.")), 
              fileInput("points_connectivity", div("Geographic distribution data", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the database with points of presence of your study species (.csv)")), accept = ".csv", multiple = FALSE),
              fileInput("pot_map_connectivity", div("Potential distribution map", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = "Upload the file with the environmental distribution of your species. It is the .tif file that contains the consensus of the models used in the biomod2 section. Please refer to the user manual for more details. Allowed formats are '.tiff','.tif', '.asc' and '.bil'.")), accept = c('.tiff','.tif', '.asc', '.bil')),
                    numericInput("number_points", "Data Split Percentage", value = 80),
              actionButton("run_connectivity", "Obtain")
            )
          ),
          column(width = 8,
            box(
              width = NULL,
              title = "Ecological Flow Map", 
              plotOutput("connectivity_output"),
                       conditionalPanel(
                         condition = "output.connectivity_output !== undefined && connectivity_output !== null", 
                   downloadButton("download_pdf_connec", "Download Map as PDF", disabled = TRUE))
            )
)
          )
        ) #deberia ser fluipage
      )      #tabitem14
      
    ) #tabitems
  )
)


server <- function(input, output, session) {

#### empieza environmental

    
    
    observeEvent(input$envRun, {

    if (input$options_env_mode == 1 && input$options_crop_global == 1 && input$save_data == 1 && !is.character(input$identifier_env) || input$options_env_mode == 1 && input$options_crop_global == 1 && input$save_data == 1 && input$identifier_env == "" || input$options_env_mode == 1 && input$options_crop_global == 2 && input$save_data_env == 1 && !is.character(input$identifier_env) || input$options_env_mode == 1 && input$options_crop_global == 2 && input$save_data_env == 1 && input$identifier_env == "") {
        showModal(modalDialog(
            title = "Error",
            "To continue you have to fill out the Identifier field, this helps to store the data in order and avoid its loss."
        ))
    } else {

        if (input$options_env_mode == 1 && input$options_crop_global == 2 && input$save_data_env == 1 && (!is.character(input$identifier_env_crop)) || input$options_env_mode == 1 && input$options_crop_global == 2 && input$save_data_env == 1 && input$identifier_env_crop == "" || input$options_env_mode == 1 && input$options_crop_global == 2 && input$save_data_env == 2 && (!is.character(input$identifier_env_crop)) || input$options_env_mode == 1 && input$options_crop_global == 2 && input$save_data_env == 2 && input$identifier_env_crop == "") {
            showModal(modalDialog(
                title = "Error",
                "To continue you have to fill out the Identifier field, this helps to store the data in order and avoid its loss."
            ))
        } else {

    if (input$options_env_mode == 2 && !is.character(input$country_env) || input$options_env_mode == 2 && input$country_env == "" || input$options_env_mode == 2 && input$options_crop == 1 && input$save_data == 1 && !is.character(input$identifier_country) || input$options_env_mode == 2 && input$options_crop == 1 && input$save_data == 1 && input$identifier_country == "" || input$options_env_mode == 2 && input$options_crop == 2 && input$save_data_env == 1 &&  !is.character(input$identifier_country) || input$options_env_mode == 2 && input$options_crop == 2 && input$save_data_env == 1 && input$identifier_country == "") {
        showModal(modalDialog(
            title = "Error",
            "Please make sure you have filled out the country field and provided an identifier."
        ))
    } else {

        if (input$options_env_mode == 2 && input$options_crop == 2 && input$save_data_env == 1 && (!is.character(input$identifier_country_crop)) || input$options_env_mode == 2 && input$options_crop == 2 && input$save_data_env == 1 && input$identifier_country_crop == "" || input$options_env_mode == 2 && input$options_crop == 2 && input$save_data_env == 2 && (!is.character(input$identifier_country_crop)) || input$options_env_mode == 2 && input$options_crop == 2 && input$save_data_env == 2 && input$identifier_country_crop == "") {
            showModal(modalDialog(
                title = "Error",
                "To continue you have to fill out the Identifier field, this helps to store the data in order and avoid its loss."
            ))
        } else {

tryCatch({  

        
        resolution_selection <- c(10, 5, 2.5, 0.5)[as.numeric(input$resoltion_env)]
        
        if (input$options_env_mode == 1) {

    withProgress(message = 'Doing important stuff...', value = 0, {
                 total_iterations_glo <- 1
                                    total_progress_glo <- 1
                 # Aquí va el código para realizar el análisis
                 # Actualiza el valor de la barra de progreso en porcentaje
                 for (i in 1:total_iterations_glo) {
            env_dat_all <- try(worldclim_global(var=input$varclim_options, res=resolution_selection, path = "./"), silent = TRUE)
            
            if (inherits(env_dat_all, "try-error") || is.null(env_dat_all)) {
                showModal(modalDialog(
                    title = "Error",
                    "Failed to download WorldClim global data. Please check your internet connection or try again later.",
                    easyClose = TRUE,
                    footer = NULL
                ))
            } else {

                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")

                output$env_plot_all <- renderPlot({
                    plot(env_dat_all)
                })
# Guardar cada capa con su nombre original en formato ASC
    if (input$options_crop_global == 1 && input$save_data == 1 || input$options_crop_global == 2 && input$save_data_env == 1 ) {
for (i in 1:nlyr(env_dat_all)) {
    writeRaster(env_dat_all[[i]], filename = paste0(names(env_dat_all)[i], input$identifier_env, ".asc"), overwrite=TRUE)
}
} #save
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                
                if (input$options_crop_global == 2) {
                    xmin <- as.numeric(input$xmin)
                    xmax <- as.numeric(input$xmax)
                    ymin <- as.numeric(input$ymin)
                    ymax <- as.numeric(input$ymax)
                    env_dat_crop_all <- try(crop(env_dat_all, extent(xmin, xmax, ymin, ymax)), silent = TRUE)

                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                    
                    if (inherits(env_dat_crop_all, "try-error") || is.null(env_dat_crop_all)) {
                        showModal(modalDialog(
                            title = "Error",
                            "Failed to crop the data. Please check your inputs and try again.",
                            easyClose = TRUE,
                            footer = NULL
                        ))
                    } else {
                        output$env_plot_crop_all <- renderPlot({
                            plot(env_dat_crop_all)

                    })
# Guardar cada capa con su nombre original y añadiendo "finales"
    if (input$options_crop_global == 2 && input$save_data_env == 1 || input$options_crop_global == 2 && input$save_data_env == 2) {
for (i in 1:nlyr(env_dat_crop_all)) {
    writeRaster(env_dat_crop_all[[i]], filename = paste0(names(env_dat_all)[i], input$identifier_env_crop, "_crop_lat_lon.asc"))
}
} #save

                }
            }
                        }
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                   incProgress(total_progress_glo, detail = "Proceso completado")
}
}) #withprogress
        }
        
        if (input$options_env_mode == 2) {

    withProgress(message = 'Doing important stuff...', value = 0, {
                 total_iterations_cou <- 1
                                    total_progress_cou <- 1
                 # Aquí va el código para realizar el análisis
                 # Actualiza el valor de la barra de progreso en porcentaje
                 for (i in 1:total_iterations_cou) {

                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")

            env_dat <- try(worldclim_country(input$country_env, var=input$varclim_options, res=resolution_selection, path = "./"), silent = TRUE)
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
            
            if (inherits(env_dat, "try-error") || is.null(env_dat)) {
                showModal(modalDialog(
                    title = "Error",
                    "Failed to download WorldClim data for the selected country. Please check your internet connection or try again later.",
                    easyClose = TRUE,
                    footer = NULL
                ))
            } else {
                output$env_plot_country <- renderPlot({
                    plot(env_dat)
                })
    if (input$options_crop == 1 && input$save_data == 1 || input$options_crop == 2 && input$save_data_env == 1) {
for (i in 1:nlyr(env_dat)) {
    writeRaster(env_dat[[i]], filename = paste0(names(env_dat)[i], input$identifier_country, ".asc"), overwrite=TRUE)
}
} #save
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                
                if (input$options_crop == 2) {
                    xmin <- as.numeric(input$xmin)
                    xmax <- as.numeric(input$xmax)
                    ymin <- as.numeric(input$ymin)
                    ymax <- as.numeric(input$ymax)
                    env_dat_crop <- try(crop(env_dat, extent(xmin, xmax, ymin, ymax)), silent = TRUE)
                       incProgress(1/10, detail = "Ploting...")
                       incProgress(1/10, detail = "Ploting...")
                    
                    if (inherits(env_dat_crop, "try-error") || is.null(env_dat_crop)) {
                        showModal(modalDialog(
                            title = "Error",
                            "Failed to crop the data. Please check your inputs and try again.",
                            easyClose = TRUE,
                            footer = NULL
                        ))
                    } else {
                        output$env_plot_crop <- renderPlot({
                            plot(env_dat_crop)
                        })
    if (input$options_crop == 2 && input$save_data_env == 1 || input$options_crop == 2 && input$save_data_env == 2) {
for (i in 1:nlyr(env_dat_crop)) {
    writeRaster(env_dat_crop[[i]], filename = paste0(names(env_dat_crop)[i], input$identifier_country_crop, "_crop_lat_lon.asc"))
}
} #save
                    }
                }
            }
                       incProgress(1/10, detail = "Ploting...")

                       incProgress(1/10, detail = "Ploting...")
                   incProgress(total_progress_cou, detail = "Proceso completado")
}
}) #withprogress
        }
        
        #################################################
        #################33
        #####################3
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
})  #trycatch
} # need to
}
}
} # need to
    })
    
    # Crear el mapa interactivo con opciones de dibujo
    output$map_envlayers <- renderLeaflet({
        leaflet() %>%
            addTiles() %>%
            addDrawToolbar(
                targetGroup = "draw",
                polylineOptions = FALSE,
                polygonOptions = FALSE,
                circleOptions = FALSE,
                rectangleOptions = TRUE,
                markerOptions = FALSE,
                circleMarkerOptions = FALSE,
                editOptions = leaflet.extras::editToolbarOptions(selectedPathOptions = leaflet.extras::selectedPathOptions())
            )
    })
    
    # Capturar el rectángulo dibujado
    observeEvent(input$map_envlayers_draw_new_feature, {
        feature <- input$map_envlayers_draw_new_feature
        coords <- feature$geometry$coordinates[[1]]
        polygon <- st_polygon(list(do.call(rbind, lapply(coords, function(coord) c(coord[[1]], coord[[2]])))))
        assign("drawn_polygon", polygon, envir = .GlobalEnv)
    })
    
    observeEvent(input$envRun2, {
if (!exists("drawn_polygon")) {
    showModal(modalDialog(
        title = "Error",
        "The drawn polygon does not exist. Please draw a polygon before proceeding."
    ))
} else {
    if (input$options_env_mode == 3 && !is.character(input$identifier_interactive) || input$options_env_mode == 3 && input$identifier_interactive == "") {
        showModal(modalDialog(
            title = "Error",
            "Please make sure you have provided an identifier."
        ))
    } else {
tryCatch({  

    withProgress(message = 'Doing important stuff...', value = 0, {
                 total_iterations_int <- 1
                                    total_progress_int <- 1
                 # Aquí va el código para realizar el análisis
                 # Actualiza el valor de la barra de progreso en porcentaje
                 for (i in 1:total_iterations_int) {

        resolution_selection <- c(10, 5, 2.5, 0.5)[as.numeric(input$resoltion_env)]
                               incProgress(1/10, detail = "Ploting...")
                               incProgress(1/10, detail = "Ploting...")
        
        if (input$options_env_mode == 3) {
            env_dat_allm <- try(worldclim_global(var=input$varclim_options, res=resolution_selection, path = "./"), silent = TRUE)
            
            if (inherits(env_dat_allm, "try-error") || is.null(env_dat_allm)) {
                showModal(modalDialog(
                    title = "Error",
                    "Failed to download WorldClim global data. Please check your internet connection or try again later.",
                    easyClose = TRUE,
                    footer = NULL
                ))
            } else {
                
                               incProgress(1/10, detail = "Ploting...")
                               incProgress(1/10, detail = "Ploting...")
                               incProgress(1/10, detail = "Ploting...")

                if (exists("drawn_polygon")) {
                    env_dat_crop_allm <- try(crop(env_dat_allm, vect(drawn_polygon)), silent = TRUE)
                               incProgress(1/10, detail = "Ploting...")
                               incProgress(1/10, detail = "Ploting...")
                    
                    if (inherits(env_dat_crop_allm, "try-error") || is.null(env_dat_crop_allm)) {
                        showModal(modalDialog(
                            title = "Error",
                            "Failed to crop the data. Please check your inputs and try again.",
                            easyClose = TRUE,
                            footer = NULL
                        ))
                    } else {
                        output$env_plot_crop_all_map <- renderPlot({
                            plot(env_dat_crop_allm)
                        })

    if (input$save_data_env_inter == 1) {
for (i in 1:nlyr(env_dat_crop_allm)) {
    writeRaster(env_dat_crop_allm[[i]], filename = paste0(names(env_dat_crop_allm)[i], input$identifier_interactive, "_map.asc"))
}
} #save
                               incProgress(1/10, detail = "Ploting...")
                               incProgress(1/10, detail = "Ploting...")
                    }
                }
            }
        }
        
                               incProgress(1/10, detail = "Ploting...")
                   incProgress(total_progress_int, detail = "Proceso completado")
}
}) #withprogress

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
})  #trycatch
} #drawn 
} #identifier
    })


#################3#########33
#########################
############################3 mask con econiches

  observeEvent(input$process_mask_eco, {

  if (!is.character(input$country_env) || input$country_env == "") {
    showModal(modalDialog(
      title = "Error",
      "You have to indicate a country to continue."
    ))
  } else {

    withProgress(message = 'Doing important stuff...', value = 0, {
                 total_iterations_mask_eco <- 1
                                    total_progress_mask_eco <- 1
                 # Aquí va el código para realizar el análisis
                 # Actualiza el valor de la barra de progreso en porcentaje
                 for (i in 1:total_iterations_mask_eco) {
      

tryCatch({    

  if (is.null(input$mask_file_eco)) {
    showModal(modalDialog(
      title = "Error",
      "You need to upload a database to continue."
    ))
  } else {


        resolution_selection <- c(10, 5, 2.5, 0.5)[as.numeric(input$resoltion_env)]
        
        if (input$options_env_mode == 2) {
            env_dat_all <- try(worldclim_country(input$country_env, var=input$varclim_options, res=resolution_selection, path = "./"), silent = TRUE)
            
            if (inherits(env_dat_all, "try-error") || is.null(env_dat_all)) {
                showModal(modalDialog(
                    title = "Error",
                    "Failed to download WorldClim global data. Please check your internet connection or try again later.",
                    easyClose = TRUE,
                    footer = NULL
                ))
            } else {

 # condición global me falta me faltan ambas alv
            env_dat_all <- worldclim_country(input$country_env, var=input$varclim_options, res=resolution_selection, path = "./")
                output$env_plot_all_mask <- renderPlot({
                    plot(env_dat_all)
                })
            env_dat_all <- stack(env_dat_all)
                   incProgress(1/10, detail = "Analyzing...")
     
      
      # Cargar la máscara
      mask <- raster(input$mask_file_eco$datapath)
                         incProgress(1/10, detail = "Analyzing...")
      
      # Ajustar la máscara para que tenga la misma extensión y resolución que las capas

      mask_resampled <- projectRaster(mask, env_dat_all, method = "bilinear")
                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(1/10, detail = "Analyzing...")
     
      
      # Aplicar la máscara ajustada
      hisp.env_masked <- mask(env_dat_all, mask_resampled)
                   incProgress(1/10, detail = "Analyzing...")
      

      # Guardar cada capa individualmente
      for (i in 1:nlayers(hisp.env_masked)) {
        layer_name <- names(hisp.env_masked)[i]
        writeRaster(hisp.env_masked[[i]], filename = paste0(layer_name, ".tif"), format = "GTiff", overwrite = TRUE)
      }

                output$env_plot_mask__eco <- renderPlot({
plot(hisp.env_masked)
})

}
}}

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
})  #trycatch
                       incProgress(1/10, detail = "Ploting...")
                   incProgress(total_progress_mask_eco, detail = "Proceso completado")
}
}) #withprogress
      
} #showmodal country
    })




#################3#########33
#########################
############################3 mask con econiches

### mask and my own files

  observeEvent(input$process_mask, {

    withProgress(message = 'Doing important stuff...', value = 0, {
                 total_iterations_mask <- 1
                                    total_progress_mask <- 1
                 # Aquí va el código para realizar el análisis
                 # Actualiza el valor de la barra de progreso en porcentaje
                 for (i in 1:total_iterations_mask) {
      

tryCatch({    

  if (is.null(input$mask_file) || is.null(input$layers_set)) {
    showModal(modalDialog(
      title = "Error",
      "You need to upload a database to continue."
    ))
  } else {

      # Cargar las capas de WorldClim
      bio_files <- input$layers_set$datapath
                   incProgress(1/10, detail = "Analyzing...")
      bio_rasters <- lapply(bio_files, raster)
                   incProgress(1/10, detail = "Analyzing...")
      hisp.env <- stack(bio_rasters)
                   incProgress(1/10, detail = "Analyzing...")
      
      # Asignar nombres a las capas del stack
      names(hisp.env) <- sub("\\.asc$", "", basename(input$layers_set$name))
                   incProgress(1/10, detail = "Analyzing...")
      
      # Cargar la máscara
      mask <- raster(input$mask_file$datapath)
                         incProgress(1/10, detail = "Analyzing...")
      
      # Ajustar la máscara para que tenga la misma extensión y resolución que las capas

      mask_resampled <- projectRaster(mask, hisp.env, method = "bilinear")
                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(1/10, detail = "Analyzing...")
     
      
      # Aplicar la máscara ajustada
      hisp.env_masked <- mask(hisp.env, mask_resampled)
                   incProgress(1/10, detail = "Analyzing...")
      

      # Guardar cada capa individualmente
      for (i in 1:nlayers(hisp.env_masked)) {
        layer_name <- names(hisp.env_masked)[i]
        writeRaster(hisp.env_masked[[i]], filename = paste0(layer_name, ".tif"), format = "GTiff", overwrite = TRUE)
      }
                output$env_plot_mask_mo <- renderPlot({
plot(hisp.env_masked)
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
})  #trycatch
                       incProgress(1/10, detail = "Ploting...")
                   incProgress(total_progress_mask, detail = "Proceso completado")
}
}) #withprogress
      

    })


########################### shape

    observeEvent(input$shape_cut, {

tryCatch({    

  if (is.null(input$shape_set) || is.null(input$maskCut)) {
    showModal(modalDialog(
      title = "Error",
      "You need to upload a database to continue."
    ))
  } else {
                req(input$shape_set)
        req(input$maskCut)
        withProgress(message = 'Doing important stuff...', value = 0, {
            total_iterations_mask <- length(input$maskCut$datapath)
            total_progress_mask <- 1 / total_iterations_mask
            
            temp_dir <- tempdir()
            shape_files <- input$shape_set
            
            for (i in 1:nrow(shape_files)) {
                file.copy(shape_files$datapath[i], file.path(temp_dir, shape_files$name[i]))
            }
            
            shp_name <- tools::file_path_sans_ext(shape_files$name[grep(".shp$", shape_files$name)])
            shape_file <- st_read(dsn = temp_dir, layer = shp_name)
            shape_file <- st_transform(shape_file, crs(raster(input$maskCut$datapath[1])))
            
            output_list <- list()
            
            for (i in 1:total_iterations_mask) {
                tryCatch({
                    incProgress(1 / total_iterations_mask, detail = paste("Processing layer", i))
                    
                    asc_file <- raster(input$maskCut$datapath[i])
                    asc_crop <- crop(asc_file, shape_file)
                    asc_masked <- mask(asc_crop, shape_file)
                    
                    output_name <- paste0(gsub(".asc$", "", input$maskCut$name[i]), input$output_maskcut, ".asc")
                    
                    writeRaster(asc_masked, output_name, format = "ascii")
                    
                    output_list[[i]] <- asc_masked
                    
                }, error = function(e) {
                    showModal(modalDialog(
                        title = "Error",
                        paste("Something went wrong with layer", i, ":", e$message),
                        easyClose = TRUE,
                        footer = NULL
                    ))
                })
            }
            
            output$cropshp_output <- renderPlot({
                num_layers <- length(output_list)
                rows <- if (num_layers > 1) ceiling(sqrt(num_layers)) else 1
                cols <- if (num_layers > 1) ceiling(num_layers / rows) else 1
                layout(matrix(1:num_layers, nrow = rows, ncol = cols))
                
                lapply(output_list, function(raster_layer) {
                    plot(raster_layer, main = names(raster_layer))
                })
            }, height = 800)
            
            incProgress(1 / total_iterations_mask, detail = "Process completed")
        })

} #else si falta una base de datos

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
})  #trycatch
    })



#######33##### shapeeconiches             

###########33 termina environmental  


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
  selectInput("country_selection",  
              div("Country", tags$i(class = "fas fa-question-circle", "data-toggle" = "tooltip", "title" = 'If you do not want to filter the data by geographic area, you can select "All" to filter only by year. Otherwise you can select one or multiple countries.')),
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
  #############Inicia aquí

tryCatch({ 
  
  if (is.null(input$file_maps2)) {
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
        
        output$leaflet_map_2 <- renderLeaflet({
          leaflet_data$map
        })
        
        incProgress(5/10, detail = "Loading for viewing...")
        incProgress(total_progress_leaf1, detail = "Finished")
      }
    })
    
    
    output$mapPlot_2 <- renderPlot({
      req(input$file_maps2)
      
      withProgress(message = 'Loading maps...', value = 0, {
        total_iterations_leaf11 <- 1
        total_progress_leaf11 <- 1
        # Aquí va el código para realizar el análisis
        # Actualiza el valor de la barra de progreso en porcentaje
        for (i in 1:total_iterations_leaf11) {
          incProgress(5/10, detail = "Loading for viewing...")
          
          # Read raster file
          raster_file <- raster(input$file_maps2$datapath)
          
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
#especie 1
    if (input$options_species_model == 1) {

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

} # especie 1


#
#especie 2
    if (input$options_species_model == 2) {

#especie 1

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

# especie 2


models_selected <- input$model_niche

          if ("glm" %in% models_selected) {
            sp2.glm <- enmtools.glm(species = sp2, env = env, test.prop = 0.2)
            output$modelPlot_glm2 <- renderPlot({ sp2.glm })
            output$modelSummary_glm2 <- renderPrint({ sp2.glm })
	    output$resp_plot_glm2 <- renderPlot({sp2.glm$response.plots})
output$test_data_glm2 <- renderPlot({
visualize.enm(sp2.glm, env, plot.test.data = TRUE)
})

      output$downloadPdf_glmmodel <- downloadHandler(
        filename = function() {
          "GLM Model sp2.pdf"
        },
  content = function(file) {
glm_plot_pdf2<-plot(sp2.glm)
    ggsave(file, plot = glm_plot_pdf2, device = "pdf")
  }
)
          }

          if ("gam" %in% models_selected) {
            sp2.gam <- enmtools.gam(sp2, env, test.prop = 0.2)
            output$modelPlot_gam2 <- renderPlot({ sp2.gam })
            output$modelSummary_gam2 <- renderPrint({ sp2.gam })
	    output$resp_plot_gam2 <- renderPlot({sp2.gam$response.plots})
output$test_data_gam2 <- renderPlot({
visualize.enm(sp2.gam, env, plot.test.data = TRUE)
})
      output$downloadPdf_gammodel2 <- downloadHandler(
        filename = function() {
          "GAM Model sp2.pdf"
        },
  content = function(file) {
gam_plot_pdf2<-plot(sp2.gam)
    ggsave(file, plot = gam_plot_pdf2, device = "pdf")
  }
)

          }

          if ("dm" %in% models_selected) {
            sp2.dm <- enmtools.dm(sp2, env, test.prop = 0.2)
            output$modelPlot_dm2 <- renderPlot({ sp2.dm })
            output$modelSummary_dm2 <- renderPrint({ sp2.dm })
	    output$resp_plot_dm2 <- renderPlot({sp2.dm$response.plots})
output$test_data_dm2 <- renderPlot({
visualize.enm(sp2.dm, env, plot.test.data = TRUE)
})

      output$downloadPdf_dmmodel <- downloadHandler(
        filename = function() {
          "DM Model sp2.pdf"
        },
  content = function(file) {
dm_plot_pdf2<-plot(sp2.dm)
    ggsave(file, plot = dm_plot_pdf2, device = "pdf")
  }
)
          }

          if ("bc" %in% models_selected) {
            sp2.bc <- enmtools.bc(sp2, env, test.prop = 0.2)
            output$modelPlot_bc2 <- renderPlot({ sp2.bc })
            output$modelSummary_bc2 <- renderPrint({ sp2.bc })
	    output$resp_plot_bc2 <- renderPlot({sp2.bc$response.plots})
output$test_data_bc2 <- renderPlot({
visualize.enm(sp2.bc, env, plot.test.data = TRUE)
})
      output$downloadPdf_bcmodel <- downloadHandler(
        filename = function() {
          "BC Model sp2.pdf"
        },
  content = function(file) {
bc_plot_pdf2<-plot(sp2.bc)
    ggsave(file, plot = bc_plot_pdf2, device = "pdf")
  }
)
          }

          if ("maxent" %in% models_selected) {
            sp2.mx <- enmtools.maxent(sp2, env, test.prop = 0.2)
            output$modelPlot_mx2 <- renderPlot({ sp2.mx })
            output$modelSummary_mx2 <- renderPrint({ sp2.mx })
	    output$resp_plot_mx2 <- renderPlot({sp2.mx$response.plots})
output$test_data_mx2 <- renderPlot({
visualize.enm(sp2.mx, env, plot.test.data = TRUE)
})
      output$downloadPdf_mxmodel <- downloadHandler(
        filename = function() {
          "Maxent Model sp2.pdf"
        },
  content = function(file) {
mx_plot_pdf2<-plot(sp2.mx)
    ggsave(file, plot = mx_plot_pdf2, device = "pdf")
  }
)
          }

# especie 2
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
      



#################################################################################################################
###############################################Connectivity######################################################
#################################################################################################################
      

  observeEvent(input$run_connectivity, {
    
    withProgress(message = 'Doing important stuff...', value = 0, {
                 total_iterations_mask <- 1
                                    total_progress_mask <- 1
                 # Aquí va el código para realizar el análisis
                 # Actualiza el valor de la barra de progreso en porcentaje
                 for (i in 1:total_iterations_mask) {
      tryCatch({

        
coords_df <- read.csv(input$points_connectivity$datapath)
coords_df <- coords_df %>% rename(x = X, y = Y)
                   incProgress(1/10, detail = "Analyzing...")

# Convertir el data frame en un objeto SpatialPoints
coordinates(coords_df) <- ~x+y
proj4string(coords_df) <- CRS("+proj=longlat +datum=WGS84")
Pj_sp <- coords_df

# Extraer las coordenadas
Pj_coords <- Pj_sp@coords

# Crear el casco convexo y el buffer
Pj_chull <- chull(Pj_sp@coords)
Pj_chull_ends <- Pj_sp@coords[c(Pj_chull, Pj_chull[1]),]
Pj_poly <- SpatialPolygons(list(Polygons(list(Polygon(Pj_chull_ends)), ID=1)), proj4string = CRS(proj4string(Pj_sp)))
Pj_poly_buff <- gBuffer(Pj_poly, width = 0.05, byid=TRUE)

# Paso 2: Cargar tu mapa potencial en formato .tif
potential_habitat <- raster(input$pot_map_connectivity$datapath)

# Asegurarse de que el CRS coincida con el de los puntos
proj4string(potential_habitat) <- CRS(proj4string(Pj_sp))

# Procesar el mapa potencial
elv <- potential_habitat %>% crop(Pj_poly_buff) %>% mask(Pj_poly_buff)
asp <- terrain(elv, opt="aspect", neighbors = 8)

# Crear el objeto 'se' basado en los límites del raster de mapa potencial
bbox <- as(extent(elv), "SpatialPolygons")
proj4string(bbox) <- CRS(proj4string(Pj_sp))
se <- bbox
                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(1/10, detail = "Analyzing...")

# Visualizar el aspecto y muestra de puntos
set.seed(6)
Pj_sample <- Pj_coords[sample(nrow(Pj_coords), input$number_points),] # Número de punto a trabajar

                   incProgress(1/10, detail = "Analyzing...")

# Calcular la probabilidad de paso
Pj_combn <- combn(nrow(Pj_sample), 2) %>%
  t() %>%
  as.matrix()

asp_tr <- transition(asp, transitionFunction = mean, 4) %>%
    geoCorrection(type="c", multpl=FALSE)

passages <- list()  # Crear una lista para almacenar los rasters de probabilidad de paso
system.time(
  for (i in 1:nrow(Pj_combn)) {           
    locations <- SpatialPoints(rbind(Pj_sample[Pj_combn[i,1],1:2], Pj_sample[Pj_combn[i,2],1:2]), proj4string = CRS(proj4string(Pj_sp)))
    passages[[i]] <- passage(asp_tr, origin=locations[1], goal=locations[2], theta = 0.00001)
    print(paste((i/nrow(Pj_combn))*100, "% complete"))
  }
)

                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(1/10, detail = "Analyzing...")

passages <- stack(passages)  # Crear un RasterStack de todas las probabilidades de paso
passages_overlay <- sum(passages) / nrow(Pj_combn)  # Calcular el promedio

                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(1/10, detail = "Analyzing...")

# Visualizar el resultado


          output$connectivity_output <- renderPlot({
connnectivityPlot <- colors <- c("grey60", viridis_pal(option="plasma", begin = 0.3, end = 1)(20))
ggplot(as.data.frame(passages_overlay, xy=TRUE)) + 
  geom_raster(aes(x=x, y=y, fill=layer)) +
  scale_fill_gradientn(colors = colors, na.value = NA) + 
  theme_map() +   
  theme(legend.position = "right")
})

  output$download_pdf_connec <- downloadHandler(
    filename = function() {
      "ConnectivityPlot.pdf"
    },
        content = function(file) {
          pdf(file)
          plot(connnectivityPlot)
          dev.off()
    }
  )

                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(1/10, detail = "Analyzing...")
                   incProgress(total_progress_mask, detail = "Proceso completado")
        
      }, error = function(e) {
        showModal(modalDialog(
          title = "Error",
          paste("Something went wrong:", e$message),
          easyClose = TRUE,
          footer = NULL
        ))
      })
   } })
  })


  }
  
  # Ejecutar la aplicación
  shinyApp(ui = ui, server = server)
  