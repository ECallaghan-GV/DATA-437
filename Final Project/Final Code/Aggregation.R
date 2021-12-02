## Web-Scraping

library(tidyverse)
library(rvest)

## Reading the cleaned data set
scores = read.csv(file = 'cleaned_spreadspoke_scores.csv')

## 2020 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2020)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg_2020 = table[, c('Team', 'X2020')]
names(ppg_2020) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg_2020 = table[, c('Team', 'X2020')]
names(ypg_2020) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg_2020 = table[, c('Team', 'X2020')]
names(tpg_2020) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg_2020 = table[, c('Team', 'X2020')]
names(pypg_2020) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg_2020 = table[, c('Team', 'X2020')]
names(opypg_2020) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg_2020 = table[, c('Team', 'X2020')]
names(oppg_2020) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg_2020 = table[, c('Team', 'X2020')]
names(oypg_2020) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg_2020 = table[, c('Team', 'X2020')]
names(tapg_2020) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm_2020 = table[, c('Team', 'X2020')]
names(asm_2020) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg_2020 = table[, c('Team', 'X2020')]
names(fdpg_2020) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2021-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg_2020 = table[, c('Team', 'X2020')]
names(ofdpg_2020) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg_2020 %>% left_join(oppg_2020) %>% left_join(ypg_2020) %>% left_join(oypg_2020) %>% left_join(fdpg_2020) %>% 
  left_join(ofdpg_2020) %>% left_join(tapg_2020) %>% left_join(tpg_2020) %>% left_join(pypg_2020) %>% left_join(opypg_2020) %>%
  left_join(asm_2020) %>% mutate(schedule_season = 2020)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2020 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)



## 2019 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2019)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2019')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2019')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2019')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2019')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2019')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2019')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2019')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2019')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2019')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2019')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2020-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2019')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2019)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2019 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)















## 2018 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2018)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2018')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2018')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2018')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2018')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2018')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2018')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2018')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2018')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2018')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2018')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2019-02-04')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2018')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2018)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2018 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2017 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2017)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2017')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2017')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2017')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2017')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2017')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2017')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2017')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2017')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2017')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2017')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2018-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2017')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2017)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2017 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2016 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2016)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2016')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2016')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2016')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2016')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2016')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2016')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2016')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2016')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2016')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2016')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2017-02-06')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2016')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2016)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2016 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2015 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2015)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2015')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2015')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2015')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2015')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2015')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2015')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2015')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2015')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2015')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2015')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2016-02-08')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2015')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2015)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2015 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2014 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2014)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2014')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2014')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2014')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2014')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2014')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2014')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2014')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2014')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2014')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2014')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2015-02-01')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2014')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2014)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2014 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2013 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2013)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2013')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2013')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2013')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2013')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2013')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2013')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2013')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2013')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2013')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2013')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2014-02-02')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2013')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2013)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2013 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2012 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2012)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2012')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2012')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2012')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2012')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2012')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2012')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2012')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2012')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2012')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2012')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2013-02-03')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2012')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2012)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2012 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2011 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2011)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2011')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2011')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2011')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2011')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2011')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2011')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2011')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2011')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2011')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2011')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2012-02-05')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2011')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2011)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2011 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## 2010 ------------------------------------------------------------------------------------

score = scores %>% filter(schedule_season == 2010)

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg = table[, c('Team', 'X2010')]
names(ppg) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg = table[, c('Team', 'X2010')]
names(ypg) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg = table[, c('Team', 'X2010')]
names(tpg) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg = table[, c('Team', 'X2010')]
names(pypg) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg = table[, c('Team', 'X2010')]
names(opypg) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg = table[, c('Team', 'X2010')]
names(oppg) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg = table[, c('Team', 'X2010')]
names(oypg) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg = table[, c('Team', 'X2010')]
names(tapg) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm = table[, c('Team', 'X2010')]
names(asm) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg = table[, c('Team', 'X2010')]
names(fdpg) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game?date=2011-02-07')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg = table[, c('Team', 'X2010')]
names(ofdpg) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg %>% left_join(oppg) %>% left_join(ypg) %>% left_join(oypg) %>% left_join(fdpg) %>% 
  left_join(ofdpg) %>% left_join(tapg) %>% left_join(tpg) %>% left_join(pypg) %>% left_join(opypg) %>%
  left_join(asm) %>% mutate(schedule_season = 2010)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
data_2010 = score %>% left_join(team_stats_home) %>% left_join(team_stats_away)


##------------------------------------------------

## Concatenating the data from 2010-2020 together into one data frame to be exported
aggregated_cleaned_spreadspoke_scores = data_2010 %>% bind_rows(data_2011) %>% bind_rows(data_2012) %>% bind_rows(data_2013) %>% bind_rows(data_2014) %>% bind_rows(data_2015) %>% bind_rows(data_2016) %>% bind_rows(data_2017) %>%
  bind_rows(data_2018) %>% bind_rows(data_2019) %>% bind_rows(data_2020)

## Exporting output_data as a new csv file
write.csv(aggregated_cleaned_spreadspoke_scores,"aggregated_cleaned_spreadspoke_scores.csv", row.names = FALSE)



