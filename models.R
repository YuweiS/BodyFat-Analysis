library(car)
#load data from "pre-clean.R"
load("data/new_BodyFat.Rdata")
BodyFat<-new_BodyFat
set.seed(100)
train_index=sample(1:249,size=200,replace=F)
train=BodyFat[train_index,]
test=BodyFat[-train_index,]
data<-train[,-2]
#Model 1 simple linear regression
model<-lm(BODYFAT~.,data = data)    
#summary(model)


#Model 2 is using Mallow Cp to find the best variables
X <- model.matrix(model)[,-1]
Y <- data[,1]
#Mallow’s Cp is a criteria based on the Model Error.
library(leaps) # for leaps()
library(faraway) # for Cpplot()
g <- leaps(X, Y, nbest = 1)
#Cpplot(g)
#(2,7,11,14)seems to be a good selection
cp.choice <- c(2,7,11,14)+1
#summary(model.cp <- lm(BODYFAT ~ ., data=data[,c(1,cp.choice)]))
#BODYFAT ~ WEIGHT + ABNOMEN + WRIST + ANKLE 


#Model 3 Stepwise selecting
model.AIC <- step(model, k=2, direction = "both",trace=0)
#BODYFAT ~ AGE + WEIGHT + HEIGHT + ADIPOSITY + ABDOMEN + THIGH + WRIST
m1<-lm(BODYFAT ~ AGE + WEIGHT + HEIGHT + ADIPOSITY + ABDOMEN + THIGH + 
         WRIST,data = data)
#summary(m1)

model.BIC <- step(model, k=log(249),trace=0)
#BODYFAT ~ AGE + ABDOMEN + WRIST
m2<-lm(BODYFAT ~ WEIGHT + ABDOMEN + WRIST,data = data)
#summary(m2)


base <- lm(BODYFAT~1,data=data)
AIC.base <- step(base,direction="both", scope=list(lower=~1,upper=model),trace=F)
#BODYFAT ~ ABDOMEN + WEIGHT + WRIST + ANKLE + FOREARM
m3<-lm(BODYFAT ~ ABDOMEN + WEIGHT + WRIST + ANKLE + FOREARM,data = data)
#summary(m3)

#vif(m2)

