These are the libraries necessary to perform analyzes in EcoNicheS with the required versions to ensure 
that all work is done properly. Be sure to read the messages in RStudio when using this code to make 
sure everything was installed correctly.


if (!require('remotes')) install.packages('remotes')
library(remotes)
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
