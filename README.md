# EcoNicheS  
<img src="https://github.com/user-attachments/assets/cc761f7a-038a-4641-bb2c-23a4674d7989" align="right" height="200" />

### Empowering Ecological Niche Modeling Analysis with Shinydashboard and R Package.


An R library that enables Ecological Niche Modeling Analysis with Shinydashboard. This is Version 1.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. 

-----
#### Schematic description of the ecological niche modeling process, and steps that can be performed using the EcoNicheS package.

<img src="https://github.com/user-attachments/assets/21759a04-b153-4ad0-b316-c773d6c20ce8" align="center" height="1000" />


## EcoNicheS Requirements

### Installation of 64-bit Java

To use EcoNicheS it is necessary to have 64-bit Java installed. For this you can visit the Oracle Java download page by clicking [here](https://www.oracle.com/java/technologies/downloads/). Downloading the .exe file is the easiest option.

<img width="1041" alt="Captura de pantalla 2024-07-20 a la(s) 12 12 16 p m" src="https://github.com/user-attachments/assets/956463e4-b574-4df6-9ec2-8325680e010b">


### Download and install RTools

In addition to having installed [R](https://cran.rstudio.com/) and [RStudio](https://posit.co/download/rstudio-desktop/), RTools is essential to be able to use some packages in R required by EcoNicheS, so please download and install it on your device to avoid problems when running and using the app. You can download RTools by accessing this [link](https://cran.r-project.org/bin/windows/Rtools/).

> [!TIP]
>For new R users: Do you need help with installation? We recommend you go to the [Hands-On Programming with R](https://rstudio-education.github.io/hopr/starting.html) website, it allows you to access a manual that helps both Windows and Mac users learn to use R starting from the installation.


### Packages EcoNicheS depends on
##### For the correct functioning of EcoNiches it is necessary to update all the packages installed in R with the following command: update.packages(ask = FALSE, checkBuilt = TRUE)

EcoNicheS works with specific libraries in R. You can visit the websites listed below to obtain the required packages. If in this section or when running the command to open the application there is a problem regarding the failure to install any of the libraries, please refer to the [**Problems installing packages**]

- [shiny](https://CRAN.R-project.org/package=shiny) 
- [terra](https://cran.r-project.org/package=terra) 
- [usdm](https://cran.r-project.org/package=usdm)
- [ENMTools](https://github.com/danlwarren/ENMTools) 
- [biomod2](https://cran.r-project.org/package=biomod2) 
- [RColorBrewer](https://cran.r-project.org/package=RColorBrewer) 
- [dismo](https://github.com/rspatial/dismo) 
- [tiff](https://cran.r-project.org/web/packages/tiff/index.html) 
- [rJava](https://cran.r-project.org/web/packages/rJava/index.html) 
- [tidyterra](https://cran.r-project.org/web/packages/tidyterra/index.html) 
- [shinydashboard](https://rstudio.github.io/shinydashboard/get_started.html) 
- [pROC](https://cran.r-project.org/package=pROCl) 
- [R.utils](https://cran.r-project.org/package=R.utils)
- [CoordinateCleaner](https://ropensci.github.io/CoordinateCleaner/articles/Cleaning_GBIF_data_with_CoordinateCleaner.html)
- [dplyr](https://dplyr.tidyverse.org/)
- [ggplot2](https://ggplot2.tidyverse.org/)
- [rgbif](https://cran.r-project.org/web/packages/rgbif/index.html)
- [sf](https://cran.r-project.org/web/packages/sf/index.html)
- [rnaturalearthdata](https://cran.r-project.org/web/packages/rnaturalearthdata/index.html)
- [spThin](https://cran.r-project.org/package=spThin)
- [shinyjs](https://cran.r-project.org/web/packages/shinyjs/index.html)
- [leaflet](https://cran.r-project.org/web/packages/leaflet/index.html)
- [DT](https://cran.r-project.org/web/packages/DT/index.html)
- [shinyBS](https://cran.r-project.org/web/packages/shinyBS/index.html)
- [prettymapr](https://cran.r-project.org/web/packages/prettymapr/index.html)
- [ntbox](https://github.com/luismurao/ntbox)
- [gt](https://cran.r-project.org/web/packages/gt/index.html)
- [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html)
- [gtExtras](https://cran.r-project.org/web/packages/gtExtras/index.html)
- [leaflet.extras](https://cran.r-project.org/web/packages/leaflet.extras/index.html)
- [geodata](https://cran.r-project.org/web/packages/geodata/index.html)
- [viridis](https://cran.r-project.org/web/packages/viridis/index.html)
- [ggthemes](https://cran.r-project.org/web/packages/ggthemes/index.html)
- [sp](https://cran.r-project.org/web/packages/sp/index.html)
- [rgeos](https://cran.r-project.org/src/contrib/Archive/rgeos/)
- [gdistance](https://cran.r-project.org/web/packages/gdistance/index.html)
- [ENMGadgets](https://github.com/narayanibarve/ENMGadgets)

  
  
### Define the working directory in RStudio and prepare your databases

To ensure smooth workflow in RStudio, it is crucial to define the working directory properly, the location where all databases created during the analyzes will be saved. Follow these steps, navigate to: "Session" ➥ "Set Working Directory" ➥ "Choose Directory", and select the folder that contains the databases necessary to carry out this type of analysis: the .asc layers of your study area and the .csv file containing the coordinates with the points of presence of your study species.

### MAXENT model
One of the EcoNicheS tabs bases its analyzes on [biomod2](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#biomod2), which in turn uses different models to perform the ecological niche modeling analysis. One of these models is [MAXENT](https://biodiversityinformatics.amnh.org/open_source/maxent/), which requires the prior download of 3 files so that the analysis with it can be carried out, so, if it is selected, prior to the analysis ensure that the working directory includes all the necessary files for running this model: [MAXENT](https://doi.org/10.6084/m9.figshare.24980664.v1).

<img width="525" alt="Captura de pantalla 2024-07-20 a la(s) 11 57 34 a m" src="https://github.com/user-attachments/assets/c8d3406c-bb3e-4d95-87f8-797bb5afa630">


If you are not familiar with biomod2, in its corresponding section in this manual you will know how to use it with EcoNicheS but it is important that you have the mentioned files from the beginning to ensure that there will be no problems when you use this tab.

-----

# To install the library

EcoNicheS works with specific libraries in R that it uses to perform ecological niche modeling analyses, and although the loading of most of them is automatic when running the application, there are some exceptions so it is necessary that you please use the command shown below in RStudio to ensure smooth functionality. If in this section or when running the command to open the application there is a problem regarding the failure to install any of the libraries, please refer to the [**Problems installing packages**](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#problems-installing-packages) part of the manual.

``` r
#Before loading the graphical interface, paste this line to give more capacity to rJava and then select the working directory

options(shiny.maxRequestSize = 6000*1024^2)

##Install the  rgeos

install.packages("https://cran.r-project.org/src/contrib/Archive/rgeos/rgeos_0.6-4.tar.gz", repos = NULL, type = "source")

##Install the  maptools

install.packages("https://cran.r-project.org/src/contrib/Archive/maptools/maptools_1.1-8.tar.gz", repos = NULL, type = "source")

##Install the  ENMGadgets


if (!require('devtools')) install.packages('devtools')

library(devtools)

install_github("narayanibarve/ENMGadgets")

require(ENMGadgets)

##Install the  ENMTools

library(devtools)

install_github("danlwarren/ENMTools")

library(ENMTools)


##Install the  ntbox

library(devtools)

devtools::install_github('luismurao/ntbox')

# If you want to build vignette, install pandoc before and then

devtools::install_github('luismurao/ntbox',build_vignettes=TRUE)

library(ntbox)
run_ntbox()


# Install the  EcoNicheS

install_github('armandosunny/EcoNicheS')

library(EcoNicheS)


```
# To open the shiny GUI application:

After ensuring that the above commands worked successfully, use this command to start exploring the EcoNicheS interface and features.

```
options(shiny.maxRequestSize = 6000*1024^2)
library(EcoNicheS)
shinyApp(ui = ui, server = server)
```

<img width="1040" alt="Captura de pantalla 2024-07-20 a la(s) 11 43 54 a m" src="https://github.com/user-attachments/assets/a6686116-989d-4bc6-82cf-623ca2c54c95">



# Learning how to use EcoNicheS

To know and understand in detail the functions that EcoNicheS offers and the results that we can obtain from them, we invite you to learn about the application through this manual. The documents and databases necessary to be able to use each of the EcoNicheS functions are available [here].

In order to use your databases, the _.csv base file_ must have the _name of the species listed in the first column_, followed by _longitude (X)_ in the second column, and _latitude (Y)_ in the third column as seen below. _Editing your database respecting lowercase and uppercase letters is essential for the analysis to proceed_.

<img width="528" alt="Captura de pantalla 2024-07-20 a la(s) 12 16 08 p m" src="https://github.com/user-attachments/assets/cd9ef681-0136-4d28-8a02-77297a7f62ed">


-----

# Exploring EcoNicheS features




EcoNicheS is an interactive web application that consists of 12 modules: **[Environmental Data](https://github.com/armandosunny/EcoNicheS?tab=readme-ov-file#first-module-environmental-data), [Occurrence processing](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#second-module-obtaining-and-cleaning-species-occurrences), [Load and Plot Maps (2x)](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#third-module-load-and-plot-maps), [Correlation layers](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#fourth-module-correlation-analysis-between-asc-layers), [Points and pseudoabsences](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#fifth-module-points-and-pseudoabsences), [biomod2](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#sixth-module-biomod2), [Partial ROC Analysis](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#seventh-module-partial-roc-analysis), [Remove urbanization](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#eighth-module-remove-urbanization), [Calculate area](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#ninth-module-calculate-area), [Gains and Losses Plot](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#tenth-module-gains-and-losses-plot), [ENMTools](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#eleventh-module-enmtools), and [Connectivity](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#twelfth-module-connectivity)**. 

You can use these functions in order to perform the analyzes and evaluations of niche modeling, niche overlap and connectivity analysis with circuit theory. The application before, during and at the end of the analyzes has pop-up windows that will indicate errors or data necessary to continue, and you will also be able to see the progress of the work in the lower left corner every time you press the execution buttons. You must take into account that this first version of EcoNicheS does not allow you to cancel the analyses, they are only interrupted if the application detects an error in the analysis execution sequences, because this is sequential and this implies that the progress can stop when detecting an error, please make sure you enter the correct data before submitting it to analysis.

<img width="525" alt="Captura de pantalla 2024-07-20 a la(s) 12 18 53 p m" src="https://github.com/user-attachments/assets/680ab39e-ded1-49b9-b508-baf2183eb61c">


## First module: Environmental Data 
[WorldClim](https://www.worldclim.org/) is a database with global climate and weather records and data (Fick and Hijmans, 2017). In Ecological Nichoe Modeling studies, it is one of the most relevant data sets from which it is possible to obtain information in high resolution and actionable format (.tif) on the environmental variables that are relevant to understanding the distribution of species.
As mentioned above, the data it offers is global, but specific records can also be obtained for a country and even through R, a specific delimited geographic area of ​​interest. Through EcoNicheS it is possible to download **WorldClim** data in any of these ways, you can obtain **global data** (*WorldClim Global*), by **country** (*WorldClim Country*) or **delimit your own study area** (*Interactive map*).

The environmental variables that you can download from WorldClim through EcoNicheS are ["tmin", "tmax", "tavg", "prec", "wind", "vapr", and "bio"](https://www.worldclim.org/data/worldclim21.html) and respectively they correspond to minimum temperature (°C ), maximum temperature (°C), average temperature (°C), precipitation (mm), wind speed (m s-1), water vapor pressure (kPa) and [Bioclimatic variables](https://www.worldclim.org/data/bioclim.html).

Please visit the links shown to obtain more information about the variables. In this case it is the historical climate data from 1970-2000. You can find a greater repertoire of data by accessing WorldClim.

The data is downloaded with a **specific spatial resolution** which must be indicated according to your needs, between 30 seconds (~1 km2) to 10 minutes (~340 km2) (Fick and Hijmans, 2017).

> [!IMPORTANT]
>If you search for information by country, you must enter the name of the country written in English.

The above are the basic requirements, in the application you can choose to view and save or only view the data without editing, this is useful especially if you are just getting familiar with this type of data and/or with the application. However, *EcoNicheS allows you to edit the data obtained*.

> [!WARNING]
>For this tab and for the following ones too, it is important to consider that  all the buttons must be pressed only once, since a single click guarantees that the documents are being loaded, the analyzes are being carried out or that the download is taking place.

Global data can be edited using longitude and latitude to delimit the area by providing maximum and minimum values ​​for both.
By country, the data can be delimited in the same way or using .asc files to more precisely trim the layers according to the geographical area.

> [!IMPORTANT]
> There is also the option to *provide your own files with layers or environmental variables and crop them with .asc files or using **shape files***. If you are familiar with shape files and their handling in R you will know that it is necessary to provide all the related files, so please upload all of them in the corresponding section in the application.

<img width="1045" alt="Captura de pantalla 2024-07-20 a la(s) 10 32 36 a m" src="https://github.com/user-attachments/assets/ed35fc53-250f-44b7-8557-b4b22d6cd704">

<img width="941" alt="Captura de pantalla 2024-07-20 a la(s) 1 03 03 p m" src="https://github.com/user-attachments/assets/08c1ba6b-9a01-4e3d-ad57-4347e16c789e">

## Second module: Obtaining and cleaning species occurrences

The first step to perform niche modeling analysis is to obtain the recorded occurrences of the species of interest. Using EcoNicheS this is achieved by downloading documents with this information from the Global Biodiversity Information Facility (GBIF, [gbif.org](https://www.gbif.org/)), one of the large biodiversity databases. Geographic distribution data must be processed before analysis. In EcoNicheS the processing can occur through two phases represented in two different submodules in this section, below you will find more details.

<img width="1042" alt="Captura de pantalla 2024-07-20 a la(s) 10 45 19 a m" src="https://github.com/user-attachments/assets/de93c123-0d3d-4bda-8e77-3e7f5cfa6cda">

### Get and Clean GBIF data

Obtaining geographical distribution data is achieved using the [CoordinateCleaner](https://ropensci.github.io/CoordinateCleaner/articles/Cleaning_GBIF_data_with_CoordinateCleaner.html) package (Zizka et al., 2019). So, when opening the application, the first step is to select the first option from the drop-down menu to access the data collection tools.The next step is to enter the scientific name of the species of interest, in addition to entering the maximum amount of presence data that you wish to obtain. Obtaining the data may take a while, the greater the distribution of the species, the longer the waiting time will also be, but never beyond a few minutes.

At the end of your search, you will see on the screen an interactive map created with [leaflet](https://cran.r-project.org/package=leaflet) (Cheng et al., 2023), which will allow you to visualize the global distribution of the data. In addition, you will find graphs and metadata provided by GBIF and CoordinateCleaner that will allow you to have information about the records found, for example, Coordinate is also based on automated data cleaning tests and algorithms to identify and remove records that may be flagged as erroneous or imprecise (Zizka et al., 2019). We can see this through the graphs shown in the application, in addition to having the raw data in the database that is generated and saved in the working directory.

<img width="1044" alt="Captura de pantalla 2024-07-20 a la(s) 10 54 22 a m" src="https://github.com/user-attachments/assets/deb78ec7-f413-4795-b993-653144151ca7">

CoordinateCleaner uses the metadata to clean the data, and one of these parameters is coordinateUncertaintyInMeters, which describes the smallest circle containing the whole of the Location and serves as a reference for the accuracy of the coordinate location, in addition, it allows estimating the potential distance of the real occurrence location from the recorded values. No se como citar esta pagina https://www.gbif.org/data-quality-requirements-occurrences#dcUncertainty. Finally, it is also possible to filter the clean data according to the year and location of interest either using a coordinate system or applying a filter by country (Zizka et al., 2019).

> [!IMPORTANT]
> All the data generated will be saved on your device in the working directory. In this sub module the files are always .csv and the application will tell you if there was any problem that prevented their creation. If you are new to using EcoNicheS, we recommend that you explore the databases created by viewing them in their corresponding application so that you can more easily understand the data obtained and the differences between raw data and when it is unprocessed and filtered.

### Clean my own database 
It is a second data cleaning option in case there are already other files with the points of presence to be processed, coming from different databases, whose metadata is not available to be processed from them. This is why the cleaning process here is carried out in thanks to the [spThin](https://nsojournals.onlinelibrary.wiley.com/doi/epdf/10.1111/ecog.01132) package (Aiello-Lammens et al., 2015), which allows us to eliminate duplicate data, and to achieve this, the file to be entered must be in .csv format, otherwise it will not be able to be processed.
In order to process the data, it is essential that you enter the name of the column where the latitude data that makes up the occurrence data is found. The same should be done for the column with the longitude data and the name of the species. Once you upload your database and without having to press the run button you will be able to view your database on the screen. If this does not happen, please check the file or reload the page only if there is no previous data in other modules that you can lose.

Also, remember to enter the kilometers by which you want the data to be separated by, thus, between each pixel of information separated by the indicated distance, the data will be cleaned so that you find a single record. 

<img width="1039" alt="Captura de pantalla 2024-07-20 a la(s) 11 10 37 a m" src="https://github.com/user-attachments/assets/38bd5b10-ddb9-4466-9ecd-6ce1f3c33840">



## Third module: Load and Plot Maps

In this module you can load .asc, .tiff, .tif or .bil files to view the study area on an interactive map and you can also download the map in PDF



<img width="1046" alt="Captura de pantalla 2024-07-20 a la(s) 11 16 59 a m" src="https://github.com/user-attachments/assets/95fc05ed-2328-4eb0-ab57-0e4d573f4211">




## Fourth module: Correlation analysis between .asc layers 

This module works thanks to [usdm](https://cran.r-project.org/package=usdm) (Naimi et al., 2014) and [ENMTools](https://github.com/danlwarren/ENMTools) (Warren et al., 2021) and requires the raster files or .asc layers that contain the data about the geography of the area, place or location of interest (ACS hosted Feature Layers FAQ, n.d.-a). Since these layers are our study variables, by obtaining a heatmap, this tab allows us to determine if there is autocorrelation between them, thus, it is possible to select multiple .asc files, as well as choose the Threshold (th) value for the analysis.  You can download the example documents to practice using the application [here](). 

Once we press the "Calculate correlation" action button, and after waiting a few seconds or minutes (the longer the time will be the greater the number of variables entered), we will obtain the generated heatmap image as a result. The data generated provides information on the *Pearson Correlation Coefficient¨* and the *Variance inflation factor (VIF)*.
This is an example of the expected results to be obtained. Results can be downloaded in PDF format. 

<img width="1042" alt="Captura de pantalla 2024-07-20 a la(s) 11 29 35 a m" src="https://github.com/user-attachments/assets/cb512fb0-dc55-4ed6-b960-556265ebffe8">


## Fifth module: Points and pseudoabsences

Here, using [dismo](https://cran.r-project.org/package=dismo) (Hijmans et al., 2023), by uploading our previously edited .csv file and any of our .asc layers, as a result, points that correspond to the "pseudo-absences" will be generated, those will serve as a background and are necessary for ecological niche modeling. 

In the example shown below, 1000000 was used as the number of random points, however the default value is 100, but it can be modified, so the appropriate number of points for our study can be indicated in the third box of the tab.

First you will be able to see a simple map that shows the distribution of the pseudo-absences generated, you can download this map in pdf. Below it you will find an interactive map which will allow you to visually understand the database generated and stored in your work directory. In this map you can view the distribution of the original points of presence and the points added as pseudo-absences. In the .csv database created, each one is distinguished by the "response" that accompanies each coordinate, if the value is 1 it is the points of presence, if the value is 0 the longitude and latitude correspond to a value of pseudo-absence. Before running the analysis, the name of the generated database can and must be modified from default name by always maintaining the .csv extension, in this way we ensure that its creation and saving are being carried out correctly.

<img width="1040" alt="Captura de pantalla 2024-07-20 a la(s) 11 38 13 a m" src="https://github.com/user-attachments/assets/146a6485-a8e8-4c83-9d83-4bb91eed0dd4">



Thus, the database with the coordinates of our species now consists of 5 columns, the new pair is a first column, where the amount of data is listed numerically, and a last column where the points of presence of our species were assigned the number 1, while pseudo-absences were assigned a 0.

<img width="752" alt="Captura de pantalla 2024-07-20 a la(s) 2 59 50 p m" src="https://github.com/user-attachments/assets/e9364670-077c-4bf2-9323-f1b443cfcb6e">



## Sixth module: biomod2

For this module to work well, it is necessary to have the maxent files in the same folder where the .asc layers and the database with the presences and pseudo-absences of the species to be analyzed are located.

<img width="752" alt="Captura de pantalla 2024-07-20 a la(s) 3 24 11 p m" src="https://github.com/user-attachments/assets/39d263ff-b80d-4e7f-a057-cf891920dc40">


For this analysis, the file to be loaded is the database generated in the previous tab, and the necessary .asc layers are those that did not show autocorrelation indicated by the heatmap obtained in EcoNiches or those previously analyzed for your study.
Multiple models can be selected to perform this analysis depending on your needs. The first step is to upload the .csv document with the presence points and pseudo-absences. It is important to note that seconds after loading the file, the first sub-tab called Database will show us the content of the file; if not, it may mean that there is an error in our file or that the good workflow was interrupted.



![Biomod 0 7](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/2b60d6fa-5802-43a8-a4a6-62ee7bb0fe4c)


Next, the display of the button to load the appropriate .asc layers after clicking on the "Load .asc layers" button is the second sign that our .csv database was loaded correctly, otherwise we will not observe the appearance of this option window.

![select  asc files biomod2](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/6186fb94-64b3-4a92-a9ee-c744344418a9)


[biomod2](https://biomodhub.github.io/biomod2/) is a library that allows the analysis of species distribution through 10 models: GLM, GBM, GAM, CTA, ANN, SRE, FDA, RF, MAXENT and MAXNET, that is, it is an ensemble analysis method, so, multiple models can be selected for analysis execution (Huang et al., 2023). For the example shown in this manual through images and databases, all available models were selected (Thuiller et al., 2024). 

![modelosbiomod2](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/82d4a3f8-5815-4604-99b4-858df06f58b4)


Finally, after selecting the data split percentage and the Threshold value, in the second evaluation metrics selection box we can choose the consensus model to perform the analysis. Continuing with our example, we select TSS.
In addition, you can also modify the values of the data split percentage and the number of repetitions according to the parameters necessary for your study.

![upload](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/4122a56b-6eea-4085-bea2-ec1630499644)


Once the analysis begins, in the RStudio console it is possible to view its progress.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/672be5b8-dd70-42be-938e-83586211bfd8)

> [!CAUTION]
>  If you selected the MAXENT model and the files necessary to use it are not found in the working directory, in the pop-up legends in the console we can read the following warning message that indicates that it is necessary to have the files to perform the analysis with this model. You can go to the [MAXENT model](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#maxent-model) section of this manual to find the files.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/d061477f-ed9e-4328-b100-5f9c04d41053)


After pressing the button to start the analysis it is a good idea to move to the second sub-tab of the main panel, model output. When the analyzes are finished, here you will be able to see various values and evaluation results of the models.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/4c7f1533-d873-4d53-8335-b454407cb9a0)

Having the previous results, you can also go to the other sub-tabs to observe the performance of the models, so you can interpret the results through the graphs that you will find in the last three sub-tabs.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/fff1293b-2fcc-42b4-9f84-37922b11b1a0)

Finally, you can view in the last sub-tab the plots of the response curves of each of the models applied to each of the .asc layers according to the number of runs or repetitions.
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/d52df7d6-c644-4658-8d55-c485d78283cb)

You can find the main results stored in a new folder stored in your working directory at the end of the analysis, which will be named with the name of the species of your analysis. Inside you can find another folder, proj_Current, here you will find the .tif file necessary to continue with the workflow in the next EcoNicheS tab.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/7b011b18-988b-4fc2-87b4-68211cc53b30)



## Seventh module: Partial ROC Analysis

As mentioned above, one of the files needed to perform this analysis is part of the results above, but if you already have a Prediction Raster file, you can also upload it in .asc format. Here, we use [ntbox](https://luismurao.github.io/ntbox/) to evaluate the niche modeling carried out.

## Eighth module: Remove urbanization

For this part of the application you must have two raster files, the first must contain only the geographical data of urbanization within the potential distribution area of the study species, the second file must contain such a distribution map, thus, after running the analysis you will obtain an .asc file where said urbanization data was removed from the potential distribution area.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/37fe587e-37bf-4728-86ae-76c8c0eafda2)

## Ninth module: Calculate area
This tab allows you to obtain the area of suitability of the species of interest by uploading the .asc file created in the previous tab or an existing file if applicable. The Suitability Threshold value can be modified according to the appropriate value for your study and the only result consists of the legend obtained in the main panel of the tab as you can see below.

<img width="474" alt="Captura de pantalla 2024-07-20 a la(s) 1 18 01 p m" src="https://github.com/user-attachments/assets/02fd1efa-fd4e-474f-a502-4ac357c2fe91">



## Tenth module: Gains and losses plot

This tab requires two files, the only acceptable format of which is .asc. The first of these raster files must correspond to a file with the characteristics or geographical data of the area of interest. The second file corresponds to a future prediction of the conditions of the landscape.

![gains and losses 16 y 50 cn resultados](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/4c68a466-d6be-47c6-adb1-b9bd4df70638)

## Eleventh module: ENMTools

In this module we will explore Niche Modeling Analysis and niche overlap thanks to ENMTools. For such a task we need you to provide distribution data that includes presence points and pseudo-absences. In this section multiple models can be built using the spatial distribution information and environmental layers relevant to each study (the same data are required in the biomod2 module).
One of the central points of the module is the possibility of evaluating the niche overlap of two different species, resulting in maps and graphs for this purpose. Likewise, it is possible to build niche modeling for both species if desired, otherwise the answer marked as default in the corresponding section must be changed to indicate that only one species should be analyzed, which would be species 1. 

![image](https://github.com/user-attachments/assets/71df3801-9c22-4950-9c18-47eab7631338)

![image](https://github.com/user-attachments/assets/ea99504e-563f-46f3-aab0-6188f62ca0ab)


## Twelfth module: Connectivity

In this module, the graphical interface allows access to the connectivity analyzes that can be performed with [rgeos](https://www.rdocumentation.org/packages/rgeos/versions/0.6-4) and [gdistance](https: //cgspace.cgiar.org/items/87e6fd8b-53ff-4d61-9581-8cc83272ff73).

-----

# Contributions

-Clere Marmolejo and Armando Sunny: Lead developers responsible for coding the application.

-Clere Marmolejo and Armando Sunny: Editors and skilled developers who crafted the polished user interface and functionality of the app.

-Clere Marmolejo, Bolom-Huet R and Armando Sunny: Contributed to the comprehensive function documentation, ensuring clarity and usability.

-López-Vidal R: Provided valuable assistance with server management and website interface design, enhancing the overall user experience.

-Díaz-Sánchez LE and Armando Sunny: Offered financial support, enabling the successful realization of the project.


  
# Citation

#### Please cite as:

Marmolejo C, Bolom-Huet R, López-Vidal R, Díaz-Sánchez LE, Sunny A (2024). EcoNicheS: Empowering Ecological Niche Modeling Analysis with Shinydashboard and R Package. GitHub. https://github.com/armandosunny/EcoNicheS


# Acknowledgements

The creation of this package was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Universidad Autónoma del Estado de México (Grants to AS: 4732/2019CIB and 6801/2022CID), SEP (Grant to AS: PRODEP 511/2022-5401) and CONACYT (Grant to AS: FOINS 6828/2017). A.S: Adahy Olun Contreras-García yo nunca te abandoné, estoy haciendo todo para que la justicia mexicana me permita volver a estar contigo, pero es un proceso muy lento, te extraño mucho.
    </div>
# References

  ACS hosted Feature Layers FAQ_. (n.d.-a). ACS Hosted Feature Layers FAQ.
  https://acs-hosted-feature-layers-faq-esri.hub.arcgis.com/ 

  Aiello-Lammens, M.E., Boria, R.A., Radosavljevic, A., Vilela, B. and Anderson, R.P. (2015), spThin: an R package for spatial thinning of species occurrence records for use in ecological niche models. Ecography, 38: 541-545. https://doi.org/10.1111/ecog.01132

  Cheng J, Schloerke B, Karambelkar B, Xie Y (2023). _leaflet: Create Interactive Web Maps
  with the JavaScript 'Leaflet' Library_. R package version 2.2.1,
  <https://CRAN.R-project.org/package=leaflet>.

  Barve N, Barve V (2019). _ENMGadgets: Pre and Post Processing in ENM Workflow_. R
  package version 0.1.0.1.

  Bengtsson H (2022). _R.utils: Various Programming Utilities_. R package version
  2.12.2, <https://CRAN.R-project.org/package=R.utils>.

  Chang W, Borges Ribeiro B (2021). _shinydashboard: Create Dashboards with 'Shiny'_. R
  package version 0.7.2, <https://CRAN.R-project.org/package=shinydashboard>.
  
  Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J, McPherson J,
  Dipert A, Borges B (2023). _shiny: Web Application Framework for R_. R package version
  1.7.5, <https://CRAN.R-project.org/package=shiny>.

  Fick, S.E. and R.J. Hijmans, 2017. WorldClim 2: new 1km spatial resolution climate surfaces for global land areas. International Journal of Climatology 37 (12): 4302-4315.

GBIF: The Global Biodiversity Information Facility (year) What is GBIF?. Available from https://www.gbif.org/what-is-gbif [13 January 2020].

  Hernangomez D (2023). tidyterra: tidyverse Methods and ggplot2 Helpers for terra
  Objects. <https://doi.org/10.5281/zenodo.6572471>,
  <https://dieghernan.github.io/tidyterra/>

Hernangómez D (2023). Using the tidyverse with terra objects: the tidyterra package. Journal of Open Source Software, 8(91), 5751, https://doi.org/10.21105/joss.05751.

Hijmans R (2023). _raster: Geographic Data Analysis and Modeling_. R package version
  3.6-23, <https://CRAN.R-project.org/package=raster>.

  Hijmans R (2023). _terra: Spatial Data Analysis_. R package version 1.7-46,
  <https://CRAN.R-project.org/package=terra>.

Hijmans RJ, Phillips S, Leathwick J, Elith J (2023). _dismo: Species Distribution
  Modeling_. R package version 1.3-14, <https://CRAN.R-project.org/package=dismo>.

    Huang D, An Q, Huang S, Tan G, Quan H, Chen Y, Zhou J, Liao H. (2023). 
  biomod2 modeling for predicting the potential ecological distribution of three Fritillaria species under climate change. 
  _Scientific reports_, 13(1), 18801. https://doi.org/10.1038/s41598-023-45887-6

  Naimi B, Hamm Na, Groen TA, Skidmore AK, Toxopeus AG (2014). “Where is positional
  uncertainty a problem for species distribution modelling.” _Ecography_, *37*, 191-203.
  <https://doi.org/10.1111/j.1600-0587.2013.00205.x>.

  Neuwirth E (2022). _RColorBrewer: ColorBrewer Palettes_. R package version 1.1-3,
  <https://CRAN.R-project.org/package=RColorBrewer>.

Osorio-Olvera L, Lira-Noriega A, Soberón J, et al. (2020) ntbox: An r package with graphical user interface for modelling and evaluating multidimensional ecological niches. Methods Ecol Evol. 11: 1199–1206. https://doi.org/10.1111/2041-210X.13452

  R Core Team (2023). _R: A Language and Environment for Statistical Computing_. R
  Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

  Robin X, Turck N, Hainard A, Tiberti N, Lisacek F, Sanchez JC, Müller M. (2011). pROC: an open-source package for R and S+ to analyze and compare ROC curves. BMC Bioinformatics 12, 77 https://doi.org/10.1186/1471-2105-12-77

  Steven J. Phillips, Miroslav Dudík, Robert E. Schapire. [Internet] Maxent software for modeling species niches and distributions (Version 3.4.1). Available from url: http://biodiversityinformatics.amnh.org/open_source/maxent/. Accessed on 2024-1-11.

  Thuiller W, Georges D, Gueguen M, Engler R, Breiner F, Lafourcade B, Patin R (2023).
  _biomod2: Ensemble Platform for Species Distribution Modeling_. R package version
  4.2-4, <https://CRAN.R-project.org/package=biomod2>.

  Urbanek S (2021). _rJava: Low-Level R to Java Interface_. R package version 1.0-6,
  <https://CRAN.R-project.org/package=rJava>.

  Urbanek S, Johnson K (2022). _tiff: Read and Write TIFF Images_. R package version
  0.1-11, <https://CRAN.R-project.org/package=tiff>.

Warren DL, Matzke NJ, Cardillo M, Baumgartner JB, Beaumont LJ, Turelli M, Glor RE, Huron NA, Simões M, Iglesias TL Piquet JC, Dinnage R (2021). ENMTools 1.0: an R package for comparative ecological biogeography. Ecography, 44(4), pp.504-511.

Zizka A, Silvestro D, Andermann T, Azevedo J, Duarte Ritter C, Edler D, Farooq H, Herdean A, Ariza M, Scharn R, Svanteson S, Wengstrom N, Zizka V, Antonelli A (2019). “CoordinateCleaner: standardized cleaning of occurrence records from biological collection databases.” Methods in Ecology and Evolution, -7. doi:10.1111/2041-210X.13152, R package version 3.0.1, https://github.com/ropensci/CoordinateCleaner.


## Problems installing packages

By using the commands to install the library, problems can arise on each device, so there may be errors when installing the packages. If so, these errors will appear in RStudio and EcoNicheS will not be able to be opened. In this case, please go to the R packages folder where the libraries are located in .tar.gz format and follow the steps shown below to manually install those packages with which there are problems.

Open RStudio and go to the top menu and click on the **Tools** button, a new menu will be displayed, where you must click on the **Install Packages** option.

![RStudio Tools](https://github.com/armandosunny/EcoNicheS/assets/25662791/a06fa320-a49d-46ac-80fd-03d2f3807028)

![RStudio Tools Install](https://github.com/armandosunny/EcoNicheS/assets/25662791/61dc1f41-70a5-4fb7-9996-d8f2ad9ccb48)

In the window that will open, in _Install from_, select the second option, which will allow us to install packages in .tar.gz format. Next, click on **Browse**, and search your devices for the file(s) downloaded from the R Packages folder in this repository. Select the package(s) that presented problems during installation and _without having to change the option in the Install to library section_ (it is best to leave the default option) and click on **Install**.

![Select tar](https://github.com/armandosunny/EcoNicheS/assets/25662791/8041633b-be48-4bbd-b4e6-10250067a71e)

![rgdal](https://github.com/armandosunny/EcoNicheS/assets/25662791/6bc0952f-92da-4f12-bd5c-e86a4256d66a)

You will start to see messages appearing in the RStudio console, these will continue to appear until the package installation is complete. Once RStudio finishes working, at the end of the messages you should find one that mentions that the job is finished and the library has been installed. To verify that the installation was successful, you can try the following command, remembering that in each action you must look for errors that may indicate a problem. If installed correctly, there will be no message indicating any error.

``` r
library(rgdal)
```

![Installing](https://github.com/armandosunny/EcoNicheS/assets/25662791/a89e99c6-cf45-4058-a991-0813aaa5718c)

![Done](https://github.com/armandosunny/EcoNicheS/assets/25662791/dda83dc8-bd73-45e2-9081-9076a3edd63f)

-----

## Centro de Innovación Digital "Mandra"
#### Laboratorio Nacional de SuperCómputo, CONAHCYT-Facultad de Ciencias, UAEMex.

<div style="display: flex; flex-direction: column; align-items: center;">
    <a href="https://github.com/armandosunny/EcoNicheS/assets/25662791/ae7755de-7376-46c2-a43d-97c11076d2ea" target="_blank"><img src="https://github.com/armandosunny/EcoNicheS/assets/25662791/ae7755de-7376-46c2-a43d-97c11076d2ea" alt="imagen" width="250"></a>
    <div style="display: flex; justify-content: center;">
        <a href="https://github.com/armandosunny/EcoNicheS/assets/25662791/5a6a6a43-5663-40fc-9525-3041e6d32f30" target="_blank"><img src="https://github.com/armandosunny/EcoNicheS/assets/25662791/5a6a6a43-5663-40fc-9525-3041e6d32f30" alt="imagen" width="150"></a>
        <a href="https://github.com/armandosunny/EcoNicheS/assets/25662791/58dd866a-18af-4bd8-b8bf-d0916cb9159d" target="_blank"><img src="https://github.com/armandosunny/EcoNicheS/assets/25662791/58dd866a-18af-4bd8-b8bf-d0916cb9159d" alt="imagen" width="60"></a>
        <a href="https://github.com/armandosunny/EcoNicheS/assets/25662791/064fd750-877a-465e-a9c7-e467281f54d9" target="_blank"><img src="https://github.com/armandosunny/EcoNicheS/assets/25662791/064fd750-877a-465e-a9c7-e467281f54d9" alt="imagen" width="100"></a>
        <a href="https://github.com/armandosunny/EcoNicheS/assets/25662791/5e9f3491-01c3-46b9-89e3-48807fdfe496" target="_blank"><img src="https://github.com/armandosunny/EcoNicheS/assets/25662791/5e9f3491-01c3-46b9-89e3-48807fdfe496" alt="imagen" width="90"></a>
    </div>
