# EcoNicheS <img src="https://user-images.githubusercontent.com/25662791/244543343-ac0a9b00-a873-469d-ac33-4b49cba48a90.png" referrerpolicy="no-referrer" alt="eco2" align="right" height="276" />
An R library that enables Ecological Niche Modeling Analysis with Shinydashboard. This is Version 1.0.0, and subsequent versions will be uploaded with additional analyses and upgrades. 

-----

# First and foremost: prerequisites for utilizing EcoNiches

_The current version of EcoNiches_, due to the package loading it uses in R, _is available only for **Windows**_. Future versions will be published with updates and improvements to expand the use of the application to Mac users. 

### EcoNicheS requires the installation of 64-bit Java

To use EcoNicheS it is necessary to have 64-bit Java installed. For this you can visit the Oracle Java download page by clicking [here](https://www.oracle.com/java/technologies/downloads/). Downloading the .exe file is the easiest option.

![JavaWindowseditado](https://github.com/armandosunny/EcoNicheS/assets/25662791/6c6e1a4b-9824-482e-a818-230fbaac753b)

### Download and install RTools

In addition to having installed [R](https://cran.rstudio.com/) and [RStudio](https://posit.co/download/rstudio-desktop/), RTools is essential to be able to use some packages in R, so please download and install it on your device to avoid problems when running and using EcoNicheS. You can download it by accessing this [link](https://cran.r-project.org/bin/windows/Rtools/).

> [!TIP]
> https://rstudio-education.github.io/hopr/starting.html

### Define the working directory in RStudio and prepare your databases

To ensure smooth workflow in RStudio, it is crucial to define the working directory properly, the location where all databases created during the analyzes will be saved. Follow these steps, navigate to: "Session" ➥ "Set Working Directory" ➥ "Choose Directory", and select the folder that contains the databases necessary to carry out this type of analysis: the .asc layers of your study area and the .csv file containing the coordinates with the points of presence of your study species.

> [!NOTE]
> If what you are looking for is to learn how to perform ecological niche modeling analysis and you do not have these files, please go to the section [Learning how to use EcoNicheS with an example case study](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#learning-how-to-use-econiches-with-an-example-case-study) where you will find all the necessary files to use EcoNicheS. 

In order to use your databases, the _.csv base file_ must have the _name of the species listed in the first column_, followed by _longitude (X)_ in the second column, and _latitude (Y)_ in the third column as seen below. _Editing your database respecting lowercase and uppercase letters is essential for the analysis to proceed_.

<sub>.csv file is displayed in RStudio</sub> 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/727045e3-cbc0-47b0-95d8-72cdc158b3fe) 

<sub>.csv file is displayed in Excel</sub>
 
![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/addc0249-104d-4133-9d13-5168d039eb79)

### MAXENT model
One of the EcoNicheS tabs bases its analyzes on [Biomod2](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#biomod2), which in turn uses different models to perform the ecological niche modeling analysis. One of these models is [MAXENT](https://biodiversityinformatics.amnh.org/open_source/maxent/), which requires the prior download of 3 files so that the analysis with it can be carried out, so, if it is selected, prior to the analysis ensure that the working directory includes all the necessary files for running this model: [MAXENT](https://doi.org/10.6084/m9.figshare.24980664.v1).

[![maxent bat](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/1b534599-e6e8-442d-8ab1-a81c64ff82a0)](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709353/MAXENTbat.zip) [![maxent jar](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/9e030780-32a4-4fa2-8554-ace630cb1681)](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709414/MAXENTjar.zip) [![maxent sh](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/6fe03b4a-535c-4c1e-9e59-d854a422f2df)](https://github.com/armandosunny/EcoNicheS-2.0.0/files/13709416/MAXENTsh.zip)

If you are not familiar with Biomod2, in its corresponding section in this manual you will know how to use it with EcoNicheS but it is important that you have the mentioned files from the beginning to ensure that there will be no problems when you use this tab.

-----

# Learning how to use EcoNicheS with an example case study

To know and understand in detail the functions that EcoNicheS offers and the results that we can obtain from them, we invite you to learn about the application through a case study based on _Phrynosoma orbiculare_, also known as Mexican Plateau horned lizard. The documents and databases necessary to be able to use each of the EcoNicheS functions are available [here].


-----

# To install the library

EcoNicheS works with specific libraries in R that it uses to perform ecological niche modeling analyses, and although the loading of most of them is automatic when running the application, there are some exceptions so it is necessary that you please use the command shown below in RStudio to ensure smooth functionality. If in this section or when running the command to open the application there is a problem regarding the failure to install any of the libraries, please refer to the [**Problems installing packages**](https://github.com/armandosunny/EcoNicheS/blob/main/README.md#problems-installing-packages) part of the manual.

``` r
#Before loading the graphical interface, paste this line to give more capacity to rJava and then select the working directory

options(shiny.maxRequestSize = 6000*1024^2)

install.packages("https://cran.r-project.org/src/contrib/Archive/rgdal/rgdal_1.6-7.tar.gz", repos = NULL, type = "source")

install.packages("https://cran.r-project.org/src/contrib/Archive/rgeos/rgeos_0.6-4.tar.gz", repos = NULL, type = "source")

install.packages("https://cran.r-project.org/src/contrib/Archive/maptools/maptools_1.1-8.tar.gz", repos = NULL, type = "source")

if (!require('devtools')) install.packages('devtools')

library(devtools)

install_github("narayanibarve/ENMGadgets")

require(ENMGadgets)

install_github("danlwarren/ENMTools")

library(ENMTools)

install_github('armandosunny/EcoNicheS')

library(EcoNicheS)


```
# To open the shiny GUI application:

After ensuring that the above commands worked successfully, use this command to start exploring the EcoNicheS interface and features.

```
options(shiny.maxRequestSize = 6000*1024^2)

shinyApp(ui = ui, server = server)
```

-----

# Exploring EcoNicheS features

EcoNicheS is an interactive web application that consists of 7 work tabs: **_Correlation layers, Points and pseudoabsences, Biomod2, Partial ROC Analysis, Remove urbanization, Calculate area_** and **_Gains and losses_**. These tabs, when used sequentially or with the corresponding databases depending on the analysis, allow developing ecological niche modeling analyses.

![Imagen 7 tabs](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/07ac590c-b74a-4d92-8e4f-f30d71f9c6af)

## Obtaining and cleaning species occurrences
The first step to perform niche modeling analysis is to obtain the recorded occurrences of the species of interest. Using EcoNicheS this is achieved by downloading documents with this information from the Global Biodiversity Information Facility (GBIF, [gbif.org](https://www.gbif.org/)), one of the large biodiversity databases. Obtaining this information is achieved using the Coordinate cleaner package as a means for this.

One of the metadata that CoordinateCleaner uses to clean the data is coordinateUncertaintyInMeters, which describes the smallest circle containing the whole of the Location and serves as a reference for the accuracy of the coordinate location, in addition, it allows estimating the potential distance of the real occurrence location from the recorded values. No se como citar esta pagina https://www.gbif.org/data-quality-requirements-occurrences#dcUncertainty

Coordinate cleaner is based on automated data cleaning tests and algorithms to identify and remove records that may be flagged as erroneous or imprecise based on their identification as maritime, zero, atypical coordinates; coordinates assigned to centroids of countries and provinces, located within urban areas or assigned to biodiversity institutions, as well as disagreements between coordinates and countries. And it is also possible to filter the clean data according to the year and location of interest (Zizka et al., 2019). 

## Correlation analysis between .asc layers 

The first of the work tabs requires the raster files or .asc layers that contain the data about the geography of the area, place or location of interest<sup>1</sup>. Since these layers are our study variables, by obtaining a heatmap, this tab allows us to determine if there is autocorrelation between them, thus, it is possible to select multiple .asc files, as well as choose the Threshold (th) value for the analysis.  You can download the example documents to practice using the application [here](). 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/57ef3e0b-88eb-4f16-b15d-b462de43c666)

Once we press the "Calculate correlation" action button, in the white panel, we will obtain the generated heatmap image as a result.
This is an example of the expected results to be obtained. Results can be downloaded in PDF format. For this tab and for the following ones too, it is important to consider that  all the buttons must be pressed only once, since a single click guarantees that the documents are being loaded, the analyzes are being carried out or that the download is taking place.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/8d168349-7d40-420f-8e99-76c89b42dc2c)

## Points and pseudoabsences

Here, by uploading our previously edited .csv file and any of our .asc layers, as a result, in RStudio we will obtain a map that can be viewed in the files and graphics window, specifically in the Plot tab. 

In the example shown below, 1000000 was used as the number of random points, however the default value is 100, but it can be modified, so the appropriate number of points for our study can be indicated in the third box of the tab.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a37ba849-6c5e-422e-b26e-d1562e09e4ae) 

This is an example of the plot shown in RStudio using the database of our example species. If you wish, remember that it is also possible to save the image in PNG format by right-clicking on it, but it is a file that is also generated and saveed automatically when we perform the analyzes of the following tab.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/d2bb018a-1461-4a5a-9a62-4618b5c7cb26)


Despite the above, the main result here appears as a legend in the main panel of our EcoNicheS tab, as can be seen in the image below. This implies that a new database was obtained, which is stored in the working directory indicated at the beginning. Before running the analysis, the name of the generated database can and must be modified from default name by always maintaining the .csv extension, in this way we ensure that its creation and saving are being carried out correctly.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/a4415556-a480-4837-9790-63f939e823ad)

Thus, the database with the coordinates of our species now consists of 5 columns, the new pair is a first column, where the amount of data is listed numerically, and a last column where the points of presence of our species were assigned the number 1, while pseudo-absences were assigned a 0.

<sub>Visualization in RStudio</sub> 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/afdad7e2-46fe-4b9e-982c-938401a86f08)

<sub>Visualization in Excel</sub> 

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/cb2f6514-d18b-481f-bb89-5cd3ffc00dfe)




## Biomod2


For this analysis, the file to be loaded is the database generated in the previous tab, and the necessary .asc layers are those that did not show autocorrelation indicated by the heatmap obtained in the first tab of EcoNiches.
Multiple models can be selected to perform this analysis depending on your needs. The first step is to upload the .csv document with the presence points and pseudo-absences. It is important to note that seconds after loading the file, the first sub-tab called Database will show us the content of the file; if not, it may mean that there is an error in our file or that the good workflow was interrupted.

![Biomod 0 7](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/2b60d6fa-5802-43a8-a4a6-62ee7bb0fe4c)


Next, the display of the button to load the appropriate .asc layers after clicking on the "Load .asc layers" button is the second sign that our .csv database was loaded correctly, otherwise we will not observe the appearance of this option window.

![select  asc files biomod2](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/6186fb94-64b3-4a92-a9ee-c744344418a9)


Biomod2 is a library that allows the analysis of species distribution through 10 models: GLM, GBM, GAM, CTA, ANN, SRE, FDA, RF, MAXENT and MAXNET, that is, it is an ensemble analysis method, so, multiple models can be selected for analysis execution<sup>2</sup>. For the example shown in this manual through images and databases, all available models were selected. 

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

## Partial ROC Analysis

As mentioned above, one of the files needed to perform this analysis is part of the results above, but if you already have a Prediction Raster file, you can also upload it in .asc format. As mentioned above, one of the files needed to perform this analysis is part of the results above, but if you already have a Prediction Raster file, you can also upload it in .asc format.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/ffde883a-ae1e-4f15-a010-b7458eefd39d)

Remember to press the action buttons only once, in addition, as with the Biomod2 tab, in RStudio you can view the progress of the analysis according to the number of simulations that you indicate.

![progress rstudio](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/96d82c16-1c6b-4e42-815a-ebad3317f49e)

As a result, in the main panel of the tab you will be able to display an inscription, which describes the average values for the area under the curve obtained according to the number of simulations. A table with all the values is also displayed according to the number of simulations indicated, in our example that is why 501 entries are shown.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/2959f0c8-bce7-4a51-8dcc-474107b690bb)



## Remove urbanization

For this part of the application you must have two raster files, the first must contain only the geographical data of urbanization within the potential distribution area of the study species, the second file must contain such a distribution map, thus, after running the analysis you will obtain an .asc file where said urbanization data was removed from the potential distribution area.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/37fe587e-37bf-4728-86ae-76c8c0eafda2)

## Calculate area
This tab allows you to obtain the area of suitability of the species of interest by uploading the .asc file created in the previous tab or an existing file if applicable. The Suitability Threshold value can be modified according to the appropriate value for your study and the only result consists of the legend obtained in the main panel of the tab as you can see below.

![image](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/945f4ce5-0d8e-4c52-9bf5-debd19f834f0)


## Gains and losses plot

This tab requires two files, the only acceptable format of which is .asc. The first of these raster files must correspond to a file with the characteristics or geographical data of the area of interest. The second file corresponds to a future prediction of the conditions of the landscape.

![gains and losses 16 y 50 cn resultados](https://github.com/armandosunny/EcoNicheS-2.0.0/assets/25662791/4c68a466-d6be-47c6-adb1-b9bd4df70638)

-----

# Problems installing packages

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




# Citation

#### Please cite as:

Marmolejo C, López-Vidal R, Díaz-Sánchez LE, Sunny A (2024). EcoNicheS: Empowering Ecological Niche Modeling Analysis with Shinydashboard and R Package. GitHub. https://github.com/armandosunny/EcoNicheS


# Acknowledgements

The creation of this package was made possible by the financial support provided by the Secretary of Research and Advanced Studies (SYEA) of the Universidad Autónoma del Estado de México (Grants to AS: 4732/2019CIB and 6801/2022CID), SEP (Grant to AS: PRODEP 511/2022-5401) and CONACYT (Grant to AS: FOINS 6828/2017). A.S: Adahy Olun Contreras-García yo nunca te abandoné, estoy haciendo todo para que la justicia mexicana me permita volver a estar contigo, pero es un proceso muy lento, te extraño mucho.

# References

  <sup>1</sup> _ACS hosted Feature Layers FAQ_. (n.d.-a). ACS Hosted Feature Layers FAQ.
  https://acs-hosted-feature-layers-faq-esri.hub.arcgis.com/ 

  <sup>2</sup> Huang D, An Q, Huang S, Tan G, Quan H, Chen Y, Zhou J, Liao H. (2023). 
  Biomod2 modeling for predicting the potential ecological distribution of three Fritillaria species under climate change. 
  _Scientific reports_, 13(1), 18801. https://doi.org/10.1038/s41598-023-45887-6

  Barve N, Barve V (2019). _ENMGadgets: Pre and Post Processing in ENM Workflow_. R
  package version 0.1.0.1.

  Bengtsson H (2022). _R.utils: Various Programming Utilities_. R package version
  2.12.2, <https://CRAN.R-project.org/package=R.utils>.

  Chang W, Borges Ribeiro B (2021). _shinydashboard: Create Dashboards with 'Shiny'_. R
  package version 0.7.2, <https://CRAN.R-project.org/package=shinydashboard>.
  
  Chang W, Cheng J, Allaire J, Sievert C, Schloerke B, Xie Y, Allen J, McPherson J,
  Dipert A, Borges B (2023). _shiny: Web Application Framework for R_. R package version
  1.7.5, <https://CRAN.R-project.org/package=shiny>.

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
