# EcoNicheS-2.0.0 <img src="https://user-images.githubusercontent.com/25662791/244543343-ac0a9b00-a873-469d-ac33-4b49cba48a90.png" referrerpolicy="no-referrer" alt="eco2" align="right" height="276" />
An R library for Shiny that enables the analysis of ecological niche modeling using the biomod2 library and other analyzes. This is Version 2.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. 


-----


### Getting started: Requirements to use EcoNicheS 2.0.0

#### Load the correct versions of the required packages in R
EcoNicheS works with specific versions of the libraries to conduct ecological niche modeling analyses, as later versions have been found to be incompatible. Therefore, to ensure smooth functionality, please download and install the correct version of the following libraries in RStudio:

``` r
 packageVersion("shiny")
[1] ‘1.7.5’
 packageVersion("terra")
[1] ‘1.7.46’
 packageVersion("usdm")
[1] ‘2.1.6’
 packageVersion("ENMTools")
[1] ‘1.1.1’
 packageVersion("biomod2")
[1] ‘4.2.4’
 packageVersion("RColorBrewer")
[1] ‘1.1.3’
 packageVersion("dismo")
[1] ‘1.3.14’
 packageVersion("tiff")
[1] ‘0.1.11’
 packageVersion("rJava")
[1] ‘1.0.6’
 packageVersion("tidyterra")
[1] ‘0.4.0’
 packageVersion("shinydashboard")
[1] ‘0.7.2’
 packageVersion("pROC")
[1] ‘1.18.4’
 packageVersion("R.utils")
[1] ‘2.12.2’
 packageVersion("ENMGadgets")
[1] ‘0.1.0.1’

```


#### Prepare your databases
``` r
options(shiny.maxRequestSize = 6000*1024^2)
```
-----
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


