# Law of Large Numbers
#check the normal distribution
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