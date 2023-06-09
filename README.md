# EcoNicheS
                           ![eco2](https://github.com/armandosunny/EcoNicheS/assets/25662791/ac0a9b00-a873-469d-ac33-4b49cba48a90)

 An R package for Shiny that enables the analysis of ecological niche modeling using the biomod2 package and other analyzes. This is the EcoNicheS version 1.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. Thank you very much for using this package.

### To install the library:

if (!require('devtools')) install.packages('devtools')

devtools::install_github('armandosunny/EcoNicheS')

###### EcoNicheS works with biomod2 version 4.2.2 specifically, as it was found that later versions are incompatible. Therefore, to ensure smooth functionality, please follow these instructions to download and install the correct version of biomod2 in Rstudio:

###### If you already have a different version of biomod2 installed, you can remove it with the following function: remove.packages("biomod2") and later install the correct version of biomod2 4.2.2.

##### For your convenience, the biomod2 4.2.2 version has been included in the repository.
 
To install biomod2 4.2.2 download the package form this repository. 

Open Rstudio.

Navigate to "Tools" in the top menu.

Select "Install Packages."

In the "Install from" dropdown menu, choose "Package Archive File (.zip; .tar.gz)."

Locate the compressed biomod2 4.2.2 file that you have downloaded.


Click on the file to select it.

Confirm the installation by proceeding with the installation process.

###### To ensure smooth workflow in RStudio, it is crucial to define the working directory properly. Follow these steps: navigate to "Session" -> "Set Working Directory" -> "Choose Directory". Select the folder that contains the .asc layers and the .csv coordinate base file. 

###### The base file should have the Species listed in the first column, followed by longitude (X) in the second column, and latitude (Y) in the third column. 


![DatabaseExample](https://github.com/armandosunny/EcoNicheS/assets/25662791/4345d761-ec1e-4c8c-89a5-5e5c8b89191e)


###### Additionally, ensure that the working directory includes all the necessary files for running MAXENT (MAXENT can be downloaded from here: https://biodiversityinformatics.amnh.org/open_source/maxent/)

![maxentExamples2](https://github.com/armandosunny/EcoNicheS/assets/25662791/12819901-36ae-429a-a8b6-eb44dffce579)

## To open the shiny GUI application:

shiny::runApp("EcoNicheS.R")

## Please cite as:

Sunny, A. (2023). EcoNicheS: An R package for Shiny that enables the analysis of ecological niche modeling using the biomod2 package and other analyzes. GitHub. https://github.com/armandosunny/EcoNicheS


## Acknowledgements

The creation of this package was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Autonomous University of the State of Mexico (Grant: 4732/2019CIB). 
