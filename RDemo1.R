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
#four income groups (levels when numerated) - low, lower middle, upper middle, high

#------------------------ Using the $ sign ----------------------------------------
#dollar sign df$colname ==> df[,colname]
stats$Internet.users #gives entire column
stats$Internet.users[3] #gives third row of column 

#levels() tells you what levels are for a given column
levels(stats$Income.Group)

#----------------------- Basic Operations with a DataFrame -------------------------
stats[1:10,] #subset first ten rows
stats[c(2,100),] #subset 2nd and 100th row

#in a matrix looking at one row creates a vector (remember need to use drop=F to remain a matrix)
#in a dataframe, looking at one row is still a dataframe
is.data.frame(stats[1,]) #TRUE
#HOWEVER if look only at one column, it becomes a vector
is.data.frame(stats[,1]) #FALSE
#must use drop=F to keep single column as a dataframe
is.data.frame(stats[,1,drop=F]) #TRUE

#multiply columns (done as vectors) and create a new column
head(stats)
stats$myCalc <- stats$Birth.rate * stats$Internet.users
head(stats)

#add a new column with fewer elements and the vector gets recycled - must be multiple
stats$xyz <- 1:5
head(stats, n=12)

#remove a column by assigning it to NULL
stats$myCalc<-NULL
stats$xyz<-NULL
head(stats)

#-------------------- FILTERING a DATAFRAME ---------------------------
stats$Internet.users <2         #creates a vector of TRUE or FALSE
filter<-stats$Internet.users <2 #creates a filter of only TRUE values
stats[filter,]                  #shows only rows that are TRUE

stats[stats$Birth.rate>40,]      #can put the filter directly in the []
stats[stats$Birth.rate>40 & stats$Internet.users<2,] # use a single & for AND

levels(stats$Income.Group)       #tells you the names of the levels
stats[stats$Income.Group=="High income",]  #use double == for equals

stats[stats$Country.Name=="Malta",]

#-------------------- VISUALIZATION with QPLOT ---------------------------
#install.packages("ggplot2")  #if not already installed
library(ggplot2)
?qplot
qplot(data=stats,x=Internet.users,) #creates a histogram automatically!
qplot(data=stats,x=Income.Group, y=Birth.rate) #automatically picks the right type of plot
qplot(data=stats,x=Income.Group, y=Birth.rate, size=I(3))
qplot(data=stats,x=Income.Group, y=Birth.rate, 
      size=I(3),color=I("blue"))
qplot(data=stats,x=Income.Group, y=Birth.rate, 
      geom="boxplot") #creates a boxplot!

#---------------------- Example Visualization -------------
qplot(data=stats,x=Internet.users,y=Birth.rate)
qplot(data=stats,x=Internet.users,y=Birth.rate,
      color=Income.Group, size=I(5))
#analysis - 
#low income tend to have highest birthrates and lowest internet availability
#high income has lowest birthrates and highest internet usage
#looks like a negative linear-ish regression bet. birth rate and internet usage

#---------------------- BUILDING DATAFRAMES --------------------
mydf<-data.frame(Countries_2012_Dataset,
                 Codes_2012_Dataset,
                 Regions_2012_Dataset)
head(mydf)
#change the headings
colnames(mydf)<-c("Country", "Code", "Region")
head(mydf)

#can also do it in one line
rm(mydf)
mydf<-data.frame(Country=Countries_2012_Dataset,
                 Code=Codes_2012_Dataset,
                 Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf) #195 countries - correct!

#------------------------- MERGING DATAFRAMES -----------------------
head(stats)
head(mydf)
mergedDF<-merge(stats,mydf,by.x="Country.Code", by.y="Code")
head(mergedDF)

mergedDF$Country<-NULL #remove extra country column
head(mergedDF)
str(mergedDF) #structure

#------------------------- VISUALIZING with QPLOT ----------
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,
      color=Region, size=I(5))

#shapes - numbers 15-20 are filled shapes
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,
      color=Region, size=I(5), shape=I(17))

#transparency - alpha - to show overlapping points 
#0(fully transparent) to 1(fully opaque)
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,
      color=Region, size=I(5), shape=I(17), alpha=I(0.6))

#Add Title - main
qplot(data=mergedDF,x=Internet.users,y=Birth.rate,
      color=Region, size=I(5), shape=I(17), 
      alpha=I(0.4), main="Birth Rate vs Internet Usage")

#------------------------- HOMEWORK ---------
#You are required to produce a scatterplot depicting 
#Life Expectancy (y-axis) and
#Fertility Rate (x-axis) statistics by Country.
#The scatterplot needs to also be categorised 
#by Countries’ Regions.

#You have been supplied with data for 2 years: 1960 and 2013 and you are required
#to produce a visualisation for each of these years.
#Some data has been provided in a csv file, 
#some - in R vectors. The csv file contains
#combined data for both years. 
#All data manipulations have to be performed in R 
#(not in excel) because this project may be audited at a later stage.
#You have also been requested to provide insights 
#into how the two periods compare. 

#1)download the data into the correct folder

#2)upload the data into R
stats2<-read.csv(file.choose())
stats2 #data is 374 obs of 5 variables
is.data.frame(stats2) #TRUE data is in a dataframe

#3)Basic Data Exploration 
nrow(stats2) #number of rows is 374
ncol(stats2) #number of columns is 5
head(stats2) #gives top 6 rows of the dataframe
tail(stats2) #gives bottom 6 rows of the dataframe - 374 is last

str(stats2) #structure of the dataframe - 187 Country.Name, 187 Country.Code
#Region - factor with 6 levels
#Year 1960 and 2013 are listed as integers
#Fertility.Rate is a number

summary(stats2) #summary of statistics, min, max, median, percentiles
#Region - remember each country is listed twice!
#Year - only 2 years, 1960, 2013 so info here is not meaningful
#Fertility.Rate min 1.124 max 8.187

#4)Need to split (filter) the 1960 data from the 2013 data

#Filter the dataframes
data1960 <- stats2[stats2$Year==1960,]
data2013 <- stats2[stats2$Year==2013,]

#Check row counts
str(data1960) #187 rows
str(data2013) #187 rows. Equal split.

#5)Do not have life expectancy in this data set - need to 
#download homework vectors and execute code to read them in
#Three new vectors - Country_Code, Life_Expectancy_At_Birth_1960, Life_Expectancy_At_Birth_2013

#6)create two new dataframes from new vectors 
rm(FertDF)

FertDF1960<-data.frame(Country_Code, Life_Expectancy_At_Birth_1960)
head(FertDF1960)

FertDF2013<-data.frame(Country_Code, Life_Expectancy_At_Birth_2013)
head(FertDF2013)


#6)merge dataframes using by.x=Country.Code and by.y=Country_Code
FertExpectDF1960<-merge(data1960,FertDF1960,by.x="Country.Code", by.y="Country_Code")
head(FertExpectDF1960)

FertExpectDF2013<-merge(data2013,FertDF2013,by.x="Country.Code", by.y="Country_Code")
head(FertExpectDF2013)

#7)Create scatterplots of Life Expectancy (y-axis) and
#Fertility Rate (x-axis) statistics by Country, based on region.

#1960 Scatterplot using qplot
qplot(data=FertExpectDF1960,x=Fertility.Rate,y=Life_Expectancy_At_Birth_1960,
      color=Region, size=I(5), shape=I(17), 
      alpha=I(0.4), main="Life Expectancy vs Fertility Rate 1960")

#2013 Scatterplot using qplot
qplot(data=FertExpectDF2013,x=Fertility.Rate,y=Life_Expectancy_At_Birth_2013,
      color=Region, size=I(5), shape=I(17), 
      alpha=I(0.4), main="Life Expectancy vs Fertility Rate 2013")

#8)ANALYSIS
#Fertility rate has decreased substantially between 1960 and 2013
# in 1960, most of Africa had Fertility Rates bet. 6-8, in 2013, it was 4-6
#Life expectancy in 1960 went up to about 74, in 2013 it was up to near 90
#Life expectancy for both was negatively correlated with birthrate


#---------------------- ADVANCED VISUALIZATIONS WITH GGPLOT2 -------------