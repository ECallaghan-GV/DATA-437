## In-Class Assignment 9 - Evan Callaghan

## 2. a) Usinging the read.csv function to read both csv files and create two data-frames
durant = read.csv('Durant_2011_2012.csv')
james = read.csv('James_2011_2012.csv')

## b) Reporting the average number of assists for both player in the 2011-2012 NBA season
mean(durant$AST)
mean(james$AST)

## Lebron James has the higher average number of assists.

## c) Reporting the margin of error the average number of assists estimation of both players

(2 * sd(durant$AST)) / sqrt(dim(durant)[1])
(2 * sd(james$AST)) / sqrt(dim(james)[1])

## Lebron James has the higher margin or error, indicating a higher level of uncertainty in the number of assists per game.