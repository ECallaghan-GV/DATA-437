## See Code and File Descriptions document

import pandas as pd
import numpy as np
from tqdm import tqdm
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression, Lasso, LassoCV, Ridge, RidgeCV
from sklearn.ensemble import RandomForestRegressor

def Importance(X, Y_home, Y_away):
    
    lasso_imp_data_home, lasso_imp_model_results_home = Lasso_Importance(X, Y_home)
    lasso_imp_data_away, lasso_imp_model_results_away = Lasso_Importance(X, Y_away)
    
    rf_imp_data_home, rf_imp_model_results_home = Random_Forest_Importance(X, Y_home)
    rf_imp_data_away, rf_imp_model_results_away = Random_Forest_Importance(X, Y_away)
    
    
    return lasso_imp_data_home, rf_imp_data_home, lasso_imp_model_results_home, rf_imp_model_results_home, lasso_imp_data_away, rf_imp_data_away, lasso_imp_model_results_away, rf_imp_model_results_away


def Lasso_Importance(X, Y):
    
    ####################################
    ## Variable importance from Lasso ##
    ####################################
    
    ## Defining empty list to store variable importance
    importances = []
    
    print('- LASSO Variable Importance -')
    
    for i in range(0, 100):
    
        ## Splitting the data
        X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2)

        ## Estimating the optimal lambda
        lasso_cv = LassoCV(normalize = True, cv = 5, tol = 0.1).fit(X_train, Y_train)

        ## Extracting the optimal alpha 
        cv_alpha = lasso_cv.alpha_

        ## LASSO as a variable selector
        lasso_md = Lasso(alpha = cv_alpha, normalize = True, max_iter = 10000).fit(X_train, Y_train)
        
        ## Appending the variables importances
        importances.append(lasso_md.coef_)

    ## Creating a data frame to store results
    Lasso_importances = pd.DataFrame(columns = X.columns, 
                                 data = importances)
    
    ## Taking the mean importance score of each variables
    Lasso_importances = pd.DataFrame(Lasso_importances.mean()).T
    
    ## Sorting the columns in order of most important to least
    Lasso_importances = Lasso_importances.sort_values(by = 0, axis = 1, ascending = False)
    
    ## Extracting the top 10 variables
    Lasso_importances = Lasso_importances.iloc[:, 0:10]
    
    ## Removing variables with a zero importance
    for i in range(0, 10):
        if (Lasso_importances.loc[0, Lasso_importances.columns[i]] != 0):
            new_n = i + 1
    
    Lasso_importances = Lasso_importances.iloc[:, 0:new_n]

    ## Creating the final data set to be returned
    Lasso_data = pd.DataFrame(columns = Lasso_importances.columns)
    
    ## Keeping the importance variables
    for i in range(0, new_n):
        Lasso_data.loc[:, Lasso_data.columns[i]] = X.loc[:, Lasso_data.columns[i]]
    
    Lasso_importances_results = Lasso_Models(Lasso_data, Y)
    
    Lasso_importances_results['Variable_Selector'] = 'Lasso'
    
    return Lasso_data, Lasso_importances_results


def Lasso_Models(X, Y):
    
    ## Defining list for the number of input variables to be considered
    variables = X.shape[1]
    num_variables = np.linspace(5, variables, variables - 4, dtype = int)

    ## Defining empty data frame for model results
    Lasso_importances_results = pd.DataFrame(columns = ['Linear', 'LASSO', 'Ridge'])
    
    print('- Modeling with LASSO -')

    ## Considering different number of input variables
    for i in num_variables:

        ## Changing the number of input variables
        X_input = X.iloc[:, 0:i]

        ## Defining empty lists
        lm_mse = []
        lasso_mse = []
        ridge_mse = []

        ## Repeating 100 times
        for j in range(0, 100):

            ## Splitting the data
            X_train, X_test, Y_train, Y_test = train_test_split(X_input, Y, test_size = 0.2)


            #######################
            ## Linear Regression ##
            #######################

            ## Building the model
            lm_md = LinearRegression().fit(X_train, Y_train)

            ## Predicting on the test set
            preds = lm_md.predict(X_test)

            ## Appending the Mean Square Error of the model predictions
            lm_mse.append(np.mean(np.power(preds - Y_test, 2)))


            ######################
            ## Lasso Regression ##
            ######################

            ## Estimating the optimal lambda
            lasso_cv = LassoCV(normalize = True, cv = 5, tol = 0.1).fit(X_train, Y_train)

            ## Building the model
            lasso_md = Lasso(alpha = lasso_cv.alpha_, normalize = True, max_iter = 10000).fit(X_train, Y_train)

            ## Predicting on the test set
            preds = lasso_md.predict(X_test)

            ## Appending the Mean Square Error of the model predictions
            lasso_mse.append(np.mean(np.power(preds - Y_test, 2)))


            ######################
            ## Ridge Regression ##
            ######################

            ## Estimating the optimal alpha
            ridge_cv = RidgeCV(alphas = np.linspace(0.001, 100, num = 100), cv = 5).fit(X_train, Y_train)

            ## Building the model
            ridge_md = Ridge(alpha = ridge_cv.alpha_).fit(X_train, Y_train)

            ## Predicting on the test set
            preds = ridge_md.predict(X_test)

            ## Appending the Mean Square Error of the model predictions
            ridge_mse.append(np.mean(np.power(preds - Y_test, 2)))


        ## Appending the mean error of each model to the data frame
        Lasso_importances_results.loc[i] = np.mean(lm_mse), np.mean(lasso_mse), np.mean(ridge_mse)

    Lasso_importances_results['Top_Variables'] = Lasso_importances_results.index
    Lasso_importances_results = Lasso_importances_results.reset_index(drop = True)
    
    return Lasso_importances_results


def Random_Forest_Importance(X, Y):
    
    #################################
    ## Variable importance from RF ##
    #################################
    
    ## Defining empty list to store variable importance
    importances = []
    
    print('- Random Forest Variable Importance -')
    
    for i in range(0, 100):
    
        ## Splitting the data
        X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2)

        ## Building the model
        rf_md = RandomForestRegressor(n_estimators = 500).fit(X_train, Y_train)
        
        ## Appending the variables importances
        importances.append(rf_md.feature_importances_)

    ## Creating a data frame to store results
    RF_importances = pd.DataFrame(columns = X.columns, 
                                 data = importances)
    
    ## Taking the mean importance score of each variables
    RF_importances = pd.DataFrame(RF_importances.mean()).T
    
    ## Sorting the columns in order of most important to least
    RF_importances = RF_importances.sort_values(by = 0, axis = 1, ascending = False)
    
    ## Extracting the top 10 variables
    RF_importances = RF_importances.iloc[:, 0:10]
    
    ## Removing variables with a zero importance
    for i in range(0, 10):
        if (RF_importances.loc[0, RF_importances.columns[i]] != 0):
            new_n = i + 1
    
    RF_importances = RF_importances.iloc[:, 0:new_n]

    ## Creating the final data set to be returned
    RF_data = pd.DataFrame(columns = RF_importances.columns)
    
    ## Keeping the importance variables
    for i in range(0, new_n):
        RF_data.loc[:, RF_data.columns[i]] = X.loc[:, RF_data.columns[i]]
    
    RF_importances_results = Random_Forest_Models(RF_data, Y)
    
    RF_importances_results['Variable_Selector'] = 'Random Forest'
    
    return RF_data, RF_importances_results


def Random_Forest_Models(X, Y):
    
    ## Defining list for the number of input variables to be considered
    variables = X.shape[1]
    num_variables = np.linspace(5, variables, variables - 4, dtype = int)

    ## Defining empty data frame for model results
    RF_importances_results = pd.DataFrame(columns = ['Linear', 'LASSO', 'Ridge'])
    
    print('- Modeling with Random Forest -')

    ## Considering different number of input variables
    for i in num_variables:

        ## Changing the number of input variables
        X_input = X.iloc[:, 0:i]

        ## Defining empty lists
        lm_mse = []
        lasso_mse = []
        ridge_mse = []

        ## Repeating 100 times
        for j in range(0, 100):

            ## Splitting the data
            X_train, X_test, Y_train, Y_test = train_test_split(X_input, Y, test_size = 0.2)


            #######################
            ## Linear Regression ##
            #######################

            ## Building the model
            lm_md = LinearRegression().fit(X_train, Y_train)

            ## Predicting on the test set
            preds = lm_md.predict(X_test)

            ## Appending the Mean Square Error of the model predictions
            lm_mse.append(np.mean(np.power(preds - Y_test, 2)))


            ######################
            ## Lasso Regression ##
            ######################

            ## Estimating the optimal lambda
            lasso_cv = LassoCV(normalize = True, cv = 5, tol = 0.1).fit(X_train, Y_train)

            ## Building the model
            lasso_md = Lasso(alpha = lasso_cv.alpha_, normalize = True, max_iter = 10000).fit(X_train, Y_train)

            ## Predicting on the test set
            preds = lasso_md.predict(X_test)

            ## Appending the Mean Square Error of the model predictions
            lasso_mse.append(np.mean(np.power(preds - Y_test, 2)))


            ######################
            ## Ridge Regression ##
            ######################

            ## Estimating the optimal alpha
            ridge_cv = RidgeCV(alphas = np.linspace(0.001, 100, num = 100), cv = 5).fit(X_train, Y_train)

            ## Building the model
            ridge_md = Ridge(alpha = ridge_cv.alpha_).fit(X_train, Y_train)

            ## Predicting on the test set
            preds = ridge_md.predict(X_test)

            ## Appending the Mean Square Error of the model predictions
            ridge_mse.append(np.mean(np.power(preds - Y_test, 2)))


        ## Appending the mean error of each model to the data frame
        RF_importances_results.loc[i] = np.mean(lm_mse), np.mean(lasso_mse), np.mean(ridge_mse)

    RF_importances_results['Top_Variables'] = RF_importances_results.index
    RF_importances_results = RF_importances_results.reset_index(drop = True)
    
    return RF_importances_results


def Linear_Regression(X_train, Y_train, X_test):
    
    X_test = X_test[X_train.columns.values]
    
    ## Building the model
    lm_md = LinearRegression().fit(X_train, Y_train)

    ## Predicting on the test set
    preds = lm_md.predict(X_test)
    
    ## Returning the final projections
    final_data = X_test
    final_data['Predicted_Score'] = preds
    
    return final_data['Predicted_Score']


def Lasso_Regression(X_train, Y_train, X_test):
    
    X_test = X_test[X_train.columns.values]
    
    ## Estimating the optimal lambda
    lasso_cv = LassoCV(normalize = True, cv = 5, tol = 0.1).fit(X_train, Y_train)

    ## Building the model
    lasso_md = Lasso(alpha = lasso_cv.alpha_, normalize = True, max_iter = 10000).fit(X_train, Y_train)

    ## Predicting on the test set
    preds = lasso_md.predict(X_test)
    
    ## Returning the final projections
    final_data = X_test
    final_data['Predicted_Score'] = preds
    
    return final_data['Predicted_Score']


def Ridge_Regression(X_train, Y_train, X_test):
    
    X_test = X_test[X_train.columns.values]
    
    ## Estimating the optimal alpha
    ridge_cv = RidgeCV(alphas = np.linspace(0.001, 100, num = 100), cv = 5).fit(X_train, Y_train)

    ## Building the model
    ridge_md = Ridge(alpha = ridge_cv.alpha_).fit(X_train, Y_train)

    ## Predicting on the test set
    preds = ridge_md.predict(X_test)
    
    ## Returning the final projections
    final_data = X_test
    final_data['Predicted_Score'] = preds
    
    return final_data['Predicted_Score']