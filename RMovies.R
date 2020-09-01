#-------------------------------Movie ratings Project----------------------
#You have been approached as an analytics consultant by a movie reviews website.
#They are writing up an article analysing movie ratings by critics and audience as well
#as movie budgets for the years 2007-2011.
#This is the first time they are doing this analysis and they don’t know exactly what
#they need. They have asked you to look into the data and provide them with 5 graphs
#that tell a story about the data.
#However, there is one chart the CEO specifically requested - a diagram showing how
#the correlation between audience and critic ratings has evolved throughout the years
#by genre. This is in addition to the other 5. See the next page for the CEO’s “Vision”

#read in data
getwd()
movies<-read.csv(file.choose())
head(movies)
colnames(movies)<-c("Film","Genre","CriticRating","AudRating","BudgetMill","Year")

#-------------------------------Basic Exploration
head(movies)
tail(movies) #looks good - nothing has shifted, 562 movies
str(movies) #562 movies, no duplicates - genre is factor with 7 levels
#factors are categorical variables - automatically assigned by R

summary(movies)
#Year needs to be categorical variable, not integer - use factor function
movies$Year<-factor(movies$Year)
str(movies)
summary(movies)

#--------------------------------Aesthetics and ggplot2
#aesthetics is how your data maps onto the plot
library(ggplot2)
ggplot(data=movies, aes(x=CriticRating, y=AudRating))

#add geometry layer so we have some sort of dot to look at!
ggplot(data=movies, aes(x=CriticRating, y=AudRating, color=Genre)) +
  geom_point()

#add size based on budget
ggplot(data=movies, aes(x=CriticRating, y=AudRating, 
                        color=Genre, size=BudgetMill)) +
  geom_point()

#------------------------Plotting with Layer - layering geometries
#to add a layer, you have to add an object as layer - p is an object
p<-ggplot(data=movies, aes(x=CriticRating, y=AudRating, 
                           color=Genre, size=BudgetMill))
#point
p+geom_point()

#line
p+geom_line() #technically this is meaningless, just looking at concept

#to see the points, layer on top
p+geom_line()+geom_point()

#------------------------Overriding Aesthetics -----------------
q<-ggplot(data=movies, aes(x=CriticRating, y=AudRating, 
                           color=Genre, size=BudgetMill))
q+geom_point()

#overriding aesthetics (mapping)
#example1
q+geom_point(aes(size=CriticRating))

#example2
q+geom_point(aes(size=BudgetMill))
#note that q doesn't change

#example3 - 2nd deliverable chart
q + geom_point(aes(x=BudgetMill)) #note that xaxis stays same
q + geom_point(aes(x=BudgetMill))+
  xlab("BudgetMill $$$")

#example4 - reduce line size - setting aes instead of mapping
q + geom_line(size=1)+geom_point()

#-------------------------MAPPING vs SETTING ---------------------

r<-ggplot(data=movies, aes(x=CriticRating, y=AudRating))
r+geom_point() 

#Add color
#1. Mapping (what we've done so far):
# this maps the data from Genre as the colors
r + geom_point(aes(color=Genre)) 
r + geom_point(aes(size=BudgetMill))

#2. Setting - just sets the color for all points to what we want
r + geom_point(color="DarkGreen")
r + geom_point(size=5)

#3. ERROR - can't combine the two - thinks you are mapping a label to the data
#r+ geom_point(aes(color="DarkGreen"))

#----------------- HISTOGRAMS AND DENSITY CHARTS -------
s<-ggplot(data=movies, aes(x=BudgetMill))
s +geom_histogram(binwidth = 10)

#add color- mapping to genre
s +geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border - set this color=black (chart#3)
s +geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

#sometimes you need density charts - 
#illustrates probability density function - area in band is probability
s+geom_density(aes(fill=Genre), position="stack")

#----------------- STARTING LAYER TIPS -------------

t<-ggplot(data=movies, aes(x=AudRating))
t+geom_histogram(binwidth = 10,
                 fill="White", color="Blue")

#Another way to do this...using overriding
#this is more flexible if changing x often
#but not best coding practice
t<-ggplot(data=movies)
t+geom_histogram(binwidth = 10, 
                 aes(x=AudRating),
                 fill="White", color="Blue")

t+geom_histogram(binwidth = 10, 
                 aes(x=CriticRating),
                 fill="White", color="Blue")

#skeleton plot - for using different data sets

u<-ggplot()


#---------------# Homework: Law of Large Numbers ---------
# check the normal distribution
# 68.2% should fall between -1 and 1

rnorm(100) #generates 100 random variables

N<-1000000  #input (number of random variables)
counter<-0

for(i in rnorm(N)){
  if(i>-1 & i<1){  #i is not a counter here, it is the value
    counter=counter+1
  }
}
counter/N
#--------------------- Statistical Transformations -----------
