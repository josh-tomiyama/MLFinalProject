dat <- read.csv(file = "./data/hcc-data.txt", header=FALSE)
heading <- read.csv(file = "./data/ucc_data_heading.csv")
colnames(dat) <- heading$ï..name
summary(dat)
dat2 <- lapply(dat, 
               function(col){
                 as.numeric(ifelse(col == "?", NA, col))
                 }
               )
dat2 <- as.data.frame(dat2)
summary(dat2)
class(dat2)
saveRDS(dat2, file = "./data/hcc_data.RDS")
