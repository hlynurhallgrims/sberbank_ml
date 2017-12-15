# Project: sberbank
# Author: Hlynur Hallgrimsson
# Maintainer: Who to complain to <yourfault@somewhere.net>

# This file loads all the libraries and data files needed 
# Don't do any cleanup here

### Load any needed libraries
#load(LibraryName)
library(tidyverse)
library(stringr)
library(caret)
library(imputeMissings)

### Load in any data files
innlesid <- read.csv("data/train.csv", header = TRUE)
profgogn <- read.csv("data/test.csv", header = TRUE)

makro <- read.csv("data/macro.csv", header = TRUE)

