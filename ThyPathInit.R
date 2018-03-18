dat <- data.frame(var=c("Histologic type", "Tumor margin",
                        "Maximum diameter of invasive tumor",
                        "Maximum diameter of invasive and in situ carcinoma",
                        "Nuclear grade",
                        "Histologic grade", 
                        "Lymphovascular invasion",
                        "Perineural invasion",
                        "Intraductal carcinoma component", 
                        "Proportion",
                        "Type",
                        "Nuclear grade", 
                        "Comedo type necrosis",
                        "Location",
                        "Calcification",
                        "Associated benign lesion",
                        "Nipple and areola",
                        "Paget's disease",
                        "Lactiferous duct involvement",
                        "Dermal lymphatic invasion",
                        "Resection margins",
                        "Overlying skin",
                        "Underlying fascia",
                        "node",
                        "ER",
                        "PR",
                        "HER2",
                        "p53",
                        "Ki"), val='NA')

data.all <- dat

data.all <- read.csv("PathparseRaw.csv", header=TRUE, sep=",",check.names=FALSE )

data.all[,272] <- NULL
