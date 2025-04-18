# How To Use R for Research
# 8- Descriptive statistics in R programming

install.packages(c('psych', 'Hmisc', 'janitor'))

# Call library:
library(psych)
library(Hmisc)
library(janitor)

# Read csv data:
d <- read.csv('columbus.csv')
d

# Create data frame:
dt<- data.frame(x=c(1,3,5), y=c(2,4,6))

# Clean names:
d<-d %>%
  clean_names(case = "title") # Only the first letter of names will be in capital letter
d<- clean_names(d) # to convert names to lowercase and clean them.
View(d)

#### Common descriptive functions
range(d$crime)
# 221.718  328.100

median(d$crime)
# 301.494

min(d$crime)
# 221.718

max(d$crime)
# 328.1

mean(d$evi) # evi includes the missing value (NA)
# NA
mean(d$evi, na.rm=T) # to ignore the missing (NA) values
# 0.2056042

# standard deviation
sd(dt$x)
# 2

sd(d$crime, na.rm=T)
# 21.09107

quantile(d$crime, probs=0.025)
#   2.5% 
#263.051 
quantile(d$crime, probs=0.25)
#    25% 
#293.723 

# Confidence intervals
mean(d$crime)+1.96*sd(d$crime)/sqrt(200)
# 300.9643

mean(d$crime)-1.96*sd(d$crime)/sqrt(200)
# 295.1182

#### Table () function
table(d$evi)
table(d$evi>0.3)
#FALSE  TRUE 
#36    12

tb1 <-table(d$evi)
addmargins(tb1)
prop.table(tb1)
table(d$crime>290, d$open>1.5)

#### The Chi-Square test
chisq.test(dt) # chisq.test performs chi-squared contingency table tests and goodness-of-fit tests.
#Pearson's Chi-squared test

#data:  dt
#X-squared = 0.14141, df = 2, p-value = 0.9317  # df = degrees of freedom

#Warning message:
#In stats::chisq.test(x, y, ...) :
#  Chi-squared approximation may be incorrect

# the total Chi-square statistic is 0.14141
# In our example, the row and the column variables are not significantly associated (p-value > 0.05).

#### Describe
psych::describe(dt) #using describe from psych package
#vars n mean sd median trimmed  mad min max range skew
#x    1 3    3  2      3       3 2.97   1   5     4    0
#y    2 3    4  2      4       4 2.97   2   6     4    0
#kurtosis   se
#x    -2.33 1.15
#y    -2.33 1.15

Hmisc::describe(dt) # using describe from Hmisc package

#dt
#2  Variables      3  Observations
#---------------------------------------------------------------
#  x 
#n  missing distinct     Info     Mean      Gmd 
#3        0        3        1        3    2.667 

#Value          1     3     5
#Frequency      1     1     1
#Proportion 0.333 0.333 0.333
#---------------------------------------------------------------
#  y 
#n  missing distinct     Info     Mean      Gmd 
#3        0        3        1        4    2.667 

#Value          2     4     6
#Frequency      1     1     1
#Proportion 0.333 0.333 0.333
#---------------------------------------------------------------

#### Using tapply () function for calculating descriptive statistics
tapply(d$crime, d$open, mean)
tapply( d$crime, list( d$open, d$evi < 0.3), mean, na.rm=T )
