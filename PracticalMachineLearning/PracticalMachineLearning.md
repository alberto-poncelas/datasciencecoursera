Practical Machine Learning project
========================================================


# Introduction



Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively (more information is available from the website here: http://groupware.les.inf.puc-rio.br/har). In this project, the goal is to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants to predict the exercise they do. For doing predictions we are going to use a KNN model.


The training data for this project are available here: 
https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here: 
https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv


# Analysis


Necessary libraries and data is loaded.



```
## Loading required package: lattice
## Loading required package: ggplot2
```



We first preprocess the data. Here, we remove the first columns (the ones that contains names, dates...) and also those columns 
that have many NA values. We then scale and center the data.



```r
## Preprocess data##

classe <- as.factor(data$classe)

# Get numeric values
data <- apply(data[, 8:159], 2, as.numeric)

# Remove columns with many NA
data <- data[, colSums(is.na(data)) < (nrow(data) * 0.7)]

# Scale and center data
data <- scale(data, center = TRUE, scale = TRUE)
data <- as.data.frame(data)
data <- as.data.frame(cbind(data, classe))
```





Once the data has been preprocessed we create the model. We have decided to use K-Nearest Neighbors algorithm. For validating the model we are using a 10-fold cross validation.





```r
## Create model##
fit <- train(classe ~ ., data = data, method = "knn", trControl = trainControl(method = "cv", 
    number = 10))
fit
```

```
## k-Nearest Neighbors 
## 
## 19622 samples
##    52 predictors
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## 
## Summary of sample sizes: 17660, 17660, 17660, 17661, 17660, 17660, ... 
## 
## Resampling results across tuning parameters:
## 
##   k  Accuracy  Kappa  Accuracy SD  Kappa SD
##   5  1         1      0.003        0.004   
##   7  1         1      0.003        0.004   
##   9  1         0.9    0.005        0.006   
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was k = 5.
```


As we can see, with KNN, a good accuracy is obtained. We are using this model, being K=5, to makes predictions.


# Prediction

Lastly, we use the model created for making predictions of testing set.


```r

## Prediction##

test <- read.csv("pml-testing.csv", header = TRUE, as.is = TRUE, stringsAsFactors = FALSE, 
    sep = ",", na.strings = c("NA", "", "#DIV/0!"))


test <- apply(test[, 8:159], 2, as.numeric)
test <- test[, colSums(is.na(test)) < (nrow(test) * 0.7)]
test <- scale(test, center = TRUE, scale = TRUE)
test <- as.data.frame(test)


prediction <- predict(fit, test)
prediction
```

```
##  [1] B A B A A E D B A A B C B A E E A B B B
## Levels: A B C D E
```



