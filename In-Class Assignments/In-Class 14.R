## In-Class Assignment 14 - Evan Callaghan

## Considering the following non-linear model: y = 3.2 + 1.87x + 2.1x^2

##  1. Interpret the quadratic coefficient

## Holding the other variable constant, if we increase X by two units, on average, Y will increase by 8.4.


## 2. The coefficient of determination of the above model is 91%. Interpret it.

## 91% of the variability in Y can be explained by a quadratic model in which X is the predictor variable.


## 3. Using the model, estimate the value of y when x = 3.2

## Y = 3.2 + 1.87(3.2) + 2.1(3.2)^2
## Y = 30.688


## 4. a) Using pandas to read the Batting.csv file and create a data-frame called batting

batting = read.csv(file = 'Batting.csv')
head(batting)

## b) Creating another data-frame called batting_agg that contains aggregated data at the player level. 
## That is the batting_agg should contain the total home-runs, total at bats, and total strikeouts

library(plyr)

batting_agg = ddply(batting, .(playerID), summarise, total_AB = sum(AB, na.rm = T), total_HR = sum(HR, na.rm = T), total_SO = sum(SO, na.rm = T))
head(batting_agg)


## c) Selecting players with at least 5000 career at bats

batting_agg = subset(batting_agg, total_AB >= 5000)


## d) Computing the home-run rate as total home-runs divided by total at bats. Also computing
## the strikeout rate as total strikeout divided by total at bats.

batting_agg$HR_rate = batting_agg$total_HR / batting_agg$total_AB

batting_agg$SO_rate = batting_agg$total_SO / batting_agg$total_AB


## e) Building a quadratic regression model in which home-run rate is the predictor variable
## and strikeout rate is the target variable


## Building the model
quad_md = lm(SO_rate ~ HR_rate + I(HR_rate^2), data = batting_agg)

## Extracting model results
summary(quad_md)


## f) The estimated quadratic coefficient is significant because |-18.52| > |2*4.23| and therefore, zero is not included in the
## estimated interval.




