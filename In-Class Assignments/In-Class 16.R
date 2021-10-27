## In-Class Assignment 16 - Evan Callaghan

## 2. a) Reading the csv file and create a data-frame called nba

nba = read.csv(file = 'NBA_2006_2007.csv')
head(nba)

## b) Building a linear regression model with the four factors for team offense
lm_md = lm(W ~ EFG_pct + TOV_pct + OREB_pct + FTA_rate, data = nba)

## c) Estimating the wins of NBA team in 2006-2007 season with EFG pct = 51%, TOV pct = 16%, 
## OREB pct = 32%, and FTA rate = 35%

newdata = data.frame('EFG_pct' = 51, 'TOV_pct' = 16, 'OREB_pct' = 32, 'FTA_rate' = 0.35)
predict(lm_md, newdata, type = 'response')

## The estimated number of wins is 51.15.

## d) ## Extracting model results
summary(lm_md)

## Not all of the variables in the model are significant. Since the margin or error magnitude 
## of the FTA_rate variable is larger than the estimated slope, this variable is not significant.
## Each of the other variables is significant.
