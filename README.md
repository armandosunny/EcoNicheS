# EcoNicheS-2.0.0 <img src="https://user-images.githubusercontent.com/25662791/244543343-ac0a9b00-a873-469d-ac33-4b49cba48a90.png" referrerpolicy="no-referrer" alt="eco2" align="right" height="276" />
An R library for Shiny that enables the analysis of ecological niche modeling using the biomod2 library and other analyzes. This is Version 2.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. 

-----
# Getting ready to use the app
EcoNicheS-2.0.0 is an interactive web application that consists of 7 work tabs: **_Correlation layers, Points and pseudoabsences, Biomod2, Partial ROC Analysis, Remove urbanization, Calculate area_** and **_Gains and losses_**. These tabs, when used sequentially or with the corresponding databases depending on the analysis, allow developing ecological niche modeling analyses, but before starting to interact with the app there are some prerequisites necessary to ensure smooth functionality, these prerequisites imply the _use of RStudio and the installation of packages in it, and the conditioning of the databases_ with which you wish to carry out this type of analysis.

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

To ensure smooth workflow in RStudio, it is crucial to define the working directory properly, location where all databases created during the analyzes will be saved. Follow these steps, navigate to: "Session" ➥ "Set Working Directory" ➥ "Choose Directory", and select for example, the folder that contains the databases necessary to carry out this type of analysis: the .asc layers of your study area and the .csv coordinate base file containing the coordinates with the points of presence of your study species.

In order to use your databases, the _.csv base file_ must have the _Species listed in the first column_, followed by _longitude (X)_ in the second column, and _latitude (Y)_ in the third column as seen below. _Editing your database respecting lowercase and uppercase letters is essential for the analysis to proceed_.

<sub>Visualization in RStudio</sub> 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/727045e3-cbc0-47b0-95d8-72cdc158b3fe) 

<sub>Visualization in Excel</sub>
 
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/addc0249-104d-4133-9d13-5168d039eb79)

----

# Exploring EcoNicheS features
## Correlation analysis between .asc layers 

The first of the work tabs requires the raster files or .asc layers that contain the data about the geography of the area, place or location of interest (pongo cita?https://acs-hosted-feature-layers-faq-esri.hub.arcgis.com/). Since these layers are our study variables, by obtaining a heatmap, this tab allows us to determine if there is autocorrelation between them, thus, it is possible to select multiple .asc files, as well as choose the Threshold (th) value for the analysis.  You can download the example documents to practice using the application [here](). 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/57ef3e0b-88eb-4f16-b15d-b462de43c666)

Once we press the "Calculate correlation" action button, in the white panel, we will obtain the generated heatmap image as a result.
This is an example of the expected results to be obtained. Results can be downloaded in PDF format. For this tab and for the following ones too, it is important to consider that  all the buttons must be pressed only once, since a single click guarantees that the documents are being loaded, the analyzes are being carried out or that the download is taking place.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/8d168349-7d40-420f-8e99-76c89b42dc2c)

## [Points and pseudoabsences](http://cran.nexr.com/web/packages/ENMeval/vignettes/ENMeval-vignette.html)

Here, by uploading our previously edited .csv file and any of our .asc layers, as a result, in RStudio we will obtain a map that can be viewed in the files and graphics window, specifically in the Plot tab. 

In the example shown below, 1000000 was used as the number of random points, however the default value is 100, but it can be modified, so the appropriate number of points for our study can be indicated in the third box of the tab.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a37ba849-6c5e-422e-b26e-d1562e09e4ae) 

This is an example of the plot shown in RStudio using the database of our example species. If you wish, remember that it is also possible to save the image in PNG format by right-clicking on it.
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/d2bb018a-1461-4a5a-9a62-4618b5c7cb26)


Despite the above, the main result appears as a legend in the main panel of our EcoNicheS tab, as can be seen in the image below. This implies that a new database was obtained, which is stored in the working directory indicated at the beginning. Before running the analysis, the name of the generated database can and must be modified from default name by always maintaining the .csv extension, in this way we ensure that its creation and saving are being carried out correctly.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a4415556-a480-4837-9790-63f939e823ad)

Thus, the database with the coordinates of our species now consists of 5 columns, the new pair is a first column, where the amount of data is listed numerically, and a last column where the points of presence of our species were assigned the number 1, while pseudo-absences were assigned a 0.

<sub>Visualization in RStudio</sub> 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/afdad7e2-46fe-4b9e-982c-938401a86f08)

<sub>Visualization in Excel</sub> 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/cb2f6514-d18b-481f-bb89-5cd3ffc00dfe)




## [Biomod2](http://cran.nexr.com/web/packages/ENMeval/vignettes/ENMeval-vignette.html)


For this analysis, the file to be loaded is the database generated in the previous tab, and the necessary .asc layers are those that did not show autocorrelation indicated by the heatmap obtained in the first tab of EcoNiches-2.0.0.
Multiple models can be selected to perform the analysis depending on our needs. If the MAXENT model is selected, prior to the analysis ensure that the working directory includes all the necessary files for running this model ([MAXENT.zip](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709332/MAXENT.zip) can be downloaded from here: https://biodiversityinformatics.amnh.org/open_source/maxent/).

[![maxent bat](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/1b534599-e6e8-442d-8ab1-a81c64ff82a0)](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709353/MAXENTbat.zip) [![maxent jar](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/9e030780-32a4-4fa2-8554-ace630cb1681)](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709414/MAXENTjar.zip) [![maxent sh](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/6fe03b4a-535c-4c1e-9e59-d854a422f2df)](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709416/MAXENTsh.zip)

Así se ve al cargar el .csv
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/464a558b-ac63-4b81-a3a0-3515d9626379)

Así se ve al cargar las capas .asc
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/32b7bc3e-08c8-4565-ac45-7533c1def0d5)

Desplegable de modelos
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/96a4dd3d-02bf-4fd9-bb2e-dbbdff5ca604)

Todo cargado:
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a1a050f3-a882-454f-af78-e49b79c2598f)

Como va cargando con maxent
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/672be5b8-dd70-42be-938e-83586211bfd8)

Como va cargando en R si no hay maxent:
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/d061477f-ed9e-4328-b100-5f9c04d41053)

## Partial ROC Analysis


## Remove urbanization

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/37fe587e-37bf-4728-86ae-76c8c0eafda2)

## Calculate area

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/109b585a-fac3-4160-99aa-f7bd7091b409)

## Gains and losses plot




# To open the shiny GUI application:



# Citation

#### Please cite as:

Sunny, A. (2023). EcoNicheS: An R package for Shiny that enables the analysis of ecological niche modeling using the biomod2 package and other analyzes. GitHub. https://github.com/armandosunny/EcoNicheS


# Acknowledgements

The creation of this package was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Autonomous University of the State of Mexico (Grant: 4732/2019CIB). 

# References

  R Core Team (2023). _R: A Language and Environment for Statistical Computing_. R
  Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

  Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J, McPherson J,
  Dipert A, Borges B (2023). _shiny: Web Application Framework for R_. R package version
  1.7.5, <https://CRAN.R-project.org/package=shiny>.

  Hijmans R (2023). _terra: Spatial Data Analysis_. R package version 1.7-46,
  <https://CRAN.R-project.org/package=terra>.

  Naimi B, Hamm Na, Groen TA, Skidmore AK, Toxopeus AG (2014). “Where is positional
  uncertainty a problem for species distribution modelling.” _Ecography_, *37*, 191-203.
  doi:10.1111/j.1600-0587.2013.00205.x
  <https://doi.org/10.1111/j.1600-0587.2013.00205.x>.

  Warren D, Dinnage R (2023). _ENMTools: Analysis of Niche Evolution using Niche and
  Distribution Models_. R package version 1.1.1.

  Thuiller W, Georges D, Gueguen M, Engler R, Breiner F, Lafourcade B, Patin R (2023).
  _biomod2: Ensemble Platform for Species Distribution Modeling_. R package version
  4.2-4, <https://CRAN.R-project.org/package=biomod2>.

  Neuwirth E (2022). _RColorBrewer: ColorBrewer Palettes_. R package version 1.1-3,
  <https://CRAN.R-project.org/package=RColorBrewer>.

  Hijmans RJ, Phillips S, Leathwick J, Elith J (2023). _dismo: Species Distribution
  Modeling_. R package version 1.3-14, <https://CRAN.R-project.org/package=dismo>.

  Urbanek S, Johnson K (2022). _tiff: Read and Write TIFF Images_. R package version
  0.1-11, <https://CRAN.R-project.org/package=tiff>.

  Urbanek S (2021). _rJava: Low-Level R to Java Interface_. R package version 1.0-6,
  <https://CRAN.R-project.org/package=rJava>.

  Hernangomez D (2023). tidyterra: tidyverse Methods and ggplot2 Helpers for terra
  Objects. <https://doi.org/10.5281/zenodo.6572471>,
  <https://dieghernan.github.io/tidyterra/>

  Chang W, Borges Ribeiro B (2021). _shinydashboard: Create Dashboards with 'Shiny'_. R
  package version 0.7.2, <https://CRAN.R-project.org/package=shinydashboard>.

  Xavier Robin, Natacha Turck, Alexandre Hainard, Natalia Tiberti, Frédérique Lisacek,
  Jean-Charles Sanchez and Markus Müller (2011). pROC: an open-source package for R and
  S+ to analyze and compare ROC curves. BMC Bioinformatics, 12, p. 77.  DOI:
  10.1186/1471-2105-12-77 <http://www.biomedcentral.com/1471-2105/12/77/>

  Bengtsson H (2022). _R.utils: Various Programming Utilities_. R package version
  2.12.2, <https://CRAN.R-project.org/package=R.utils>.

  Barve N, Barve V (2019). _ENMGadgets: Pre and Post Processing in ENM Workflow_. R
  package version 0.1.0.1.


