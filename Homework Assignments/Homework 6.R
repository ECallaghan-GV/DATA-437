## Homework Assignment 6 - Evan Callaghan and Bryce Dean

## 6. a) Reading the csv file and create a data-frame called pitching
pitching = read.csv(file = 'Pitching.csv')
head(pitching)

## b) Creating another data-frame called career pitching that contains aggregated data at the player level. 
## That is the career pitching should contain the total strikeout, total walks, total IPouts, and the mid-year 
## career (that is, the median of the pitcher years ofcareer)

library(plyr)
career_pitching = ddply(pitching, .(playerID), summarise, total_SO = sum(SO, na.rm = T), total_Walks = sum(BB, na.rm = T), 
                        total_IPouts = sum(IPouts, na.rm = T), mid_year_career = median(yearID))
head(career_pitching)

## c) Merging the pitching and career pitching using playerID as the key variable
merged_pitching = merge(pitching, career_pitching, by = 'playerID')
head(merged_pitching)

## d) Selecting pitchers with at least 10,000 career IPouts
merged_pitching = subset(merged_pitching, total_IPouts >= 10000)

## e) Computing the ratio of total strikeouts and total walks
merged_pitching$ratio = merged_pitching$total_SO / merged_pitching$total_Walks

## f) Constructing a scatter-plot of mid-career year and the ratio of total strikeouts and total walks
plot(merged_pitching$mid_year_career, merged_pitching$ratio, type = 'p', pch = 16, xlab = 'Mid Career Year', 
        ylab = 'Ratio of Total Strikeouts and Total Walks', col = 'maroon')
grid()

## g) Building a quartic regression model in which ratio of total strikeouts and total walks is the target 
## variable and mid-career year is the predictor variable

q_md = lm(ratio ~ mid_year_career + I(mid_year_career^2) + I(mid_year_career^3) + I(mid_year_career^4),
            data = merged_pitching)


## Estimating the ratio of a pitcher with a mid-career year of 2000
summary(q_md)
newdata = data.frame('mid_year_career' = 2000)
predict(q_md, newdata, type = 'response')

## Using the model, the estimated ratio of total strikeouts and total walks of a pitcher
## with a mid-career year of 2000 is approximately 2.697. Visualizing the results:

library(ggplot2)

preds <- predict(q_md, data.frame('mid_year_career'=seq(1880, 2008, 1)))
predictions <- data.frame('mid_year_career'=seq(1880, 2008, 1), preds)

g<-ggplot(predictions, aes(x=mid_year_career, y=preds)) +
  geom_line() +
  geom_point(data=merged_pitching, mapping=aes(x=mid_year_career, y=ratio), color="maroon")
print(g)
