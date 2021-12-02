## Code for aggregating 2021 NFL data 
library(tidyverse)
library(rvest)

## All statistics available at https://www.teamrankings.com/nfl/team-stats/ 

## Reading the csv files
nfl12 = read.csv(file = '2021_NFL_Data_Week_12.csv')
nfl13 = read.csv(file = '2021_NFL_Data_Week_13.csv')
name_home = read.csv(file = 'team_id.csv')
name_away = read.csv(file = 'team_id_away.csv')

## Removing unnecessary variables 
name_home = name_home[, c('team_home', 'team_home_name')]
name_away = name_away[, c('team_away', 'team_away_name')]

## Merging the data frames 
nfl12 = merge(nfl12, name_home, by = 'team_home')
nfl12 = merge(nfl12, name_away, by = 'team_away')

nfl13 = merge(nfl13, name_home, by = 'team_home')
nfl13 = merge(nfl13, name_away, by = 'team_away')


## Reordering the variables
nfl12 = nfl12[, c('schedule_date', 'schedule_season', 'schedule_week_numeric', 'team_home', 'team_home_name', 'team_away', 'team_away_name',
              'score_home', 'score_away', 'over_under_line', 'real_over_under_line', 'over_under', 'favorite_team', 
              'favorite_team_score', 'underdog_team', 'underdog_team_score', 'spread_favorite', 'favorite_team_win', 
              'favorite_team_cover')]

nfl13 = nfl13[, c('schedule_date', 'schedule_season', 'schedule_week_numeric', 'team_home', 'team_home_name', 'team_away', 'team_away_name',
                  'score_home', 'score_away', 'over_under_line', 'real_over_under_line', 'over_under', 'favorite_team', 
                  'favorite_team_score', 'underdog_team', 'underdog_team_score', 'spread_favorite', 'favorite_team_win', 
                  'favorite_team_cover')]

## Web-Scraping tables for variables:
## ----------------------------------------------

## Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/points-per-game?date=2021-11-11')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ppg_2021 = table[, c('Team', 'X2021')]
names(ppg_2021) = c('Team', 'ppg')


## Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/yards-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ypg_2021 = table[, c('Team', 'X2021')]
names(ypg_2021) = c('Team', 'ypg')

## Turnovers per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/giveaways-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tpg_2021 = table[, c('Team', 'X2021')]
names(tpg_2021) = c('Team', 'tpg')

## Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/penalty-yards-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
pypg_2021 = table[, c('Team', 'X2021')]
names(pypg_2021) = c('Team', 'pypg')

## Opponent Penalty Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-penalty-yards-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
opypg_2021 = table[, c('Team', 'X2021')]
names(opypg_2021) = c('Team', 'opypg')

## Opponent Points per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-points-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oppg_2021 = table[, c('Team', 'X2021')]
names(oppg_2021) = c('Team', 'oppg')

## Opponent Yards per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-yards-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
oypg_2021 = table[, c('Team', 'X2021')]
names(oypg_2021) = c('Team', 'oypg')

## Takeaways per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/takeaways-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
tapg_2021 = table[, c('Team', 'X2021')]
names(tapg_2021) = c('Team', 'tapg')

## Average Scoring Margin
webpage = read_html('https://www.teamrankings.com/nfl/stat/average-scoring-margin')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
asm_2021 = table[, c('Team', 'X2021')]
names(asm_2021) = c('Team', 'asm')

## First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/first-downs-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
fdpg_2021 = table[, c('Team', 'X2021')]
names(fdpg_2021) = c('Team', 'fdpg')

## Opponent First Downs per Game
webpage = read_html('https://www.teamrankings.com/nfl/stat/opponent-first-downs-per-game')
table = html_nodes(webpage, 'table')
table = html_table(table, fill = T)
table = as.data.frame(table)
ofdpg_2021 = table[, c('Team', 'X2021')]
names(ofdpg_2021) = c('Team', 'ofdpg')

## Joining all of the tables into a home and away data frame
team_stats_home = ppg_2021 %>% left_join(oppg_2021) %>% left_join(ypg_2021) %>% left_join(oypg_2021) %>% left_join(fdpg_2021) %>% 
  left_join(ofdpg_2021) %>% left_join(tapg_2021) %>% left_join(tpg_2021) %>% left_join(pypg_2021) %>% left_join(opypg_2021) %>%
  left_join(asm_2021) %>% mutate(schedule_season = 2021)

team_stats_away = team_stats_home

## Changing the variable names
colnames(team_stats_home) <- c('team_home_name', 'team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg',
                               'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'schedule_season')

colnames(team_stats_away) <- c('team_away_name', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg',
                               'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'schedule_season')


## Automatically joins by team_home_name and schedule_season
nfl12 = nfl12 %>% left_join(team_stats_home) %>% left_join(team_stats_away)
nfl13 = nfl13 %>% left_join(team_stats_home) %>% left_join(team_stats_away)

## Reordering the variables
nfl12 = nfl12[, c('schedule_date', 'schedule_season', 'schedule_week_numeric', 'team_home', 'score_home', 'team_away','score_away', 'team_home_ppg', 
              'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg','team_home_tapg', 'team_home_tpg', 
              'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 
              'team_away_fdpg', 'team_away_ofdpg', 'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm',
              'over_under_line', 'real_over_under_line', 'over_under', 'favorite_team', 'favorite_team_score', 'underdog_team', 
              'underdog_team_score', 'spread_favorite', 'favorite_team_win', 'favorite_team_cover')]

nfl13 = nfl13[, c('schedule_date', 'schedule_season', 'schedule_week_numeric', 'team_home', 'score_home', 'team_away','score_away', 'team_home_ppg', 
                  'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg','team_home_tapg', 'team_home_tpg', 
                  'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 
                  'team_away_fdpg', 'team_away_ofdpg', 'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm',
                  'over_under_line', 'real_over_under_line', 'over_under', 'favorite_team', 'favorite_team_score', 'underdog_team', 
                  'underdog_team_score', 'spread_favorite', 'favorite_team_win', 'favorite_team_cover')]

## Exporting output_data as a new csv file
# write.csv(nfl,"2021_spreadspoke_scores.csv", row.names = FALSE)
write.csv(nfl12,"Week_12_2021_spreadspoke_scores.csv", row.names = FALSE)
write.csv(nfl13,"Week_13_2021_spreadspoke_scores.csv", row.names = FALSE)
