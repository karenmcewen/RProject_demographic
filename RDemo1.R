#Demographic Data from the World Bank 2012
#You are employed as a Data Scientist by the World Bank 
#and you are working on a project to analyse the World’s 
#demographic trends.
#You are required to produce a scatterplot illustrating 
#Birth Rate and Internet Usage statistics by Country.
#The scatterplot needs to also be categorised by 
#Countries’ Income Groups. 

#-------------------------READ IN DATA-----------------
#Read in the file - Method I using read.csv()
# using file.choose() function brings up popup window
stats<-read.csv(file.choose())
stats

#Read in the file - Method II using working directory with filename
getwd()
setwd("C:/Users/Karen/Documents/R/Rprojects/RProject_demographic1")
#remove current stats dataframe
rm(stats)
stats<-read.csv(P2-Demographic-Data.csv) 
#couldn't find file...maybe because of dashes in filename

#--------------------EXPLORE DATA----------------
nrow(stats) #number of rows is 195
ncol(stats) #number of columns is 5
head(stats) #gives top 6 rows of the dataframe
tail(stats) #gives bottom 6 rows of the dataframe
str(stats) #structure of the dataframe - factor is one-hot encoded automatically!
summary(stats) #summary of statistics, min, max, median, percentiles

#notes from basic exploration - 
#195 distinct countries and country codes - no duplicates
#birth rate between 7.9 and 49.66 per thousand people
#internet users rate between 0.9% and 96.55%
#four income groups - low, lower middle, upper middle, high
