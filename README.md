# EcoNicheS
 An R library for Shiny that enables the analysis of ecological niche modeling using the biomod2 library and other analyzes. This is Version 1.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. Thank you very much for using this library.

### To install the library:

if (!require('devtools')) install.packages('devtools')

devtools::install_github('armandosunny/EcoNicheS')

###### EcoNicheS works with biomod2 version 4.2.2 specifically, as it was found that later versions are incompatible. Therefore, to ensure smooth functionality, please follow these instructions to download and install the correct version of biomod2 in Rstudio:

Open Rstudio.

Navigate to "Tools" in the top menu.

Select "Install Packages."

In the "Install from" dropdown menu, choose "Package Archive File (.zip; .tar.gz)."

Locate the compressed biomod2 4.2.2 file that you have downloaded.


Click on the file to select it.

Confirm the installation by proceeding with the installation process.

###### If you already have a different version of biomod2 installed, you can remove it with the following function: remove.packages("biomod2") and later install the correct version of biomod2 4.2.2.

#### For your convenience, the biomod2 4.2.2 version has been included in the repository.

## To open the shiny GUI application:

shiny::runApp("EcoNicheS.R")


## Please cite as:

Sunny, A. (2023). EcoNicheS: An R library for Shiny that enables the analysis of ecological niche modeling using the biomod2 library and other analyzes. GitHub. https://github.com/armandosunny/EcoNicheS


## Acknowledgements

The creation of this library was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Autonomous University of the State of Mexico (Grant: 4732/2019CIB). 
