## In-Class Assignment 3 - Evan Callaghan

## 2. a)  Using the read.csv function to read the csv data file and create a data-frame

goalie_stats = read.csv(file = 'game_goalie_stats.csv')
head(goalie_stats)

## b) Reporting the number of games of each goalie

## Loading plyr
library(plyr)


## Counting the number of games for each goalie
goalie_games = ddply(goalie_stats, .(player_id), summarise, games_played = length(unique(game_id)))
goalie_games


## c)  Creating a histogram of the goalies’ number of games

hist(goalie_games$games_played, col = 'gray', ylab = 'Frequency', xlab = 'Games Played', main = 'Histrogram of Games Played')
box()