## Homework Assignment 2 - Evan Callaghan and Bryce Dean

## 1. If there are outliers in the data, then the median is a better measure of central tendency than the mean. 
## The mean factors these outliers into the calculation, whereas they do not have an effect on the median. 
## If the data does not contain outliers, the mean would be a better measure of central tendency as opposed to
## the median.


## 2. A basketball team free throw percentages are: 50, 98, 25, 76, 88, 75, 80.
free = c(50, 98, 25, 76, 88, 75, 80)

## Reporting the range
summary(free)
## range = max - min
range = 98.00 - 25.00
## The range of the data is 73

## Reporting the IQR
Q3 = quantile(free, 0.75)
Q1 = quantile(free, 0.25)
IQR = Q3 - Q1
## The IQR of the data is 21.5


## 3. Considering the game results of two Premier League Teams: Which team has the higher variability in terms of game outcome?
## Manchester City --  102 total goals, 26 wins, 9 losses
## Liverpool -- 85 total goals, 32 wins, 3 losses

## Manchester City - Proportion of wins (pw) = 0.743, Proportion of losses (pl) = 0.257
entropy_man_city = -(0.743*log(0.743) + 0.257*log(0.257))

## Liverpool - Proportion of wins (pw) = 0.914, Proportion of losses (pl) = 0.0.086
entropy_liverpool = -(0.914*log(0.914) + 0.086*log(0.086))

## Manchester City (entropy = 0.57) has the higher variability in terms of game outcome compared to that of Liverpool (entropy = 0.29).


## 4. Considering the batting average from 2009 to 2015 baseball players:

## a) Creating two vectors for the batting averages of two different players
byrd = c(0.283, 0.293, 0.276, 0.210, 0.291, 0.264, 0.247)
fuld = c( 0.299, 0.143, 0.240, 0.255, 0.199, 0.239, 0.197)

## b) Reporting the average batting average of both players
mean(byrd)
mean(fuld)
## Marlon Byrds has higher average batting average (0.2662857) from 2009 to 2015 compared to Sam Fuld (0.2245714).

## c) Reporting the standard deviation of the batting average of both players
sd(byrd)
sd(fuld)
## Sam Fuld has the higher standard deviation (0.04996618) in batting average from 2009 to 2015 compared to Marlon Byrd (0.02956188).
## Therefore, Fuld has the higher variability in batting average.

## d) Reporting the coefficient of variation of the batting average of both players
cv_byrd = sd(byrd) / mean(byrd)
cv_fuld = sd(fuld) / mean(fuld)
## Sam Fuld has the higher variability in batting average (cv = 22.2%) in terms of the CV from 2009 to 2015 compared to Marlon Byrd (cv = 11.1%).

## e) Reporting the IQR of the batting average of both players
summary(byrd)
## IQR = Q3 - Q1
IQR_byrd = 0.2870 - 0.2555

summary(fuld)
IQR_fuld = 0.2475 - 0.1980

## Fuld (IQR = 0.0495) has the higher variability in batting average from 2009 to 2015 compared to Byrd (IQR = 0.0315) in terms of their IQR.
