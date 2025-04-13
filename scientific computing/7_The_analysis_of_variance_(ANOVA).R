# How To Use R for Research
# 10- The analysis of variance (ANOVA)

# Create some data
group <- rep(c('A1','A2', 'A3'), times=4)
value <- runif(12, 10, 20)
df1 <- data.frame(group, value)
df1

group <- rep(c('A1','A2', 'A3'), times=4)
value <- runif(12, 10, 20)
year <- as.factor(c(rep("2010",6), rep("2020",6)))
df2 <- data.frame(value,group,year) 
df2

# Visualize data:
library(ggplot2)
ggplot(df1, aes(x = group, y = value)) +
  geom_boxplot()

#### One way ANOVA
# It uses to examine statistically significant differences between two samples means.

df1.anova <- aov(value ~ group, data=df1) # ~: tilde symbol
df1.anova
summary(df1.anova)

# extract the p-value and F value
summary(df1.anova)[[1]][1,4:5]

#### Interpret the result:
#P-value ??? ?? (alpha): The differences between some of the means are statistically significant.

#P-value > ??: The differences between the means are not statistically significant.

# p-value of df1 = 0.9358 > 0.05, so we can not reject the null hypothesis (means are equal) and conclude that means are equal.

#### Two way ANOVA
# A two-way ANOVA, has two independents. The style of two way ANOVA is:
  
#  aov(dependent~as.factor(independent1)*as.factor(indepndent2),data= filename)

df2.anova <- aov(value ~ group*year, data=df2)
summary(df2.anova)

# extract the p-value and F value:
summary(df2.anova)[[1]][1,4:5]
summary(df2.anova)[[1]][2,4:5]
summary(df2.anova)[[1]][3,4:5]


#### Analysis of covariance
df2.anova <- aov(value ~ group+year, data=df2)
summary(df2.anova)

# extract the p-value and F value:
summary(df2.anova)[[1]][1,4:5]


TukeyHSD(df1.anova) #Tukey Honest Significant Differences
TukeyHSD(df2.anova)

