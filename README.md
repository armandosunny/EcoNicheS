# EcoNicheS  
<img src="https://github.com/user-attachments/assets/cc761f7a-038a-4641-bb2c-23a4674d7989" align="right" height="200" />

### EcoNicheS: enhancing ecological niche modeling, niche overlap and connectivity analysis using the shiny dashboard and R package.

Please Cite this as:
Sunny A, Marmolejo C, Vidal-López R, Falconi-Briones FA, Cuervo-Robayo ÁP, Bolom-Huet R. 2025. EcoNicheS: enhancing ecological niche modeling, niche overlap and connectivity analysis using the shiny dashboard and R package. PeerJ 13:e19136 https://doi.org/10.7717/peerj.19136 
![Captura de pantalla 2025-03-28 a la(s) 5 33 02 a m](https://github.com/user-attachments/assets/8e85f9ea-bc4e-4a75-9f76-6fea7c323420)

### This is Version 1.1.0, last updated on May 20, 2025. Future versions will include additional analyses and enhancements.

Need Help or Found a Bug?
For any questions, comments, or to report bugs related to EcoNicheS, feel free to:

Send an email to: econichesapp@gmail.com, sunny.biologia@gmail.com

Leave a message in the Issues section of the repository.
We value your feedback and are here to help!

Infographic Support on Facebook
To help users troubleshoot common errors and improve their experience with EcoNicheS, we will be uploading infographics and tips based on user-reported issues on our Facebook page:
👉 
[Visit our Facebook page for infographics and tips](https://www.facebook.com/profile.php?id=61572266648336)

Feel free to follow the page and share your questions or suggestions!



You can also watch a tutorial video on YouTube here:
[YouTube Tutorial](https://www.youtube.com/watch?v=fLul1kkZhfI&t=27s)

Visit our official website for more information:
[EcoNicheS Website](https://armandosunny.github.io/EcoNicheS/)


-----
#### Schematic description of the ecological niche modeling process, and steps that can be performed using the EcoNicheS package.

![Fig_2_Flowchart Econiches](https://github.com/user-attachments/assets/ff2beaa0-59af-47b7-ad21-a4dcf1608aaa)

# EcoNicheS Installation Guide

## Step 1: Install Required Software

### 1.1 Install 64-bit Java
EcoNicheS requires 64-bit Java. Download and install it from [Oracle Java](https://www.oracle.com/java/technologies/downloads/). The `.exe` file is the easiest option for Windows users.

### 1.2 Install R, RStudio, and RTools
- **R**: Download and install it from [CRAN](https://cran.r-project.org/).
- **RStudio**: Download the desktop version from [Posit](https://posit.co/download/rstudio-desktop/).
- **RTools** (Windows only): Download it from [RTools](https://cran.r-project.org/bin/windows/Rtools/).

> **Tip for Beginners**  
> Need help with R installation? Check out the [Hands-On Programming with R](https://rstudio-education.github.io/hopr/starting.html) guide.

---
## 2 Install EcoNicheS Dependencies

## GitHub Libraries
Some libraries are not available on CRAN and must be installed from GitHub. Run the following commands in your R console:

```
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")

# Install ntbox
remotes::install_github("luismurao/ntbox")

# Install ENMTools
remotes::install_github("danlwarren/ENMTools")
```

### CRAN Libraries
EcoNicheS depends on several R libraries. Copy and paste the following command into your R console to install them all at once:

```
# Installation of Required R Packages

# List of packages
packages <- c("shiny", "terra", "usdm", "ENMTools", "biomod2", "RColorBrewer", 
             "dismo", "tiff", "rJava", "tidyterra", "shinydashboard", "pROC", 
             "R.utils", "countrycode", "CoordinateCleaner", "dplyr", "ggplot2", 
             "rgbif", "sf", "rnaturalearthdata", "spThin", "shinyjs", "leaflet", 
             "DT", "shinyBS", "prettymapr", "ntbox", "gt", "tidyverse", "gtExtras", 
             "shinyBS", "leaflet.extras", "geodata", "viridis", "ggthemes", "sp", 
             "earth", "xgboost", "gdistance", "foreach", "doParallel", "raster", 
             "progress", "readr", "MIAmaxent", "shiny", "terra", "sf", "gdistance", "viridis")

# Install missing packages
missing_packages <- packages[!(packages %in% installed.packages()[,"Package"])]

if(length(missing_packages)) {
  install.packages(missing_packages, dependencies = TRUE)
}

# Load all packages
lapply(packages, library, character.only = TRUE)
```

---

---

## Step 4: Increase Memory for Java (Optional but Recommended)

Before loading the graphical interface, run this line to increase the memory available for `rJava`:

```
options(shiny.maxRequestSize = 6000*1024^2)
```

---

## Step 5: Running EcoNicheS

### 5.1 Download the EcoNicheS Script
1. Go to the [EcoNicheS GitHub Repository](https://github.com/armandosunny/EcoNicheS).
2. Download the `EcoNicheS.R` file.

### 5.2 Run the Script
1. Open the `EcoNicheS.R` file in a text editor (e.g., Notepad).
2. Copy all the code.
3. Paste it into the R console and press Enter to run the script.

---

## Additional Notes

- **Working Directory**: Set the working directory in RStudio where your databases and results will be saved:  
  Go to `Session` ➜ `Set Working Directory` ➜ `Choose Directory`, and select your folder.

- **MAXENT Model**: If using the MAXENT model, ensure the required files are in your working directory. Download them from [here](https://doi.org/10.6084/m9.figshare.24980664.v1).

- **Troubleshooting**:  
  If you encounter issues during installation or execution, refer to the [Problems Installing Packages](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#problems-installing-packages) section in the manual.

---

> [!IMPORTANT]
> ## We apologize for the inconvenience of not being able to run the command directly from GitHub at this time, but we are working to resolve the issue as soon as possible."



![Captura de pantalla 2025-05-17 a la(s) 7 41 41 a m](https://github.com/user-attachments/assets/1f2e564b-1044-4c10-a7ff-31d0fb67b129)




# Learning how to use EcoNicheS

To know and understand in detail the functions that EcoNicheS offers and the results that we can obtain from them, we invite you to learn about the application through this manual. You can also learn more about the application and its scope in the report published about it [here].


-----

# Exploring EcoNicheS features

EcoNicheS is an interactive web application that consists of 12 modules: **[Environmental Data](https://github.com/armandosunny/EcoNicheS?tab=readme-ov-file#first-module-environmental-data), [Occurrence processing](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#second-module-obtaining-and-cleaning-species-occurrences), [Load and Plot Maps (2x)](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#third-module-load-and-plot-maps), [Correlation layers](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#fourth-module-correlation-analysis-between-asc-layers), [Points and pseudoabsences](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#fifth-module-points-and-pseudoabsences), [biomod2](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#sixth-module-biomod2), [Partial ROC Analysis](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#seventh-module-partial-roc-analysis), [Remove urbanization](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#eighth-module-remove-urbanization), [Calculate area](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#ninth-module-calculate-area), [Gains and Losses Plot](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#tenth-module-gains-and-losses-plot), [ENMTools](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#eleventh-module-enmtools), and [Connectivity](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#twelfth-module-connectivity)**. 

You can use these functions in order to perform the analyzes and evaluations of niche modeling, niche overlap and connectivity analysis with circuit theory. The application before, during and at the end of the analyzes has pop-up windows that will indicate errors or data necessary to continue, and you will also be able to see the progress of the work in the lower left corner every time you press the execution buttons. You must take into account that this first version of EcoNicheS does not allow you to cancel the analyses, they are only interrupted if the application detects an error in the analysis execution sequences, because this is sequential and this implies that the progress can stop when detecting an error, please make sure you enter the correct data before submitting it to analysis.


![Fig_1_UI](https://github.com/user-attachments/assets/1254f743-ed56-4d7e-aecf-47a740bff596)


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


> [!CAUTION]
> In order to use your databases, the _.csv base file_ must have the _name of the species listed in the first column_, followed by _longitude (X)_ in the second column, and _latitude (Y)_ in the third column as seen below. _Editing your database respecting lowercase and uppercase letters is essential for the analysis to proceed_.

<img width="528" alt="Captura de pantalla 2024-07-20 a la(s) 12 16 08 p m" src="https://github.com/user-attachments/assets/cd9ef681-0136-4d28-8a02-77297a7f62ed">


### Get and Clean GBIF data

Obtaining geographical distribution data is achieved using the [CoordinateCleaner](https://ropensci.github.io/CoordinateCleaner/articles/Cleaning_GBIF_data_with_CoordinateCleaner.html) package (Zizka et al., 2019). So, when opening the application, the first step is to select the first option from the drop-down menu to access the data collection tools.The next step is to enter the scientific name of the species of interest, in addition to entering the maximum amount of presence data that you wish to obtain. Obtaining the data may take a while, the greater the distribution of the species, the longer the waiting time will also be, but never beyond a few minutes.

At the end of your search, you will see on the screen an interactive map created with [leaflet](https://cran.r-project.org/package=leaflet) (Cheng et al., 2023), which will allow you to visualize the global distribution of the data. In addition, you will find graphs and metadata provided by GBIF and CoordinateCleaner that will allow you to have information about the records found, for example, Coordinate is also based on automated data cleaning tests and algorithms to identify and remove records that may be flagged as erroneous or imprecise (Zizka et al., 2019). We can see this through the graphs shown in the application, in addition to having the raw data in the database that is generated and saved in the working directory.

<img width="1044" alt="Captura de pantalla 2024-07-20 a la(s) 10 54 22 a m" src="https://github.com/user-attachments/assets/deb78ec7-f413-4795-b993-653144151ca7">

CoordinateCleaner uses the metadata to clean the data, and one of these parameters is coordinateUncertaintyInMeters, which describes the smallest circle containing the whole of the Location and serves as a reference for the accuracy of the coordinate location, in addition, it allows estimating the potential distance of the real occurrence location from the recorded values [(GBIF.org, 2024)](https://www.gbif.org/data-quality-requirements-occurrences#dcUncertainty). Finally, it is also possible to filter the clean data according to the year and location of interest either using a coordinate system or applying a filter by country (Zizka et al., 2019).

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

Here, using [dismo](https://cran.r-project.org/package=dismo) (Hijmans et al., 2023), by uploading our previously edited .csv file* and any of our .asc layers, as a result, points that correspond to the "pseudo-absences" will be generated, those will serve as a background and are necessary for ecological niche modeling. 

> [!CAUTION]
> *In order to use your databases, the _.csv base file_ must have the _name of the species listed in the first column_, followed by _longitude (X)_ in the second column, and _latitude (Y)_ in the third column as seen below. _Editing your database respecting lowercase and uppercase letters is essential for the analysis to proceed_.

<img width="528" alt="Captura de pantalla 2024-07-20 a la(s) 12 16 08 p m" src="https://github.com/user-attachments/assets/cd9ef681-0136-4d28-8a02-77297a7f62ed">

In the example shown below, 1000000 was used as the number of random points, however the default value is 100, but it can be modified, so the appropriate number of points for our study can be indicated in the third box of the tab.

First you will be able to see a simple map that shows the distribution of the pseudo-absences generated, you can download this map in pdf. Below it you will find an interactive map which will allow you to visually understand the database generated and stored in your work directory. In this map you can view the distribution of the original points of presence and the points added as pseudo-absences. In the .csv database created, each one is distinguished by the "response" that accompanies each coordinate, if the value is 1 it is the points of presence, if the value is 0 the longitude and latitude correspond to a value of pseudo-absence. Before running the analysis, the name of the generated database can and must be modified from default name by always maintaining the .csv extension, in this way we ensure that its creation and saving are being carried out correctly.

<img width="1040" alt="Captura de pantalla 2024-07-20 a la(s) 11 38 13 a m" src="https://github.com/user-attachments/assets/146a6485-a8e8-4c83-9d83-4bb91eed0dd4">



Thus, the database with the coordinates of our species now consists of 5 columns, the new pair is a first column, where the amount of data is listed numerically, and a last column where the points of presence of our species were assigned the number 1, while pseudo-absences were assigned a 0.

<img width="752" alt="Captura de pantalla 2024-07-20 a la(s) 2 59 50 p m" src="https://github.com/user-attachments/assets/e9364670-077c-4bf2-9323-f1b443cfcb6e">



## Sixth module: biomod2
> [!IMPORTANT]
> For more information, you can consult the biomod2 page:https://biomodhub.github.io/biomod2/index.html

![SCHEMA_BIOMOD2_WORKFLOW_functions](https://github.com/user-attachments/assets/0ad6d12a-66b7-4934-afc1-e014caac3dd9)

This figure showing how biomod2 works was taken from the biomod2 page:https://biomodhub.github.io/biomod2/index.html


For this module to work well, it is necessary to have the maxent files in the same folder where the .asc layers and the database with the presences and pseudo-absences of the species to be analyzed are located.

<img width="752" alt="Captura de pantalla 2024-07-20 a la(s) 3 24 11 p m" src="https://github.com/user-attachments/assets/39d263ff-b80d-4e7f-a057-cf891920dc40">


For this analysis, the file to be loaded is the database generated in the previous tab, and the necessary .asc layers are those that did not show autocorrelation indicated by the heatmap obtained in EcoNiches or those previously analyzed for your study.
Multiple models can be selected to perform this analysis depending on your needs. The first step is to upload the .csv document with the presence points and pseudo-absences. It is important to note that seconds after loading the file, the first sub-tab called Database will show us the content of the file; if not, it may mean that there is an error in our file or that the good workflow was interrupted.



<img width="870" alt="Captura de pantalla 2024-09-22 a la(s) 7 27 02 a m" src="https://github.com/user-attachments/assets/a07866da-f661-49ff-8ee7-d0f26fbda9d5">



Next, the display of the button to load the appropriate .asc layers after clicking on the "Load .asc layers" button is the second sign that our .csv database was loaded correctly, otherwise we will not observe the appearance of this option window.


<img width="862" alt="Captura de pantalla 2024-09-22 a la(s) 7 28 58 a m" src="https://github.com/user-attachments/assets/91c7e2b9-eaa2-465d-b718-5b8e88fc065f">


[biomod2](https://biomodhub.github.io/biomod2/) is a library that allows the analysis of species distribution through 14 models: GLM, GBM, GAM, CTA, ANN, SRE, FDA, RF, MAXENT,  MAXNET, MARS and XGBOOST that is, it is an ensemble analysis method, so, multiple models can be selected for analysis execution (Huang et al., 2023). For the example shown in this manual through images and databases, all available models were selected (Thuiller et al., 2024). 

<img width="864" alt="Captura de pantalla 2024-09-22 a la(s) 7 44 07 a m" src="https://github.com/user-attachments/assets/b3aed45f-7c01-4782-84ba-1676bfef2dbd">


<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 1 44 31 p m" src="https://github.com/user-attachments/assets/57ecbd35-9f00-44c8-a017-8cf39a010ee7">



Finally, after selecting the data split percentage and the Threshold value, in the second evaluation metrics selection box we can choose the consensus model to perform the analysis. Continuing with our example, we select TSS.
In addition, you can also modify the values of the data split percentage and the number of repetitions according to the parameters necessary for your study.


<img width="579" alt="Captura de pantalla 2024-09-22 a la(s) 7 51 28 a m" src="https://github.com/user-attachments/assets/0597e8d9-6f8b-4d35-b3a7-5d7adf792f68">


Once the analysis begins, in the RStudio console it is possible to view its progress.

<img width="863" alt="Captura de pantalla 2024-09-22 a la(s) 7 58 20 a m" src="https://github.com/user-attachments/assets/4ec8eccc-d1e1-4d6e-b90d-9d213fdcd9a5">


> [!CAUTION]
>  If you selected the MAXENT model and the files necessary to use it are not found in the working directory, in the pop-up legends in the console we can read the following warning message that indicates that it is necessary to have the files to perform the analysis with this model. You can go to the [MAXENT model](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#maxent-model) section of this manual to find the files.


<img width="868" alt="Captura de pantalla 2024-09-22 a la(s) 12 20 53 p m" src="https://github.com/user-attachments/assets/9ac767f2-cafa-4200-92cd-3e04714bfc3d">


After pressing the button to start the analysis it is a good idea to move to the second sub-tab of the main panel, model output. When the analyzes are finished, here you will be able to see various values and evaluation results of the models.

<img width="865" alt="Captura de pantalla 2024-09-22 a la(s) 8 10 36 a m" src="https://github.com/user-attachments/assets/36a50e9a-3e48-430b-b20d-01bffa289a7d">


Having the previous results, you can also go to the other sub-tabs to observe the performance of the models, so you can interpret the results through the graphs that you will find in the last three sub-tabs.

<img width="865" alt="Captura de pantalla 2024-09-22 a la(s) 8 10 40 a m" src="https://github.com/user-attachments/assets/38089c3f-c26e-44d9-8ceb-fca18d5d5b96">

<img width="865" alt="Captura de pantalla 2024-09-22 a la(s) 8 10 45 a m" src="https://github.com/user-attachments/assets/3641f02f-6d5d-435f-a333-5a528d86d074">




Finally, you can view in the last sub-tab the plots of the response curves of each of the models applied to each of the .asc layers according to the number of runs or repetitions.

<img width="865" alt="Captura de pantalla 2024-09-22 a la(s) 8 10 48 a m" src="https://github.com/user-attachments/assets/f837e9b3-59c8-45c1-923a-9934138d28d0">


You can find the main results stored in a new folder stored in your working directory at the end of the analysis, which will be named with the name of the species of your analysis. Inside you can find another folder, proj_Current, here you will find the .tif file necessary to continue with the workflow in the next EcoNicheS tab.

<img width="1056" alt="Captura de pantalla 2024-09-22 a la(s) 12 38 15 p m" src="https://github.com/user-attachments/assets/e32ee8cd-c193-4604-b6f2-37a8b3d0b30c">

<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 1 36 41 p m" src="https://github.com/user-attachments/assets/2085ab2b-e3d3-40b8-80bc-da25d530b5ed">



## Seventh module: Load and Plot Maps

In this module, you can upload .asc, .tiff, .tif, or .bil files to display the Ecological Niche Modeling map on an interactive interface. The raster map is overlaid on a satellite or OpenStreetMap (OSM) base layer, allowing you to visualize the study area with the raster values clearly shown for detailed analysis.

<img width="1106" alt="Captura de pantalla 2025-01-15 a la(s) 9 01 44 a m" src="https://github.com/user-attachments/assets/daa812c7-451a-45ed-ae25-7956af427903" />


## Eighth module: Partial ROC Analysis

As mentioned above, one of the files needed to perform this analysis is part of the results above, but if you already have a Prediction Raster file, you can also upload it in .asc format. Here, we use [ntbox](https://luismurao.github.io/ntbox/) (Osorio-Olvera et al., 2020) to evaluate the niche modeling carried out. 

> [!CAUTION]
>If your raster map contains values ranging from 0 to 1, such as those generated by MaxEnt or ENMeval, please click the button labeled Run ROC (0-1). However, if the raster map was generated using biomod2, where values range from 0 to 100, make sure to click the button labeled Run ROC (0-100) to ensure proper analysis.

<img width="1117" alt="Captura de pantalla 2025-01-15 a la(s) 8 47 08 a m" src="https://github.com/user-attachments/assets/601123b4-3b76-4eaa-a43a-dba7d49d273c" />

## Ninth module: Remove Raster Layer (e.g., Urbanization)
In this part of the application, you must have two raster files. The first file should contain the geographical data you want to remove (e.g., urbanization, water bodies, or any other raster layer) within the potential distribution area of the study species. The second file must contain the species' potential distribution map. After running the analysis, you will obtain an .asc file where the specified data has been removed from the potential distribution area.

In this section, you can also view the uploaded maps and the resulting map after removing the specified geographical layer.

Note: This module is not limited to removing urbanization—it can remove data from any raster layer based on another raster file.



<img width="1055" alt="Captura de pantalla 2024-09-22 a la(s) 12 57 19 p m" src="https://github.com/user-attachments/assets/156305a9-ddb3-4cc5-a865-f61bb0f2ee52">

Result 


<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 1 07 28 p m" src="https://github.com/user-attachments/assets/91a8e613-0d82-4013-b061-df55c7ad6aed">




## Tenth module: Calculate area
This tab enables you to calculate the suitability area for the species of interest by uploading a .asc, tif and bil file generated in the previous tab or an existing file if applicable. The Suitability Threshold can be adjusted based on the specific requirements of your study. In addition to providing a numerical result, the module also visualizes the remaining suitable area on a map, allowing you to clearly see the regions that meet the selected threshold. The results, including the legend and map, are displayed in the main panel below for easy interpretation.

<img width="1144" alt="Captura de pantalla 2025-01-16 a la(s) 1 27 38 p m" src="https://github.com/user-attachments/assets/9ed2ae0b-4d6c-45ee-9184-bb66e96a9717" />



## Eleventh module: Gains and losses plot

This tab requires two input files in .asc, .tiff, or .bil format. It allows you to analyze changes between two raster maps, highlighting variable gains and losses. To use this module, you need to provide a map from the initial time point (Time 1) and another from the subsequent time point (Time 2). The resulting analysis will help you visualize the changes that occurred in the area over time.

<img width="1143" alt="Captura de pantalla 2025-01-16 a la(s) 8 51 33 a m" src="https://github.com/user-attachments/assets/491248fe-cb28-46a3-8926-e7b25e47e052" />


## Twelfth module: ENMTools

In this module we will explore Niche Modeling Analysis and niche overlap thanks to [ENMTools](https://github.com/danlwarren/ENMTools) (Warren et al., 2021). For such a task we need you to provide distribution data that includes presence points and pseudo-absences. In this section multiple models can be built using the spatial distribution information and environmental layers relevant to each study (the same data are required in the biomod2 module).
One of the central points of the module is the possibility of evaluating the niche overlap of two different species, resulting in maps and graphs for this purpose. Likewise, it is possible to build niche modeling for both species if desired, otherwise the answer marked as default in the corresponding section must be changed to indicate that only one species should be analyzed, which would be species 1. Note: This module, "mx," contains the MAXENT algorithm, some analyses  are displayed in the R studio console and others in the EconNicheS console.


<img width="969" alt="Captura de pantalla 2024-09-22 a la(s) 9 39 19 a m" src="https://github.com/user-attachments/assets/e678d5f1-b5f5-49fa-9da5-3de857340730">


  <img width="1034" alt="Captura de pantalla 2024-09-22 a la(s) 10 16 29 a m" src="https://github.com/user-attachments/assets/11195445-4460-4030-87c2-468be5b1c55e">



<img width="955" alt="Captura de pantalla 2024-09-22 a la(s) 9 51 51 a m" src="https://github.com/user-attachments/assets/aa0a24b5-c56e-4875-81c0-461d09fa117b">


<img width="955" alt="Captura de pantalla 2024-09-22 a la(s) 9 51 55 a m" src="https://github.com/user-attachments/assets/f82b08c8-bf46-4a48-88d6-75cefab8432e">

<img width="955" alt="Captura de pantalla 2024-09-22 a la(s) 9 51 59 a m" src="https://github.com/user-attachments/assets/f161d2fe-3b20-450b-9667-f4b18da5fc17">

<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 1 29 04 p m" src="https://github.com/user-attachments/assets/9b445771-fa21-4067-b9f9-2066aef7c891">


<img width="961" alt="Captura de pantalla 2024-09-22 a la(s) 10 08 44 a m" src="https://github.com/user-attachments/assets/6a1c9da0-ee26-4473-aeb9-f4e514060079">



## Thirteenth module: Connectivity

Landscape connectivity refers to the degree to which an environment facilitates or impedes the movement of organisms between different locations (Taylor et al., 1993; Tischendorf and Fahrig, 2000). In EcoNiches, users can generate ecological connectivity models by creating flow maps. The connectivity analysis uses habitat suitability as a resistance surface and employs conductance analysis through the gdistance package (van Etten, 2017). Users need species occurrence data and a resistance raster, which may contain species distribution model data or landscape elements with resistance values. The module splits the data into 80% for training and 20% for testing (Joseph, 2022). The resulting flow maps integrate least-cost path analysis and Circuitscape-type analyses to evaluate potential connectivity, identifying the shortest possible paths between locations within the area of interest. 

## Map inverter: 

This module transforms the potential distribution modeling map into a resistance map by multiplying its values by *-1. The resulting map is essential for circuit theory connectivity analysis and the identification of Least Cost Path (LCP) corridors.

<img width="858" alt="Captura de pantalla 2024-12-02 a la(s) 10 56 25 a m" src="https://github.com/user-attachments/assets/dc5e0ded-8944-49c8-b836-38b41c1ab17e">


## Connectivity Circuit theory: 

This module conducts a functional connectivity analysis based on circuit theory, employing a methodology akin to Circuitscape.

<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 1 32 12 p m" src="https://github.com/user-attachments/assets/22ac85b4-4a18-4690-ba1e-2f49117bd060">

## LCP Corridors: 

This module performs an analysis using least-cost maps to visualize optimal paths, highlighting routes with the lowest, intermediate, and highest resistance. These paths are represented using a color gradient ranging from red (high resistance) to green (low resistance).

<img width="858" alt="Captura de pantalla 2024-12-02 a la(s) 10 54 48 a m" src="https://github.com/user-attachments/assets/94200ff1-d1ea-4c2e-ad65-1e057c43127e">


-----

# Contributions

-Clere Marmolejo and Armando Sunny: Lead developers responsible for coding the application.

-Clere Marmolejo and Armando Sunny: Editors and skilled developers who crafted the polished user interface and functionality of the app.

-Clere Marmolejo, Rene Bolom-Huet, Angela P. Cuervo-Robayo and Armando Sunny: Contributed to the comprehensive function documentation, ensuring clarity and usability.

-Rodrigo López-Vidal: Provided valuable assistance with server management and website interface design, enhancing the overall user experience. (It will soon be available in the internet browser on the Mandra website.)

-Armando Sunny: Offered financial support, enabling the successful realization of the project.

<img width="904" alt="Captura de pantalla 2024-12-02 a la(s) 10 54 30 a m" src="https://github.com/user-attachments/assets/cc40a304-ba91-46ef-ae2d-1a05901fd3bf">


  
# Citation

#### Please cite as:

Sunny A, Marmolejo C, Vidal-López R, Falconi-Briones FA, Cuervo-Robayo ÁP, Bolom-Huet R. 2025. EcoNicheS: enhancing ecological niche modeling, niche overlap and connectivity analysis using the shiny dashboard and R package. PeerJ 13:e19136 https://doi.org/10.7717/peerj.19136 


![Captura de pantalla 2025-03-28 a la(s) 5 33 02 a m](https://github.com/user-attachments/assets/8982e3bc-7083-4810-8516-c706cf7d6647)



# Acknowledgements

The creation of this package was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Universidad Autónoma del Estado de México (Grants to AS: 4732/2019CIB, 6801/2022CID and 7194/2025CIB), SEP (Grant to AS: PRODEP 511/2022-5401) and CONACYT (Grant to AS: FOINS 6828/2017). A.S: Adahy Olun Contreras-García yo nunca te abandoné, estoy haciendo todo para que la justicia mexicana me permita volver a estar contigo, pero es un proceso muy lento, te extraño mucho.
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

GBIF: The Global Biodiversity Information Facility (2024) What is GBIF?. Available from https://www.gbif.org/what-is-gbif [28 July 2024].

GBIF.org (2024) *Data quality requirements: Occurrence datasets*. Available from [https://www.gbif.org/what-is-gbif](https://www.gbif.org/data-quality-requirements-occurrences#dcUncertainty) [28 July 2024].

Hernangomez D (2023). tidyterra: tidyverse Methods and ggplot2 Helpers for terra Objects. <https://doi.org/10.5281/zenodo.6572471>, <https://dieghernan.github.io/tidyterra/>

Hernangómez D (2023). Using the tidyverse with terra objects: the tidyterra package. Journal of Open Source Software, 8(91), 5751, https://doi.org/10.21105/joss.05751.

Hijmans R (2023). _raster: Geographic Data Analysis and Modeling_. R package version 3.6-23, <https://CRAN.R-project.org/package=raster>.

  Hijmans R (2023). _terra: Spatial Data Analysis_. R package version 1.7-46,  <https://CRAN.R-project.org/package=terra>.

Hijmans RJ, Phillips S, Leathwick J, Elith J (2023). _dismo: Species Distribution Modeling_. R package version 1.3-14, <https://CRAN.R-project.org/package=dismo>.

Huang D, An Q, Huang S, Tan G, Quan H, Chen Y, Zhou J, Liao H. (2023). biomod2 modeling for predicting the potential ecological distribution of three Fritillaria species under climate change. _Scientific reports_, 13(1), 18801. https://doi.org/10.1038/s41598-023-45887-6

  Naimi B, Hamm Na, Groen TA, Skidmore AK, Toxopeus AG (2014). “Where is positional uncertainty a problem for species distribution modelling.” _Ecography_, *37*, 191-203. <https://doi.org/10.1111/j.1600-0587.2013.00205.x>.

  Neuwirth E (2022). _RColorBrewer: ColorBrewer Palettes_. R package version 1.1-3, <https://CRAN.R-project.org/package=RColorBrewer>.

Osorio-Olvera L, Lira-Noriega A, Soberón J, et al. (2020) ntbox: An r package with graphical user interface for modelling and evaluating multidimensional ecological niches. Methods Ecol Evol. 11: 1199–1206. https://doi.org/10.1111/2041-210X.13452

  R Core Team (2023). _R: A Language and Environment for Statistical Computing_. R Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

  Robin X, Turck N, Hainard A, Tiberti N, Lisacek F, Sanchez JC, Müller M. (2011). pROC: an open-source package for R and S+ to analyze and compare ROC curves. BMC Bioinformatics 12, 77 https://doi.org/10.1186/1471-2105-12-77

  Steven J. Phillips, Miroslav Dudík, Robert E. Schapire. [Internet] Maxent software for modeling species niches and distributions (Version 3.4.1). Available from url: http://biodiversityinformatics.amnh.org/open_source/maxent/. Accessed on 2024-1-11.

  Thuiller W, Georges D, Gueguen M, Engler R, Breiner F, Lafourcade B, Patin R (2023)._biomod2: Ensemble Platform for Species Distribution Modeling_. R package version 4.2-4, <https://CRAN.R-project.org/package=biomod2>.

  Urbanek S (2021). _rJava: Low-Level R to Java Interface_. R package version 1.0-6, <https://CRAN.R-project.org/package=rJava>.

  Urbanek S, Johnson K (2022). _tiff: Read and Write TIFF Images_. R package version 0.1-11, <https://CRAN.R-project.org/package=tiff>.

Warren DL, Matzke NJ, Cardillo M, Baumgartner JB, Beaumont LJ, Turelli M, Glor RE, Huron NA, Simões M, Iglesias TL Piquet JC, Dinnage R (2021). ENMTools 1.0: an R package for comparative ecological biogeography. Ecography, 44(4), pp.504-511.

Zizka A, Silvestro D, Andermann T, Azevedo J, Duarte Ritter C, Edler D, Farooq H, Herdean A, Ariza M, Scharn R, Svanteson S, Wengstrom N, Zizka V, Antonelli A (2019). “CoordinateCleaner: standardized cleaning of occurrence records from biological collection databases.” Methods in Ecology and Evolution, -7. doi:10.1111/2041-210X.13152, R package version 3.0.1, https://github.com/ropensci/CoordinateCleaner.

# Problems installing packages

<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 2 04 04 p m" src="https://github.com/user-attachments/assets/f6ec6b8c-7f07-48c1-8970-b20614283a02">

<img width="1052" alt="Captura de pantalla 2024-09-22 a la(s) 2 04 08 p m" src="https://github.com/user-attachments/assets/e109813b-8e60-4f34-b134-01cb406419eb">

# Problems reported by users and possible solutions


![Eco0](https://github.com/user-attachments/assets/72b54bc2-69aa-487c-844b-969b720d44e6)

![Captura de pantalla 2025-05-17 a la(s) 6 43 43 a m](https://github.com/user-attachments/assets/2eea6f4d-7212-422c-b337-34f91d69479f)


![Eco2](https://github.com/user-attachments/assets/85654fcf-17f6-47b2-9472-e998f8c20d41)


![Eco1](https://github.com/user-attachments/assets/2996a24d-261e-45c7-8c31-2d85ff0be4d5)


![Captura de pantalla 2025-05-15 a la(s) 1 35 30 p m](https://github.com/user-attachments/assets/04e91d2f-6f35-459e-b994-9d6d529283c3)

![Captura de pantalla 2025-05-17 a la(s) 6 59 27 a m](https://github.com/user-attachments/assets/0c6614ca-08c1-4dd1-8eba-c253f6f6dbd9)


![Captura de pantalla 2025-05-15 a la(s) 5 03 07 p m](https://github.com/user-attachments/assets/d4ceb452-dec7-4a40-bb5c-9b10413f6516)

![Captura de pantalla 2025-05-17 a la(s) 6 27 14 a m](https://github.com/user-attachments/assets/30c6d3d8-1624-4908-8d9f-5485fa62c790)

![Captura de pantalla 2025-05-20 a la(s) 1 15 01 p m](https://github.com/user-attachments/assets/fcb82f79-28cf-4078-b44a-021c1ba1b3ad)

-----
Centro de Investigación en Ciencias Biológicas Aplicadas, Facultad de Ciencias, Universidad Autónoma del Estado de México, Toluca, Estado de México, Mexico

Centro de Innovación Digital “Mandra” Laboratorio Nacional de Enseñanza e Innovación
aplicando Cómputo de Alto Rendimiento (EICAR), CONAHCyT, Universidad Autónoma del Estado de México, Toluca, Estado de México, Mexico

Departamento de Conservación de la Biodiversidad, El Colegio de la Frontera Sur, San Cristóbal de Las Casas, Chiapas, Mexico

Laboratorio Nacional Conahcyt de Biología del Cambio Climático, CONAHCyT, Mexico City,
Mexico

Departamento de Zoología, Instituto de Biología, Universidad Nacional Autónoma de México,
Mexico City, Mexico

<div align="center">
  <img src="https://github.com/user-attachments/assets/8728e8a0-cceb-4b1e-b6bc-3c3933116460" alt="Captura de pantalla 2025-04-19 a la(s) 6:18:39 p. m." width="300"/>
</div>










