setwd("~/Google 드라이브/2017 KSNM CTN/ThyPathParsing")
library(stringr)

dat <- data.frame(var=c("Histologic subtype",
                        "Maximum diameter of tumor",
                        "Tumor involvement",
                        "Lymph node"), val='NA')

df <- read.delim("clipboard",header=FALSE,sep=",",strip.white=TRUE)
unstack(df)
names(df) <-c("var", "val")
df <- data.frame(lapply(df, gsub, pattern='\xa1\xde |- |"', replacement='', ignore.case=FALSE))
df <- data.frame(lapply(df, gsub, pattern='CARCINOMA', replacement='carcinoma', ignore.case=FALSE))
df <- data.frame(lapply(df, gsub, pattern='P63', replacement='p63', ignore.case=FALSE))
df <- data.frame(lapply(df, gsub, pattern='E-Cad', replacement='E-cad', ignore.case=FALSE))

valout <- str_split_fixed(df$val, "Lymph |in[ ]tumor |of[ ]the[ ]tumor |[(]0|[(]All|[(]1|[(]2|[(]3", 2)
varout <- str_split_fixed(df$var, "[,]", 2)
df <- data.frame(varout[,1], valout[,1])

dat$val <- as.character(dat$val)

for (i in (1:32)) {
  if (length(as.character(df$val[grep(dat$var[i], df$var, ignore.case = FALSE)])) == 0){
    next
  }
  dat$val[i] <- as.character(df$val[grep(dat$var[i], df$var, ignore.case = FALSE)])
}

k <- grep("HER2", df$var, ignore.case = FALSE)
if (length(k) > 0) {
  k <- k-1
  dat$val[26] <- as.character(df$val[k])
  k <- k-1
  dat$val[25] <- as.character(df$val[k])
} else {
  dat$val[25] <- "NA"
  dat$val[26] <- "NA"
} 

j <- as.character(df$var[1])
data.all <- cbind(data.all, dat$val)

# colnames(dat)[2] <- j
colnames(data.all)[length(data.all)] <- j

write.csv(data.all, file="PathparseRaw.csv")





