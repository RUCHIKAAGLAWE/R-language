#case study on annual income

#Read the dataset---
getwd()
setwd("C:/Users/Dell/Downloads/R programming data/analytics edge R")
Startups<-read.csv("C:/Users/Dell/Downloads/R programming data/datasets/50_Startups.csv")

View(Startups)

summary(Startups)

##Handling Missing values in the dataset:
#Counting the total no. of missing values
sum(is.na(Startups))

# To check Plan Subscription ratio in dataset
table(Startups$State)/nrow(Startups)
# Avg Premium by state# To check Plan Subscription ratio in dataset
library(sqldf)
sqldf("select State, COUNT (*) as obs, avg(Profit) from Startups GROUP BY 1")
#Create dummy variables for states:
Startups1 <- Startups
Startups1$State1 <- ifelse(Startups$State=='New York',1,0)
Startups1$State2 <- ifelse(Startups$State=='California',1,0)
View(Startups1)
str(Startups1)

#Removing column: "State" bcz created Dummy Var columns for it.
Startups1 <- Startups1[,-4]
str(Startups1)

View(Startups1)
str(Startups1)

# Splitting the dataset into the Training set and Test set 
trainDataIndex <- sample(1:nrow(Startups1),0.7*nrow(Startups1), replace = F)
trainData <-Startups1[trainDataIndex, ]
testData <- Startups1[-trainDataIndex, ]
View(trainData)
View(testData)

#regression model

# Fitting Multiple Linear Regression to the Training set 
regressor = lm(Profit ~ ., 
               data = trainData) 
summary(regressor)

# removing insignificant veriable to the Training set 
regressor = lm(Profit ~ R.D.Spend + #Administration +
                 Marketing.Spend + #State1 + #State2,
               data = trainData) 
summary(regressor)

#On building the model, we see that only var "R&D spend" comes out to be significant enough to predict the val of Dependent var "Profit".

# Predicting the Test set results 
y_pred = predict(regressor, newdata = testData)
testData$Pred_Profit = y_pred

#Accuracy of the Model:
#MAPE(MeanAbsolutePercentageError): 
#Lower its value better is the accuracy of the model.

#MAPE Calculation:
mape <- mean(abs((testData$Pred_Profit - testData$Profit))/testData$Profit)
mape

# Mape using mape function
#install.packages("Metrics")
library(Metrics)
mape(testData$Pred_Profit,testData$Profit)

#Since the error term is around 0.06, 
#it means there is only 6% error in our model's prediction.







