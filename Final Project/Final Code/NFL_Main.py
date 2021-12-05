## See Code and File Descriptions document

import pandas as pd
import numpy as np
import NFL_Modeling
pd.set_option('display.max_rows', None, 'display.max_columns', None)

## Reading the cvs files and creating a data frame called nfl
nfl = pd.read_csv('final_spreadspoke_scores.csv')
nfl_2021_12 = pd.read_csv('Week_12_2021_spreadspoke_scores.csv')
nfl_2021_13 = pd.read_csv('Week_13_2021_spreadspoke_scores.csv')

## Defining the input and target variables for 2010-2020 data
X = nfl[['team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg', 'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg', 'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'spread_favorite', 'schedule_week_numeric']]
Y_home = nfl['score_home']
Y_away = nfl['score_away']

## Defining the input and target variables for Week 12 2021 data
X_test_12 = nfl_2021_12[['team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg', 'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg', 'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'spread_favorite', 'schedule_week_numeric']]
Y_test_12_home = nfl_2021_12['score_home']
Y_test_12_away = nfl_2021_12['score_away']

## Defining the input and target variables for Week 13 2021 data
X_test_13 = nfl_2021_13[['team_home_ppg', 'team_home_oppg', 'team_home_ypg', 'team_home_oypg', 'team_home_fdpg', 'team_home_ofdpg', 'team_home_tapg', 'team_home_tpg', 'team_home_pypg', 'team_home_opypg', 'team_home_asm', 'team_away_ppg', 'team_away_oppg', 'team_away_ypg', 'team_away_oypg', 'team_away_fdpg', 'team_away_ofdpg', 'team_away_tapg', 'team_away_tpg', 'team_away_pypg', 'team_away_opypg', 'team_away_asm', 'spread_favorite', 'schedule_week_numeric']]
Y_test_13_home = nfl_2021_13['score_home']
Y_test_13_away = nfl_2021_13['score_away']

## Calling the variable importance functions
df1, df2, df3, df4, df5, df6, df7, df8 = NFL_Modeling.Importance(X, Y_home, Y_away)

## Concatenating the resulting data frames and sorting by best performance
## Predicting Home Score:
Home_Performance = pd.concat([df3, df4])
Home_Performance['Performance'] = Home_Performance[['Linear', 'LASSO', 'Ridge']].min(axis = 1)
Home_Performance = Home_Performance.sort_values('Performance').reset_index(drop = True)
Home_Model = Home_Performance.loc[0]

## Predicting Away Score:
Away_Performance = pd.concat([df7, df8])
Away_Performance['Performance'] = Away_Performance[['Linear', 'LASSO', 'Ridge']].min(axis = 1)
Away_Performance = Away_Performance.sort_values('Performance').reset_index(drop = True)
Away_Model = Away_Performance.loc[0]


## Extracting the data for best home model
if (Home_Model['Variable_Selector'] == 'Lasso'):
    Home_Data = df1
else:
    Home_Data = df2
    
Home_Data = Home_Data.iloc[:, 0:Home_Model['Top_Variables']]


## Extracting the data for best away model
if (Away_Model['Variable_Selector'] == 'Lasso'):
    Away_Data = df5
else:
    Away_Data = df6
    
Away_Data = Away_Data.iloc[:, 0:Away_Model['Top_Variables']]


## Determining the best of the home models
Home_Models = pd.DataFrame(Home_Model[['Linear', 'LASSO', 'Ridge']].astype(float)).T
Home_Models = Home_Models.sort_values(by = 0, axis = 1, ascending = True)


## Determining the best of the away models
Away_Models = pd.DataFrame(Away_Model[['Linear', 'LASSO', 'Ridge']].astype(float)).T
Away_Models = Away_Models.sort_values(by = 0, axis = 1, ascending = True)


#############
## Week 12 ##
#############

## Predicting home_score on Week 12 2021 NFl data
if (Home_Models.columns[0] == 'Linear'):
    prediction_data = NFL_Modeling.Linear_Regression(Home_Data, Y_home, X_test_12)
elif (Home_Models.columns[0] == 'LASSO'):
    prediction_data = NFL_Modeling.Lasso_Regression(Home_Data, Y_home, X_test_12)
else:
    prediction_data = NFL_Modeling.Ridge_Regression(Home_Data, Y_home, X_test_12)
    
nfl_2021_12['projected_score_home'] = prediction_data.round(1)

## Predicting away_score on Week 12 2021 NFl data
if (Away_Models.columns[0] == 'Linear'):
    prediction_data = NFL_Modeling.Linear_Regression(Away_Data, Y_away, X_test_12)
elif (Away_Models.columns[0] == 'LASSO'):
    prediction_data = NFL_Modeling.Lasso_Regression(Away_Data, Y_away, X_test_12)
else:
    prediction_data = NFL_Modeling.Ridge_Regression(Away_Data, Y_away, X_test_12)
    
nfl_2021_12['projected_score_away'] = prediction_data.round(1)

## Calculating projected total points
nfl_2021_12['projected_over_under_line'] = nfl_2021_12['projected_score_home'] + nfl_2021_12['projected_score_away']

nfl_2021_12['projected_over_under'] = np.where(nfl_2021_12['projected_over_under_line'] > nfl_2021_12['over_under_line'], 'Over', 'Under')

## Calculating winning team
nfl_2021_12['projected_winner'] = np.where(nfl_2021_12['projected_score_home'] > nfl_2021_12['projected_score_away'], nfl_2021_12['team_home'], nfl_2021_12['team_away'])

## Calculating favorite team covering the spread
nfl_2021_12['projected_favorite_score'] = np.where(nfl_2021_12['team_home'] == nfl_2021_12['favorite_team'], nfl_2021_12['projected_score_home'], nfl_2021_12['projected_score_away'])

nfl_2021_12['projected_underdog_score'] = np.where(nfl_2021_12['team_home'] == nfl_2021_12['underdog_team'], nfl_2021_12['projected_score_home'], nfl_2021_12['projected_score_away'])

nfl_2021_12['projected_favorite_cover_spread'] = np.where(nfl_2021_12['projected_favorite_score'] + nfl_2021_12['spread_favorite'] > nfl_2021_12['projected_underdog_score'], 'Yes', 'No')

## Selecting the variables of interest for predictions
nfl_2021_12 = nfl_2021_12[['favorite_team', 'underdog_team', 'spread_favorite', 'projected_favorite_score', 'projected_underdog_score', 'projected_winner', 'projected_favorite_cover_spread', 'over_under_line', 'projected_over_under_line', 'projected_over_under']]

## Exporting the final results as a csv file
nfl_2021_12.to_csv('Week_12_2021_Preds.csv', index = False, header = True)


#############
## Week 13 ##
#############

## Predicting home_score on Week 13 2021 NFl data
if (Home_Models.columns[0] == 'Linear'):
    prediction_data = NFL_Modeling.Linear_Regression(Home_Data, Y_home, X_test_13)
elif (Home_Models.columns[0] == 'LASSO'):
    prediction_data = NFL_Modeling.Lasso_Regression(Home_Data, Y_home, X_test_13)
else:
    prediction_data = NFL_Modeling.Ridge_Regression(Home_Data, Y_home, X_test_13)
    
nfl_2021_13['projected_score_home'] = prediction_data.round(1)

## Predicting away_score on Week 13 2021 NFl data
if (Away_Models.columns[0] == 'Linear'):
    prediction_data = NFL_Modeling.Linear_Regression(Away_Data, Y_away, X_test_13)
elif (Away_Models.columns[0] == 'LASSO'):
    prediction_data = NFL_Modeling.Lasso_Regression(Away_Data, Y_away, X_test_13)
else:
    prediction_data = NFL_Modeling.Ridge_Regression(Away_Data, Y_away, X_test_13)
    
nfl_2021_13['projected_score_away'] = prediction_data.round(1)

## Calculating projected total points
nfl_2021_13['projected_over_under_line'] = nfl_2021_13['projected_score_home'] + nfl_2021_13['projected_score_away']

nfl_2021_13['projected_over_under'] = np.where(nfl_2021_13['projected_over_under_line'] > nfl_2021_13['over_under_line'], 'Over', 'Under')

## Calculating winning team
nfl_2021_13['projected_winner'] = np.where(nfl_2021_13['projected_score_home'] > nfl_2021_13['projected_score_away'], nfl_2021_13['team_home'], nfl_2021_13['team_away'])

## Calculating favorite team covering the spread
nfl_2021_13['projected_favorite_score'] = np.where(nfl_2021_13['team_home'] == nfl_2021_13['favorite_team'], nfl_2021_13['projected_score_home'], nfl_2021_13['projected_score_away'])

nfl_2021_13['projected_underdog_score'] = np.where(nfl_2021_13['team_home'] == nfl_2021_13['underdog_team'], nfl_2021_13['projected_score_home'], nfl_2021_13['projected_score_away'])

nfl_2021_13['projected_favorite_cover_spread'] = np.where(nfl_2021_13['projected_favorite_score'] + nfl_2021_13['spread_favorite'] > nfl_2021_13['projected_underdog_score'], 'Yes', 'No')

## Selecting the variables of interest for predictions
nfl_2021_13 = nfl_2021_13[['favorite_team', 'underdog_team', 'spread_favorite', 'projected_favorite_score', 'projected_underdog_score', 'projected_winner', 'projected_favorite_cover_spread', 'over_under_line', 'projected_over_under_line', 'projected_over_under']]

## Exporting the final results as a csv file
nfl_2021_13.to_csv('Week_13_2021_Preds.csv', index = False, header = True)