# Project: sberbank
# Author: Hlynur Hallgrimsson
# Maintainer: <hlynurh@gmail.com>

# This is the main file for the project
# It should do very little except call the other files

### Set the working directory
setwd(here::here())


####################


### Run the code
source("code/load.R")
source("code/clean.R")
source("code/do.R")
source("code/predict.R")
