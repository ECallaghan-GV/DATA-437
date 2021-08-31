## In-Class Assignment 2 - Evan Callaghan

## 1) Reading the csv data file.
goalie_stats = read.csv(file = 'game_goalie_stats.csv')

## 2) Printing the first and last four observations of the data set.
head(goalie_stats, 4)
tail(goalie_stats, 4)

## 3) Reporting the number of team IDs.
length(unique(goalie_stats$team_id))

## There are 32 teams in the dataset

## 4) Reporting the number of goalies with savePercentage > 95% in winning plays
goalie_95w = subset(goalie_stats, decision == 'W' & savePercentage > 95)
dim(goalie_95w)

## There are 3357 goalies with a save percentage greater than 95% in a winning game.