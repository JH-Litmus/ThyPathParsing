library(stringr)

dat <- data.frame(var=c("ID",
                        "Pathology",
                        "Histologic subtype",
                        "Maximum diameter of tumor",
                        "Tumor involvement",
                        "central",
                        "ret-central",
                        "mediastinal",
                        "ret-mediastinal",
                        "lateral",
                        "ret-lateral",
                        "total",
                        "ret-total",
                        "max size",
                        "perinodal"), val='NA',stringsAsFactors = FALSE)

df <- read.table(file = "p4.txt", fill = TRUE, sep=":", strip.white=TRUE,col.names=(1:4))
df <- data.frame(lapply(df, gsub, pattern='\xa1\xde |- |"', replacement='', ignore.case=FALSE))
names(df) = c("var","val","val2","val3")

### diagnosis: path ###

j <- grep("Thyroid gland",df$var,ignore.case=TRUE)
for (i in 1:length(j)) {
  k <- grepl("CARCINOMA",df[j[i],2])
  if (k == TRUE) {
    path <- df[j[i],2]
    path <- str_split_fixed(path, "[ ][(]", 2)[1]
  }
}


dat$val[2] <- path
for (i in (3:5)) {
  if (length(as.character(df$val[grep(dat$var[i], df$var, ignore.case = FALSE)])) == 0){
    next
  }
  dat$val[i] <- as.character(df$val[grep(dat$var[i], df$var, ignore.case = FALSE)])
}

### lymph node : lnpath.df ###

l <- grep("Lymph node",df$var)

# size, perinodal
l2 <- str_split(df$val2[9],"[ ]")

# location
ln.df <- data.frame(str_split(df[l,1],","))
colnames(ln.df) = "var"
ln.df <-data.frame(str_split_fixed(ln.df$var, "/|[(]|[)]", 4),stringsAsFactors=FALSE)

lnpatterns <- c("central|delphian|6","3|4|5","7|mediastinal")
lnlocs <- c("central","lateral","mediastinal")
lnlocs2 <-c("ret-central","ret-lateral","ret-mediastinal")
lnpath <- matrix(ncol = 2, nrow = 0)

s_lp = 0
s_lr = 0
for (i in (1:3)) {
  l <- grep(c(lnpatterns[i]),ln.df[,1],ignore.case = TRUE)
  if (length(l) != 0) {
    lp = 0
    lr = 0
    for (j in 1:length(l)) {
      lp = lp + as.numeric(ln.df[l[j],2])
      lr = lr + as.numeric(ln.df[l[j],3])
    }
    lnpath <- rbind(lnpath, c(lnlocs[i],lp))
    lnpath <- rbind(lnpath, c(lnlocs2[i],lr))
    s_lp = s_lp + lp
    s_lr = s_lr + lr
    }
  }
lnpath <- rbind(lnpath, c("total", s_lp))
lnpath <- rbind(lnpath, c("ret-total", s_lr))
lnpath.df <- data.frame(lnpath,stringsAsFactors = FALSE)
names(lnpath.df) = c("loc","no")

for (i in (6:13)) {
  if (length(grep(dat$var[i], lnpath.df$loc)) == 0) {
    next
  }
  dat$val[i] <- lnpath.df$no[grep(dat$var[i], lnpath.df$loc)]
}

# size, perinodal
if (s_lp != 0) {
  lnpath2 <- str_split(paste(df$val2[8],df$val3[8]),"r[ ]|[)][ ]|[ ]peri")
  dat$val[14] <- lnpath2[[1]][2]
  dat$val[15] <- lnpath2[[1]][3]
}

# tbd
