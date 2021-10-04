## Homework Assignment 4 - Evan Callaghan and Bryce Dean

## 4. Lionel Messi is one of the most popular athletes in the world. Suppose that the number of goals that Messi scored during his time in Barcelona per 
## game follows a normal distribution with a mean of 1.5 goals and a standard deviation of 1 goal. Let X denote the number of goals that Messi scores in 
## a game. In R, answer the following:

## a) Write the distribution of X

## X ~ N(mu, sigma), mu = 1.5, sigma = 1
## X ~ N(1.5, 1)

## b) Find the probability that Messi scores more than 2 goals in a game

1 - pnorm(2, 1.5, 1)
## The probability that Messi scores more than 2 goals in a game is 0.309

## c) Find the probability that Messi scores less than 1 goal in a game

pnorm(1, 1.5, 1)
## The probability that Messi scores less than 1 goal in a game is 0.309

## d) Find the probability that Messi scores more than 3 goals in a game

1 - pnorm(3, 1.5, 1)
## The probability that Messi scores more than 3 goals in a game is 0.067