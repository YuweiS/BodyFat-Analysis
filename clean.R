library(tidyverse)
#setwd("/Users/jacqueline/Dropbox/UW-M/628 Data Science Practium/Module 1")

BodyFat<-read.csv("BodyFat.csv",header=T)
BodyFat<-select(BodyFat,-IDNO)
#plot(BodyFat,cex=0.01,col="blue")

# divide the whole dataset into train & test
#floor(252*0.8)
set.seed(124)
train_index<-sample(1:252,size=201,replace = F)
train<-BodyFat[train_index,]
test<-BodyFat[-train_index,]

bodyfat<-train

#We need to do some data cleaning first. 
#Notice that there are some points outside of the cloud of data, 
#which means they’re outlier candidates, that is, either leverage points or outliers in Y.

plot(BODYFAT~1/DENSITY,data=bodyfat)
#Since BODYFAT and DENSITY are equal variables, we do not consider density in the model.
summary(model <- lm(BODYFAT ~ ., data=subset(bodyfat,select = c(-DENSITY))))$coef
#Rule of thumb: classify as leverages anything above 4/(n-p). (Fox, 1997)
plot(model, which=4)
abline(h = 4/(252-15),lty=2)

#See 42nd guy
#   BODYFAT DENSITY AGE WEIGHT HEIGHT ADIPOSITY NECK CHEST
#42    31.7   1.025  44    205   29.5      29.9 36.6   106
#ABDOMEN   HIP THIGH KNEE ANKLE BICEPS FOREARM WRIST
#42   104.3 115.5  70.6 42.5  23.7   33.6    28.7  17.4
#Obviously, he has extremely short height

summary(model <- lm(BODYFAT ~ ., data=bodyfat[-37,-2]))

layout(matrix(1:4, ncol=2))
plot(model)
layout(matrix(1))
plot(model, which=4)
#the 39th guy weights 363 pounds. Let’s say we remove him from the model as well.
new_train<-train[c(-37,-149),]
save(new_train,file = "new_train.Rdata")
