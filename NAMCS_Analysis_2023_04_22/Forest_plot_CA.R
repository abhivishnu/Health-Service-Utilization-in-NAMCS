library(forestplot)
library(dplyr)

dataset_for_forestplot <- structure(list(mean  = c(NA, NA,NA, 0.20, 0.30, 0.41, 0.43, 0.48, 0.59, 0.64, 0.65, 0.66, 0.91, 0.95, 1.00, 1.12, 1.14, 1.20, 1.24, 1.26, 1.37, 1.66,1.92,2.60,0.72,  NA, NA), 
                                      lower = c(NA, NA,NA,  0.03, 0.14, 0.24, 0.23, 0.27, 0.24, 0.52, 0.50, 0.32, 0.46, 0.73, 0.56, 0.74, 0.24, 0.83, 0.82, 0.68, 0.38,1.17,0.83, 0.53,0.63,  NA, NA),
                                      upper = c(NA, NA,NA,  1.53, 0.61, 0.70, 0.83, 0.85, 1.50, 0.79, 0.83, 1.37, 1.80, 1.24, 1.77, 1.71, 5.29, 1.73, 1.87, 2.32, 4.94, 2.34, 4.44, 12.72,0.82, NA, NA)),
                                 .Names = c("mean", "lower", "upper"), 
                                 row.names = c(NA, -24L), 
                                 class = "data.frame")

tabletext <- cbind(c("","","", "HIV TEST", "MENTAL HLTH COUNSELING", "PHYSIOTHERAPY","PSYCHOTHERAPY", "DURABLE MEDICAL EQUIPMENT","HEPATITIS TEST","DIET & NUTRITION","EXERCISE COUNSELING","STRESS MANAGEMENT","HOME HEALTH CARE","DEPRESSION SCREEN","COLONOSCOPY","CERVICAL CA SCREEN", "COMP. & ALTER. MEDICINE", "ALCOHOL SCREEN","SUBSTANCE ABUSE SCREEN","BONE DENSITY SCREEN", "OCCUPATION THERAPY","MAMMOGRAM",  "DOMESTIC VIOLENCE SCREEN","GENETIC COUNSELING", "ANY SERVICE", NA, NA),
                   c("","", "OR", "0.20", "0.30", "0.41", "0.43", "0.48", "0.59", "0.64", "0.65", "0.66", "0.91", "0.95", "1.00", "1.12", "1.14", "1.20", "1.24", "1.26", "1.37", "1.66", "1.92","2.60","0.72", NA, NA))

png(file="C:\\Users\\abhiv\\Documents\\NAMCS_Analysis_2023_04_22\\Forest_plot_CA_2023_04_22.png",
    width=1200, height=800)

dataset_for_forestplot %>% 
  forestplot(labeltext = tabletext, 
             is.summary = c(rep(TRUE, 2), rep(FALSE, 22), TRUE),
             clip = c(0.1, 5), 
             xlog = TRUE, 
             ticks = c(0.2, 0.5, 0.75, 1, 2, 3),
             txt_gp = fpTxtGp(ticks=gpar(cex=1)),
             col = fpColors(box = "royalblue",
                            line = "darkblue",
                            summary = "royalblue"))
dev.off()

