dat <- data.frame(var=c("Pathology",
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

data.all <- dat

data.all <- read.csv("PathParseRaw.csv", header=TRUE, sep=",",check.names=FALSE )

data.all[,2] <- NULL
