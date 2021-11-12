## Homework Assignment 8 - Evan Callaghan

## 1. When there is an omitted predictor in the multiple regression model, which is determinant of the target variable, then

## C. This will always bias the ordinary least squares estimates of the included predictors

## 2. Consider the following multiple regression model: Y = 10.54 + 2.977X − 6.59PC − 2.73PF, where Y represents points scored 
## in 2010-2011 NBA season, X denote the player’s offensive rebounds per game for that season, PC denotes the indicator variable 
## for centers, and PF denotes the indicator variable for forwards. The predictor variable X is found to be highly significant, 
## then we would conclude that ...?

## We would conclude that changes in a player's offensive rebounds per game (X) produce a significant change in the points scored by that player (Y).

### 3. Which of the following is/are TRUE about R2 (the coefficient of determination of a linear regression model)?

## D. R2 represents the percentage of the total variation in the target variable that is explained by the predictor variables

## 4. a) Read the csv file and creating a data-frame called hitters
hitters = read.csv(file = 'Hitters.csv')
head(hitters)

## Removing observations with missing values
hitters = na.omit(hitters)


## b) Creating the following variables:
## log_Salary that represents the log of Salary (use
## League_0_1 that takes the value of 1 when League = A and 0 otherwise

hitters$log_Salary = log(hitters$Salary)
hitters$League_0_1 = ifelse(hitters$League == 'A', 1, 0)


## c) Building a linear regression model in which AtBat, Hits, HmRun, and League_0_1 are the predictor variables 
## and log_Salary is the target variable

## Building the model
lm_md = lm(log_Salary ~ AtBat + Hits + HmRun + League_0_1, data = hitters)

## Extracting model results
summary(lm_md)


## i) Estimated Coefficients

## In terms of the estimated coefficients, the most important variable is League_0_1 (largest coefficient) 
## and AtBat is the least important variables (smallest coefficient).


## ii) Standardized regression coefficients

s_log_Salary = sd(hitters$log_Salary)
s_AtBat = sd(hitters$AtBat)
s_Hits = sd(hitters$Hits)
s_HmRun = sd(hitters$HmRun)
s_league_0_1 = sd(hitters$League_0_1)

## Computing the standardized regression coefficients
print(c('Standardized Coefficient of AtBat:', 0.0022 * s_AtBat / s_log_Salary))
print(c('Standardized Coefficient of Hits:', 0.0142 * s_Hits / s_log_Salary))
print(c('Standardized Coefficient of HmRun:', 0.0183 * s_HmRun / s_log_Salary))
print(c('Standardized Coefficient of League_0_1:', 0.157 * s_league_0_1 / s_log_Salary))

## In terms of the standardized regression coefficient, Hits is the most important variable (highest standardized 
## regression coefficient) and League_0_1 is the least important variable (lowest standardized regression coefficient).


## iii) Contribution to R-squared

corr_ls_AtBat = cor(hitters[, c('log_Salary', 'AtBat')])[1, 2]
corr_ls_Hits = cor(hitters[, c('log_Salary', 'Hits')])[1, 2]
corr_ls_HmRun = cor(hitters[, c('log_Salary', 'HmRun')])[1, 2]
corr_ls_League_0_1 = cor(hitters[, c('log_Salary', 'League_0_1')])[1, 2]


print(c('The contribution of AtBat to R^2 is', 100 * 0.0022 * s_AtBat * corr_ls_AtBat / s_log_Salary))
print(c('The contribution of Hits to R^2 is', 100 * 0.0142 * s_Hits * corr_ls_Hits / s_log_Salary))
print(c('The contribution of HmRun to R^2 is', 100 * 0.0183 * s_HmRun * corr_ls_HmRun / s_log_Salary))
print(c('The contribution of League_0_1 to R^2 is', 100 * 0.157 * s_league_0_1 * corr_ls_League_0_1 / s_log_Salary))

## In terms of the contribution of the variable to R2, Hits is the most important variable (highest contribution to R^2) 
## and League_0_1 is the least important variable (lowest contribution to R^2).

