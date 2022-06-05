# libraries
library(readr)
library(ggplot2)

# import cleaned data
moviesClean <- read_csv("moviesClean")

# scale budget
budget_scale <- moviesClean$budget / (10^6)

# define histogram object for budget
budg_hist <-  hist(budget_scale,
                   col = 'lightblue',
                   labels = TRUE,
                   breaks = 18,
                   main = "Frequency of Movies by Budget",
                   xlab = "Budget (Millions of USD)")

# define tick marks at bin deliniations
ticks <- numeric()
for (i in 1:length(budg_hist$breaks)){
  ticks[i] <- budg_hist$breaks[i]
}
  

# output histogram for budget
hist(budget_scale,
     col = 'lightblue',
     labels = TRUE,
     breaks = 18,
     main = "Frequency of Movies by Budget",
     xlab = "Budget (Millions of USD)",
     xaxt = "n")
axis(1, at = ticks)
abline(v = budg_hist$breaks[5],
       col = "red",
       lwd=3,
       lty = 2)
text(x=50,y=1500,"Low Budget")
text(x=50,y=1400,"88.76%")
text(x=115,y=1500,"High Budget")
text(x=115,y=1400,"11.24%")

# boxplot for budget levels high and low with year
boxplot(year ~ budget_cat, 
        data = moviesClean, 
        main = "Distribution of Year Released for High Budget and Low Budget Movies",
        xlab = 'Budget',
        ylab = 'Year Released',
        col = c('coral2', 'cornflowerblue'),
        horizontal = TRUE)
legend("left", 
       inset = 0.006,
       cex = 1.5,
       title = "Budget",
       c("> $80 million", "< $80 million"),
       fill = c('coral2', 'cornflowerblue'))

# boxplot for budget levels high and low with score
boxplot(score ~ budget_cat, 
        data = moviesClean, 
        main = "Distribution of IMDB Score for High Budget and Low Budget Movies",
        xlab = 'Budget',
        ylab = 'Score',
        col = c('coral2', 'cornflowerblue'),
        horizontal = TRUE)
legend("left", 
       inset = 0.006,
       cex = 1.5,
       title = "Budget",
       c("> $80 million", "< $80 million"),
       fill = c('coral2', 'cornflowerblue'))