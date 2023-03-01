setwd("c:/repos/r/project-2")

read.auto.data = function() {
  Auto = read.csv("Auto.csv")
  na.omit(Auto)
  Auto$horsepower = as.numeric(Auto$horsepower) # convert horsepower to numeric
  return(Auto)
}

# Read data
Auto = read.auto.data()
Auto = data.frame(Auto)
attach(Auto)
fix(Auto)
summary(Auto)

# a): Add binary variables mpg01 to data set
mpg01 = rep(0, length(mpg)) # mpg01 = 0 if mpg < median(mpg)
mpg01[mpg > median(mpg)] = 1 # else mpg01 = 1 if mpg > median(mpg)
Auto$mpg01 = mpg01
Auto[mpg01 = 1]
table(Auto$mpg01)
Auto[mpg < 23,]

# b): Exploring the data graphically
Auto = subset(Auto, select = -c(name)) # extract only numeric data
pairs(Auto)

# Box plots for each pair of variables
par(mfrow = c(3, 3))
for (col in colnames(Auto[,-c(1, 9)])) {
 boxplot(Auto$mpg01, Auto[,col], xlab = col, ylab = "MPG > Median") 
}

# c): Split data into a training and test set
train = sample(c(TRUE, FALSE), nrow(Auto), replace=TRUE)
Auto.train = Auto[train,]
Auto.test = Auto[!train,]

# d): 