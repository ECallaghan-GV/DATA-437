## In-Class Assignmemt 11 - Evan Callaghan

## 2. a) Using the read.csv function to read the csv file and create a data-frame called mlb
mlb = read.csv(file = 'Dataset_2_4.csv')
head(mlb)

## b) Creating a scatter-plot between Hits and Runs

plot(mlb$H, mlb$R, xlab = 'Hits', ylab = 'Runs', pch = 16)
grid()

## The scatterplot shows a positive, linear relationship between the number of hits and the number of runs scored.

## c)  Computing the correlation between Hits and Runs

r = cor(mlb$H, mlb$R)
n = dim(mlb)[1]

moe = 2 * sqrt((1 - r^2) / n)

## The correlation coefficient between hits and runs is 0.643. The calculated margin or error is 0.127.
## SInce |r| is greater than the margin of error, we know that the relationship is statistically significant.