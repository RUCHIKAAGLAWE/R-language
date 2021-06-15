
##titanic dataset


getwd()
setwd("C:/Users/Dell/Downloads/R programming data/analytics edge R")
Plan_Dataset <- read.csv("C:/Users/Dell/Downloads/R programming data/datasets/titanic.csv")
View(Plan_Dataset)
df<-data.frame(Plan_Dataset)
View(df)


summary(df)
str(df)
#Is there any missing value in the dataset
sum(is.na(df))

#Drop variables home.dest,cabin, name, X and ticket
#Create factor variables for pclass and survived
library(dplyr)
clean_titanic <- df %>%
  select(-c(home.dest, cabin, name, x, ticket)) %>% 
  #Convert to factor level
  mutate(pclass = factor(pclass, levels = c(1, 2, 3), labels = c('Upper', 'Middle', 'Lower')),
         survived = factor(survived, levels = c(0, 1), labels = c('No', 'Yes'))) %>%
  na.omit()
glimpse(clean_titanic)


#Convert few Categorical var from chr to factor----
clean_titanic$sex <- as.factor((clean_titanic$sex))
clean_titanic$embarked <- as.factor((clean_titanic$embarked))


#Convert few cont var from factor to numeric----
clean_titanic$fare <- as.numeric(as.character(clean_titanic$fare))
clean_titanic$age <- as.numeric(as.character(clean_titanic$age))

str(clean_titanic)

#Create train/test set----
View(clean_titanic)
trainDataIndex <- sample(1:nrow(clean_titanic),0.8*nrow(clean_titanic), replace = F)
trainData <-clean_titanic[trainDataIndex, ]
testData <- clean_titanic[-trainDataIndex, ]
View(trainData)
View(testData)


#Build the model----
#install.packages("rpart")
#install.packages("rpart.plot")
library(rpart)
library(rpart.plot)
#Decision Tree

fit <- rpart(survived~., data = trainData, method = 'class')
rpart.plot(fit)

#Prediction:
# Using the decision tree model build above on the test dataset, 
#we will predict which passengers are more likely to survive after the collision.
testData$predict_unseen <-predict(fit, testData, type = 'class')
View(testData)

#Checking Accuracy of Model using: Confusion Matrix----
table(testData$predict_unseen)/nrow(testData)
table_mat<-table(testData$predict_unseen,testData$survived)
table_mat

##From the above table cmd, we have got confusion matrix, stating that:
#No. of "No" present in training dataset is equal to no. of "No" predicted in test dataset , for 115 enteries.
#No. of "Yes" present in training dataset is equal to no. of "Yes" predicted in test dataset for 52 enteries.
#Hence, Accuracy will be = (115+52)/(115+52+35+7) = 80%
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
accuracy_Test






















