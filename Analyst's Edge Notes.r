# 15.071x Analyst's Edge Notes
# Formatted notes from the MITx course run starting in March 2014.

# Get the current directory
getwd()

# Read a csv file
dataset = read.csv("datasource.csv")

# Structure of the dataset
str(dataset)

# Statistical summary
summary(dataset)
 
# Vector notation of one column/field
dataset$column_name

# Finding the index of the row in the column with the maximum value
which.max(dataset$column_name)
  
# Get names of variables in the dataset
names(dataset)
  
# Create a subset of the dataset given a criteria (ie, value above n)
dataset_subset = subset(dataset, column_name > n)

# Count the number of rows, or observations
nrow(dataset)

# Finding the index of value in the dataset within a field
match(value, dataset$column_name)

# Using found index with value in column_two to return the corresponding value in column_one.
 dataset$column_one[match(value, dataset$column_two)]
 
# Scatter Plots with xlabel, ylabel, title, and colored red.
plot(dataset$column_one, dataset$column_two, xlab="Column One", ylab = "Column Two", main = "Column One v Column Two", col = "red")
  
# Creating a histogram with x-axis limits and specified breaks.
hist(dataset_column, xlab = "Column One", main = "Histogram Title", xlim = c(0,100), breaks=100)
  
# Boxplots
boxplot(dataset$column_name, ylab = "Column_Name", main = "Boxplot of Column_Name")

# Creating a database variable equal to 1 if the value is greater than average, 0 otherwise
dataset$new_column = as.numeric(dataset$column_name > mean(dataset$column_name, na.rm=TRUE))

# Average amount of column_one sorted by column_two using tapply
tapply(dataset$column_one, dataset$column_two, mean, na.rm=TRUE)

# Linear regression of dataset with limited independent variables, then all variables from the dataset except for the dependent
linear_model = lm(dependent ~ independent1 + independent2 +...+ independentn, data=dataset)
linear_model = lm(dependent ~ ., data=dataset)

# Sum of squared errors
SSE = sum(linear_model$residuals^2)

# Rsquared and adjusted Rsquared
r_squared = summary(linear_model)$r.squared
adj_r_squared = summary(linear_model)$adj.r.squared

# Correlations
cor(dataset$column_one, dataset$column_two)

# Make test set predictions
prediction = predict(linear_model, newdata=testing_data)

# Compute SSE, SST, R^2, and RMSE (root mean square error)
SSE = sum((testing_data$dependent - prediction)^2)
SST = sum((testing_data$dependent - mean(dataset$dependent))^2)
rsquared = 1 - SSE/SST
RMSE = sqrt(SSE/nrow(dataset))

# caTools package: contains basic utility functions including window statistic functions, read/write for GIF and ENVI binary files, fast AUC calcs, etc
# caTools functions: LogitBoost, predict.LogitBoost, sample.split
library(caTools)

# Randomly split data
split = sample.split(dataset$dependent, SplitRatio = 0.75)
# Create training and testing sets
training_data = subset(dataset, split == TRUE)
testing_data = subset(dataset, split == FALSE)

# Logistic Regression Model
logistic_regression_model = glm(dependent ~ independent1+independent2+...+independentn, data=training_data, family='binomial')

# Make predictions on training set using logistic model
predicted = predict(logistic_regression_model, type="response")

# Confusion matrix for threshold of 0.5
table(training_data$dependent, predicted > 0.5)

# ROCR package: 
# ROCR function: performance (prediction.obj, measure, x.measure='cutoff'), prediction (transforms input data in vector, matric, data frame, or list from into a standardized format), ROCR.simple (simple artificial prediction data for use with ROCR), ROCR.xval (artificial cross-validation data for use with ROCR)
library(ROCR)

# Prediction function
ROCRpred = prediction(predicted, training_data$dependent)

# Performance function comparing true positive to false positive rate, ROC.
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve with colors and  threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))

# Save AUC (area under curve)
auc = as.numeric(performance(ROCRpred, "auc")@y.values)

# mice package: multiple imputation using Fully Conditional Specification
library(mice)

# Multiple imputation (filling in missing values)
simple = datset[c("column1", "column2", ..., "columnn")]
imputed = complete(mice(simple))
dataset$column1 = imputed$column1
# ...
dataset$columnn = imputed$columnn

# Analyze mistake
subset(testing_data, predicted >= 0.5 & dependent == 0)

# rpart and rpart.plotlibraries: 
library(rpart)
library(rpart.plot)

# CART - Classification and Regression Trees - model
tree = rpart(dependent ~ independent1+independent2+...+independentn, data=training_data, control=rpart.control(minbucket=25))
# print regression tree
prp(tree)

# Make predictions
predictCART = predict(tree, newdata = testing_data, type = "class")
table(testing_data$dependent, predictCART)

# ROC curve
library(ROCR)
PredictROC = predict(tree, newdata = testing_data)
pred = prediction(PredictROC[,2], testing_data$dependent)
perf = performance(pred, "tpr", "fpr")
plot(perf)

# randomForest package
library(randomForest)

# Build random forest model
forest = randomForest(dependent ~ independent1+independent2+...+independentn, data=training_data, ntree=200, nodesize=25 )
# if it throws an error about the potential values of the dependent, convert by factoring:
training_data$dependent = as.factor(training_data$dependent)
testing_data$dependent = as.factor(testing_data$dependent)

# Make predictions
predictForest = predict(forest, newdata = testing_data)
table(testing_data$dependent, predictForest)

# caret and e1071 cross-validation packages
library(caret)
library(e1071)

# Define cross-validation experiment
fitControl = trainControl( method = "cv", number = 10 )
cartGrid = expand.grid( .cp = (1:50)*0.01) 

# Perform the cross validation
crossvalid = train(dependent ~ independent1+independent2+...+independentn, data=training_data, method = "rpart", trControl = fitControl, tuneGrid = cartGrid)

# Extract the tree and generate visualization:
best.tree = crossvalid$finalModel
prp(best.tree)

# Create a new CART model
treeCV = rpart(dependent ~ independent1+independent2+...+independentn, data=training_data, method="class", control=rpart.control(cp = 0.18))

# Make predictions
predictCV = predict(treeCV, newdata = testing_data, type = "class")

# tm and SnowballC packages: text mining framework for data import, corpus handling, preprocessing, meta data management, and creation of term-document matrices. SnowballC is an R interface to the C libstemmer library implementing Porter's word stemming algorithm for collapsing words to a common root.
library(tm)
library(SnowballC)

# Create corpus
corpus = Corpus(VectorSource(dataset$textvector))

# Convert to lower-case
corpus = tm_map(corpus, tolower)
# Remove punctuation
corpus = tm_map(corpus, removePunctuation)
# Remove stopwords and apple (for example); stopwords('english') can be the input without the c() function if no other words are to be specified
corpus = tm_map(corpus, removeWords, c("apple", stopwords("english")))
# Stem document 
corpus = tm_map(corpus, stemDocument)


# Video 6

# Create matrix

frequencies = DocumentTermMatrix(corpus)

frequencies

# Look at matrix 

inspect(frequencies[1000:1005,505:515])

# Check for sparsity

findFreqTerms(frequencies, lowfreq=20)

# Remove sparse terms

sparse = removeSparseTerms(frequencies, 0.995)
sparse

# Convert to a data frame

tweetsSparse = as.data.frame(as.matrix(sparse))

# Make all variable names R-friendly

colnames(tweetsSparse) = make.names(colnames(tweetsSparse))

# Add dependent variable

tweetsSparse$Negative = tweets$Negative

# Split the data

library(caTools)

set.seed(123)

split = sample.split(tweetsSparse$Negative, SplitRatio = 0.7)

trainSparse = subset(tweetsSparse, split==TRUE)
testSparse = subset(tweetsSparse, split==FALSE)



# Video 7

# Build a CART model

library(rpart)
library(rpart.plot)

tweetCART = rpart(Negative ~ ., data=trainSparse, method="class")

prp(tweetCART)

# Evaluate the performance of the model
predictCART = predict(tweetCART, newdata=testSparse, type="class")

table(testSparse$Negative, predictCART)

# Compute accuracy

(294+18)/(294+6+37+18)

# Baseline accuracy 

table(testSparse$Negative)

300/(300+55)


# Random forest model

library(randomForest)
set.seed(123)

tweetRF = randomForest(Negative ~ ., data=trainSparse)

# Make predictions:
predictRF = predict(tweetRF, newdata=testSparse)

table(testSparse$Negative, predictRF)

# Accuracy:
(293+21)/(293+7+34+21)

# Week 5 - Recitation


# Video 2

# Load the dataset

emails = read.csv("energy_bids.csv", stringsAsFactors=FALSE)

str(emails)

# Look at emails

emails$email[1]
emails$responsive[1]
 
emails$email[2]
emails$responsive[2]

# Responsive emails

table(emails$responsive)



# Video 3


# Load tm package

library(tm)


# Create corpus

corpus = Corpus(VectorSource(emails$email))

corpus[[1]]


# Pre-process data
corpus <- tm_map(corpus, tolower)

corpus <- tm_map(corpus, removePunctuation)

corpus <- tm_map(corpus, removeWords, stopwords("english"))

corpus <- tm_map(corpus, stemDocument)

# Look at first email
corpus[[1]]



# Video 4

# Create matrix

dtm = DocumentTermMatrix(corpus)
dtm

# Remove sparse terms
dtm = removeSparseTerms(dtm, 0.97)
dtm

# Create data frame
labeledTerms = as.data.frame(as.matrix(dtm))

# Add in the outcome variable
labeledTerms$responsive = emails$responsive

str(labeledTerms)



# Video 5


# Split the data

library(caTools)

set.seed(144)

spl = sample.split(labeledTerms$responsive, 0.7)

train = subset(labeledTerms, spl == TRUE)
test = subset(labeledTerms, spl == FALSE)

# Build a CART model

library(rpart)
library(rpart.plot)

emailCART = rpart(responsive~., data=train, method="class")

prp(emailCART)



# Video 6

# Make predictions on the test set

pred = predict(emailCART, newdata=test)
pred[1:10,]
pred.prob = pred[,2]

# Compute accuracy

table(test$responsive, pred.prob >= 0.5)

(195+25)/(195+25+17+20)

# Baseline model accuracy

table(test$responsive)
215/(215+42)



# Video 7

# ROC curve

library(ROCR)

predROCR = prediction(pred.prob, test$responsive)

perfROCR = performance(predROCR, "tpr", "fpr")

plot(perfROCR, colorize=TRUE)

# Compute AUC

performance(predROCR, "auc")@y.values

