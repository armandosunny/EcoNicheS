# EcoNicheS-2.0.0 <img src="https://user-images.githubusercontent.com/25662791/244543343-ac0a9b00-a873-469d-ac33-4b49cba48a90.png" referrerpolicy="no-referrer" alt="eco2" align="right" height="276" />
An R library for Shiny that enables the analysis of ecological niche modeling using the biomod2 library and other analyzes. This is Version 2.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. 


-----


### Getting started: Requirements to use EcoNicheS 2.0.0

#### Load the correct versions of the required packages in R :)
EcoNicheS works with specific versions of the libraries it uses to perform ecological niche modeling analyses, as later versions have been found to be incompatible. Therefore, to ensure smooth functionality, please download and install the correct version of the following libraries in RStudio:

- shiny 1.7.5
- terra 1.7.46
- usdm 2.1.6
- ENMTools 1.1.1
- biomod2 4.2.4
- RColorBrewer 1.1.3
- dismo 1.3.14
- tiff 0.1.11
- rJava 1.0.6
- tidyterra 0.4.0
- shinydashboard 0.7.2
- pROC 1.18.4
- R.utils 2.12.2
- ENMGadgets 0.1.0.1

#### Load the correct versions of the required packages in R (:
EcoNicheS works with specific versions of the libraries it uses to perform ecological niche modeling analyses, as later versions have been found to be incompatible. Therefore, to ensure smooth functionality, please download and install the correct version of the following libraries in RStudio:

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
install_version("tifyterra", version = "0.4.0")
install_version("shinydashboard", version = "0.7.2")
install_version("pROC", version = "1.18.4")
install_version("R.utils", version = "2.12.2")
install_version("ENMGadgets", version = "0.1.0.1")
```

#### Define the working directory in RStudio and prepare your databases

To ensure smooth workflow in RStudio, it is crucial to define the working directory properly. Follow these steps: navigate to "Session" -> "Set Working Directory" -> "Choose Directory". Select the folder that contains the .asc layers and the .csv coordinate base file.
The base file should have the Species listed in the first column, followed by longitude (X) in the second column, and latitude (Y) in the third column.



## Correlation analysis between .asc layers 


![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/8d168349-7d40-420f-8e99-76c89b42dc2c)


![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/72c6511a-610a-497b-8b5a-f4c90ae3acdf)


![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/37999c91-49a7-4971-9281-1f500566888b)

## Points and pseudoabsences


## Biomod2 and more


## Remove urbanization


## Calculate area


## Gains and losses plot


## Partial ROC Analysis


### Citation


