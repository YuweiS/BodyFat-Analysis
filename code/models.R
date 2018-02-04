library(tidyverse)
library(car)
#load data from "pre-clean.R"
load("~/data/new_BodyFat.Rdata")
BodyFat<-new_BodyFat
set.seed(100)
train_index=sample(1:249,size=200,replace=F)
train=BodyFat[train_index,]
test=BodyFat[-train_index,]
data<-train[,-2]
#Model 1 simple linear regression
model<-lm(BODYFAT~.,data = data)    
summary(model)
#Residual standard error: 3.994 on 185 degrees of freedom
#Multiple R-squared:  0.7446,	Adjusted R-squared:  0.7253 
#F-statistic: 38.53 on 14 and 185 DF,  p-value: < 2.2e-16

#Model 2 is using Mallow Cp to find the best variables
X <- model.matrix(model)[,-1]
Y <- data[,1]
#Mallow’s Cp is a criteria based on the Model Error.
library(leaps) # for leaps()
library(faraway) # for Cpplot()
g <- leaps(X, Y, nbest = 1)
Cpplot(g)
#(2,7,11,14)seems to be a good selection
cp.choice <- c(2,7,11,14)+1
summary(model.cp <- lm(BODYFAT ~ ., data=data[,c(1,cp.choice)]))
#BODYFAT ~ WEIGHT + ABNOMEN + WRIST + ANKLE 
#MSE=15.06812

#Model 3 Stepwise selecting
model.AIC <- step(model, k=2, direction = "both")
#BODYFAT ~ AGE + WEIGHT + HEIGHT + ADIPOSITY + ABDOMEN + THIGH + WRIST
m1<-lm(BODYFAT ~ AGE + WEIGHT + HEIGHT + ADIPOSITY + ABDOMEN + THIGH + 
         WRIST,data = data)
summary(m1)
#Residual standard error: 3.961 on 194 degrees of freedom
#Multiple R-squared:  0.7365,	Adjusted R-squared:  0.7297 
#F-statistic: 108.5 on 5 and 194 DF,  p-value: < 2.2e-16
#MSE=14.7019

model.BIC <- step(model, k=log(249))
#BODYFAT ~ AGE + ABDOMEN + WRIST
m2<-lm(BODYFAT ~ WEIGHT + ABDOMEN + WRIST,data = data)
summary(m2)
#Residual standard error: 4.017 on 196 degrees of freedom
#Multiple R-squared:  0.7262,	Adjusted R-squared:  0.7221 
#F-statistic: 173.3 on 3 and 196 DF,  p-value: < 2.2e-16
#MSE=13.98879

base <- lm(BODYFAT~1,data=data)
AIC.base <- step(base,direction="both", scope=list(lower=~1,upper=model),trace=T)
#BODYFAT ~ ABDOMEN + WEIGHT + WRIST + ANKLE + FOREARM
m3<-lm(BODYFAT ~ ABDOMEN + WEIGHT + WRIST + ANKLE + FOREARM,data = data)
summary(m3)
#Residual standard error: 3.984 on 195 degrees of freedom
#Multiple R-squared:  0.7321,	Adjusted R-squared:  0.7266 
#F-statistic: 133.2 on 4 and 195 DF,  p-value: < 2.2e-16
#MSE=14.86959
vif(m2)

