require(dplyr)
require(ggplot2)
require(GGally)
require(lmtest)
require(car)

# ----
movies_original <- read.csv("movies.csv")
dim(movies_original)

# Remove rows containing NA
movies <- movies_original[rowSums(is.na(movies_original)) == 0,]

# Create "month" using "released"
# A factor 1:12, indicating month of release
month <- numeric()

for (i in 1:length(movies$released)){
  if (grepl("January", movies$released[i])){
    month[i] <- 1
  }else if (grepl("February", movies$released[i])){
    month[i] <- 2
  }else if (grepl("March", movies$released[i])){
    month[i] <- 3
  }else if (grepl("April", movies$released[i])){
    month[i] <- 4
  }else if (grepl("May", movies$released[i])){
    month[i] <- 5
  }else if (grepl("June", movies$released[i])){
    month[i] <- 6
  }else if (grepl("July", movies$released[i])){
    month[i] <- 7
  }else if (grepl("August", movies$released[i])){
    month[i] <- 8
  }else if (grepl("September", movies$released[i])){
    month[i] <- 9
  }else if (grepl("October", movies$released[i])){
    month[i] <- 10
  }else if (grepl("November", movies$released[i])){
    month[i] <- 11
  }else{
    month[i] <- 12
  }
}

movies <- cbind(movies, month)
movies$month <- as.factor(movies$month)

# Here we can see almost 80% of the movies are from the US
# Considering IMDb is a US-based database, isolate to the US only
# sum(movies$country == "United States")/dim(movies)[1]
movies <- movies[movies$country == "United States",]
movies <- movies[-c(8,9,10,11,14)]
rownames(movies) <- 1:nrow(movies)

# Reorganize columns
organized <- c("name", "rating", "runtime", "genre", "month", "year", "votes", "score", "budget", "gross")
movies <- movies[, organized]

return_prop <-  movies$gross / movies$budget
movies <- cbind(movies, return_prop)

# ----
