library(tidyverse)
source("code/multiplot.R")
BodyFat<-read.csv("data/BodyFat.csv",header=T)
BodyFat<-select(BodyFat,-IDNO)
#plot(BodyFat,cex=0.01,col="blue")

bodyfat<-BodyFat

#We need to do some data cleaning first. 
#Notice that there are some points outside of the cloud of data, 
#which means they’re outlier candidates, that is, either leverage points or outliers in Y.

g1<-ggplot(data=bodyfat)+geom_point(aes(BODYFAT,1/DENSITY))

#Since BODYFAT and DENSITY are equal variables, we do not consider density in the model.
#summary(model <- lm(BODYFAT ~ ., data=subset(bodyfat[-182,],select = c(-DENSITY))))$coef
#Rule of thumb: classify as leverages anything above 4/(n-p). (Fox, 1997)
#g2<-plot(model, which=4)
#abline(h = 4/(252-15),lty=2)

#See 42nd guy
#   BODYFAT DENSITY AGE WEIGHT HEIGHT ADIPOSITY NECK CHEST
#42    31.7   1.025  44    205   29.5      29.9 36.6   106
#ABDOMEN   HIP THIGH KNEE ANKLE BICEPS FOREARM WRIST
#42   104.3 115.5  70.6 42.5  23.7   33.6    28.7  17.4
#Obviously, he has extremely short height

#summary(model <- lm(BODYFAT ~ ., data=bodyfat[-c(42,182),-2]))

#layout(matrix(1:4, ncol=2))
#plot(model)
#layout(matrix(1))
#plot(model, which=4)

#the 39th guy weights 363 pounds. Let’s say we remove him from the model as well.
new_BodyFat<-bodyfat[c(-39,-42,-182),]
save(new_BodyFat,file = "new_BodyFat.Rdata")

p1=ggplot(data = BodyFat)+geom_histogram(aes(HEIGHT),binwidth = 3,color="white")
p2=ggplot(data = BodyFat)+geom_histogram(aes(WEIGHT),binwidth = 10,color="white")
g <- multiplot(p1,p2,layout=matrix(data=c(1,2),nrow=1,byrow = T))