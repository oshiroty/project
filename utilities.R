setwd("E:/Users/Tyler/Documents/_MATH_480A/")
Batting <- read.csv("Batting.csv", header=TRUE)
Teams <- read.csv("Teams.csv", header=TRUE)
batting <- as.matrix(cbind(Batting, cbind(rep(0, dim(Batting)[1]), rep(0, dim(Batting)[1]))))
teams <- as.matrix(Teams)

for (i in 1:dim(batting)[1]) {
  for (j in 1:dim(teams)[1]) {
    if (batting[i, 2] == teams[j, 1] && batting[i, 4] == teams[j, 3]) {
      # Matching year and team
      batting[i, 25] = teams[j, 9]
      batting[i, 26] = as.integer(teams[j, 9]) / (as.integer(teams[j, 9]) + as.integer(teams[j, 10]))
      break
    }
  }

}

temp <- batting[,-1:-5]
temp[is.na(temp)] <- 0
write.table(temp, "data.txt", row.names=FALSE)

t <- read.table("data.txt", header=TRUE)
t <- t[,-19]


write.csv(batting, "bat.csv")