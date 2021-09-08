## In-Class Assignment 4 - Evan Callaghan

## 2. a) Reading the csv file

goalie_stats = read.csv(file = 'game_goalie_stats.csv')
head(goalie_stats)


## b)  Reporting the number of games of each goalie

library(plyr)

goalie_games = ddply(goalie_stats, .(player_id), summarise, games_played = length(unique(game_id)))
head(goalie_games)

## c) Reporting the IQR of the number of games of each goalie

## Summary statistics:
summary(goalie_games)

IQR = 144 - 5
IQR

## The IQR of the number of games of each goalie is 139 games
