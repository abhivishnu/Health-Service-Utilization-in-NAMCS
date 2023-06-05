library(forestplot)
library(dplyr)
# Cochrane data from the 'rmeta'-package
cochrane_from_rmeta <- structure(list(mean  = c(NA, NA,NA, 0.00, 0.34, 0.37, 0.46, 0.53, 0.54, 0.74, 0.78, 0.93, 0.93, 0.98, 0.99, 1.29, 1.29, 1.33, 1.35, 1.44, 2.22, 7.26, 1.64,  NA, NA), 
                                      lower = c(NA, NA,NA, 0.00, 0.16, 0.19, 0.26, 0.28, 0.24, 0.56, 0.62, 0.63, 0.49, 0.73, 0.45, 0.21, 0.30, 0.65, 0.91, 0.23, 1.62, 0.77, 1.46,  NA, NA),
                                      upper = c(NA, NA,NA, 0.00, 0.74, 0.75, 0.82, 0.99, 1.20, 0.98, 0.99, 1.37, 1.80, 1.33, 2.19, 8.03, 5.60, 2.71, 2.01, 9.12, 3.05, 68.30, 1.83, NA, NA)),
                                 .Names = c("mean", "lower", "upper"), 
                                 row.names = c(NA, -24L), 
                                 class = "data.frame")

tabletext <- cbind(c("","","", "SIGMOIDOSCOPY", "MENTAL", "PHYSCOTHERAPY", "PHYSIOTHERAPY", "DME", "STRESS MGT.", "EXERCISE", "DIET & NUTR", "TOBAC ED.", "COLONOSCOPY", "DEPRESSION SCREENING", "HOME HEALTHCARE", "GENETIC COUNSELING", "OCCUPATION THERAPY", "BONE DENSITY SCREEN", "MAMMOGRAM", "COMP. & ALTER. MEDICINE", "BREAST SCREEN", "RADIOTHERAPY", "ANY SERVICE", NA, NA),
                   c("","", "OR", "0.00", "0.34", "0.37", "0.46", "0.53", "0.54", "0.74", "0.78", "0.93", "0.93", "0.98", "0.99", "1.29", "1.29", "1.33", "1.35", "1.44", "2.22", "7.26", "1.64", NA, NA))

png(file="C:\\Users\\Abhi\\Documents\\NAMCS2018\\Forest_plot_CA_Updated.png",
    width=1200, height=800)
cochrane_from_rmeta %>% 
  forestplot(labeltext = tabletext, 
             is.summary = c(rep(TRUE, 2), rep(FALSE, 22), TRUE),
             clip = c(0.1, 2.5), 
             xlog = TRUE, 
             col = fpColors(box = "royalblue",
                            line = "darkblue",
                            summary = "royalblue"))
dev.off()

