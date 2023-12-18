# EcoNicheS-2.0.0 <img src="https://user-images.githubusercontent.com/25662791/244543343-ac0a9b00-a873-469d-ac33-4b49cba48a90.png" referrerpolicy="no-referrer" alt="eco2" align="right" height="276" />
An R library for Shiny that enables the analysis of ecological niche modeling using the biomod2 library and other analyzes. This is Version 2.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. 

-----
# Getting ready to use the app
EcoNicheS-2.0.0, as it's shown in the following, consists of 7 work tabs: **_Correlation layers, Points and pseudoabsences, Biomod2, Partial ROC Analysis, Remove urbanization, Calculate area_** and **_Gains and losses_**. These tabs, when used sequentially or with the corresponding databases depending on the analysis, allow developing ecological niche modeling analyses, but before starting to interact with the app there are some prerequisites necessary to ensure smooth functionality, these prerequisites imply the _installation of packages in RStudio and the conditioning of the databases_ with which you wish to carry out this type of analysis.

![Imagen 7 tabs](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/07ac590c-b74a-4d92-8e4f-f30d71f9c6af)

## Getting started: _Requirements to use EcoNicheS-2.0.0_

### Load the correct versions of the required packages in R :)
EcoNicheS works with specific versions of the libraries it uses to perform ecological niche modeling analyses, as later versions have been found to be incompatible. Therefore, to ensure smooth functionality, please download and install the correct version of the following libraries in RStudio. You can visit the websites listed below to obtain the packages ¿and? try using the listed commands as well to obtain the necessary versions.

- [shiny](https://www.r-project.org/nosvn/pandoc/shiny.html) 1.7.5
- [terra](https://github.com/rspatial/terra) 1.7.46
- [usdm](https://rdrr.io/rforge/usdm/)2.1.6
- [ENMTools](https://github.com/danlwarren/ENMTools) 1.1.1
- [biomod2](http://cran.nexr.com/web/packages/ENMeval/vignettes/ENMeval-vignette.html) 4.2.4
- [RColorBrewer](https://rdrr.io/cran/RColorBrewer/) 1.1.3
- [dismo](https://github.com/rspatial/dismo) 1.3.14
- [tiff](https://cran.r-project.org/web/packages/tiff/index.html) 0.1.11
- rJava 1.0.6
- tidyterra 0.4.0
- shinydashboard 0.7.2
- pROC 1.18.4
- R.utils 2.12.2
- ENMGadgets 0.1.0.1



``` r
install_version("shiny", version = "1.7.5")
install_version("terra", version = "1.7.46")
install_version("usdm", version = "2.1.6")
install_version("ENMTools", version = "1.1.1")	
install_version("biomod2", version = "4.2.4")
install_version("RColorBrewer", version = "1.1.3")
install_version("dismo", version = "1.3.14")
install_version("tiff", version = "0.1.11")
install_version("rJava", version = "1.0.6")
install_version("tidyterra", version = "0.4.0")
install_version("shinydashboard", version = "0.7.2")
install_version("pROC", version = "1.18.4")
install_version("R.utils", version = "2.12.2")
install_version("ENMGadgets", version = "0.1.0.1")
```

#### Define the working directory in RStudio and prepare your databases

To ensure smooth workflow in RStudio, it is crucial to define the working directory properly. Follow these steps, navigate to: "Session" ➥ "Set Working Directory" ➥ "Choose Directory", and select the folder that contains the .asc layers and the .csv coordinate base file.

The base file should have the Species listed in the first column, followed by longitude (X) in the second column, and latitude (Y) in the third column as seen below:

In RStudio

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/727045e3-cbc0-47b0-95d8-72cdc158b3fe)

In Excel

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/addc0249-104d-4133-9d13-5168d039eb79)

----

# Exploring EcoNicheS features
## Correlation analysis between .asc layers 

The first of the work tabs requires raster files or .asc layers and by obtaining a heatmap it allows us to determine if there is autocorrelation between said files.
This section allows us to select multiple .asc files, as well as choose the Threshold (th) value for the analysis. Once we press the "Calculate correlation" action button, in the white panel, we will obtain the generated heatmap image as a result.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/3428e3eb-364f-4ae4-8b01-5e19f23f7abd)

This is an example of the expected results to be obtained. You can download the example documents to practice using the application here. Results can be downloaded in PDF format. For this tab and for the following ones too, it is important to consider that  all the buttons must be pressed only once, since a single click guarantees that the documents are being loaded, the analyzes are being carried out or that the download is taking place.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/8d168349-7d40-420f-8e99-76c89b42dc2c)

## [Points and pseudoabsences](http://cran.nexr.com/web/packages/ENMeval/vignettes/ENMeval-vignette.html)

This tab is where in the first input button we will load our previously modified database so that the columns that contain the coordinates of points of presence of our species are titled "Species", "X" and "Y".
In the second button, any of our .asc layers can be loaded and in the third button we will indicate the number of random points appropriate for our study.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a37ba849-6c5e-422e-b26e-d1562e09e4ae)

In the example that below shows the results obtained, 1000000 was used as the number of random points, however the default value is 100. The result obtained is a map that can be viewed in RStudio in addition to the generated database, whose name can be modified by always maintaining the .csv extension, this generated document will be saved in the directory indicated in RStudio at the beginning.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a2919135-d8c8-4187-b617-b08ad3937077)


![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/cb2f6514-d18b-481f-bb89-5cd3ffc00dfe)


![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/afdad7e2-46fe-4b9e-982c-938401a86f08)



## [Biomod2](http://cran.nexr.com/web/packages/ENMeval/vignettes/ENMeval-vignette.html)


For this analysis, the file to be loaded is the database generated in the previous tab, and the necessary .asc layers are those that did not show autocorrelation indicated by the heatmap obtained in the first tab of EcoNiches-2.0.0.
Multiple models can be selected to perform the analysis depending on our needs. If the MAXENT model is selected, prior to the analysis ensure that the working directory includes all the necessary files for running this model (MAXENT can be downloaded from here: https://biodiversityinformatics.amnh.org/open_source/maxent/).

![maxentExamples2](https://github.com/armandosunny/EcoNicheS/assets/25662791/12819901-36ae-429a-a8b6-eb44dffce579)




## Remove urbanization

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/37fe587e-37bf-4728-86ae-76c8c0eafda2)

## Calculate area

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/109b585a-fac3-4160-99aa-f7bd7091b409)

## Gains and losses plot


## Partial ROC Analysis


# To open the shiny GUI application:



# Citation

#### Please cite as:

Sunny, A. (2023). EcoNicheS: An R package for Shiny that enables the analysis of ecological niche modeling using the biomod2 package and other analyzes. GitHub. https://github.com/armandosunny/EcoNicheS


# Acknowledgements

The creation of this package was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Autonomous University of the State of Mexico (Grant: 4732/2019CIB). 


