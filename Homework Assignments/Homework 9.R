## Homework Assignment 9 - Bryce Dean & Evan Callaghan

## 2. a) Using the read.csv function to read the csv file and create a data-frame called teams
teams = read.csv(file = 'Teams.csv')


## b) Using the 19th century data to estimate k (from the exponential Pythagorean model), and then 
## estimating the winning percentage using the estimated value of k, R and RA as the predictor variables

## Selecting the variables of interest
my_teams = teams[, c('yearID', 'teamID', 'G', 'W', 'L', 'R', 'RA')]

## Subsetting the data for 19th century data
team_19th = subset(my_teams, yearID < 1900)
team_19th = subset(team_19th, L > 0)  # (We need to remove these observations because they result in
team_19th = subset(team_19th, W > 0)  # NAs in the ratio computations)

## Computing the ratios
team_19th$Wpct = team_19th$W / (team_19th$W + team_19th$L)
team_19th$log_W_L = log(team_19th$W / team_19th$L)
team_19th$log_R_RA = log(team_19th$R / team_19th$RA)

## Estimating k 
lm_pyt = lm(log_W_L ~ 0 + log_R_RA, data = team_19th)

## Extracting model results
summary(lm_pyt)

## Estimated coefficient = 1.91377

## Estimating the winning percentage using the estimated value of k, R and RA as the predictor variables
team_19th$Wpct_pyt = team_19th$R^1.91377 / (team_19th$R^1.91377 + team_19th$RA^1.91377)


## c) Computing the residuals; that is, the difference between the winning percentage and the estimated 
## winning percentage using the Pythagorean formula
team_19th$Residual = team_19th$Wpct - team_19th$Wpct_pyt

## Reporting the team with the largest residual
tail(team_19th[order(team_19th$Residual), ], 1)

## FW1 in 1871 is the team with the largest residual value. They were expected to win 25% of games
## and actually won 37%.

## Reporting the team with the smallest residual
head(team_19th[order(team_19th$Residual), ], 1)

## RC1 in 1871 is the team with the smallest residual value. They were expected to win 40% of games
## and actually won 16%.

