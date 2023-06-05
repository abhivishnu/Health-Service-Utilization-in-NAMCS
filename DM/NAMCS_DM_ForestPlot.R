library(forestplot)
library(dplyr)
# Cochrane data from the 'rmeta'-package
cochrane_from_rmeta <- structure(list(mean  = c(NA, NA, 0.34,  0.38,  0.56,  0.60,  0.71,  0.79,  0.81,  0.83,  0.85,  0.85,  0.92,  1.00,  1.00,  1.07,  1.07,  1.16,  1.18,  1.21,  1.22,  1.30,  1.40,  1.40,  1.43,  1.51,  1.51,  1.80,  1.83,  1.94,  2.34,  NA, NA, NA), 
                                      lower = c(NA, NA, 0.17,  0.19,  0.39,  0.44,  0.49,  0.43,  0.56,  0.51,  0.41,  0.56,  0.82,  0.91,  0.24,  0.78,  0.71,  0.85,  0.72,  1.05,  0.84,  1.01,  0.96,  0.99,  0.73,  1.35,  1.23,  1.38,  1.52,  1.66,  1.77,  NA, NA, NA),
                                      upper = c(NA, NA, 0.67,  0.76,  0.80,  0.82,  1.03,  1.46,  1.16,  1.38,  1.74,  1.28,  1.04,  1.10,  4.20,  1.47,  1.61,  1.57,  1.91,  1.41,  1.78,  1.67,  2.02,  1.97,  2.82,  1.69,  1.86,  2.36,  2.20,  2.28,  3.08,  NA, NA, NA)),
                                 .Names = c("mean", "lower", "upper"), 
                                 row.names = c(NA, -11L), 
                                 class = "data.frame")

tabletext <- cbind(c("", "Service", "Mental Health Counseling", "Psychotherapy", "Pelvic Exam", "Cryotherapy", "Breast Exam", "Substance abuse counseling", "Physical Therapy", "Audiometry", "Stress management", "Rectal exam", "Skin exam", "Other Services", "Growth/Development education", "Tobacco education", "Substance abuse screening", "Wound Care", "Colonoscopy", "Neurological exam", "Injury prevention", "Depression screening", "Surable medical equipment", "Alcohol abuse screening", "Spirometry", "Retinal exam", "Electrocardiogram", "Weight reduction counseling", "Exercise counseling", "Diet/Nutrition counseling", "Foot exam", "Diabetes education", NA, NA),
                   
                   c("No DM", "(Visits)", "3858056", "3710911", "12736395", "7428436", "8985155", "3542629", "8167755", "1526110", "3488680", "7465066", "69658105", "147818327", "407503", "13647561", "6481652", "6576035", "6830948", "43252688", "5751294", "17684689", "5167512", "8175458", "3669857", "52847644", "19207196", "13851872", "29294912", "40093047", "11354601", "1414629", NA, NA),
                   
                   c("DM", "(Visits)", "657575", "720645", "3208657", "1945442", "3159014", "1270977", "3751672", "628513", "1200816", "2899438", "38897833", "79113510", "560407", "7199974", "3793420", "4802872", "4643279", "26958287", "2730939", "14208761", "3619626", "5496785", "1961703", "42564184", "13697462", "13671545", "28634163", "39594661", "13428346", "25633563", NA, NA),
                   
                   c("", "OR", "0.34", "0.38", "0.56", "0.60", "0.71", "0.79", "0.81", "0.83", "0.85", "0.85", "0.92", "1.00", "1.00", "1.07", "1.07", "1.16", "1.18", "1.21", "1.22", "1.30", "1.40", "1.40", "1.43", "1.51", "1.51", "1.80", "1.83", "1.94", "2.34", "39.69*", NA, NA))

png(file="C:\\Users\\Abhi\\Documents\\NAMCS2018\\Forest_plot.png",
    width=1200, height=800)
cochrane_from_rmeta %>% 
  forestplot(labeltext = tabletext, 
             is.summary = c(rep(TRUE, 2), rep(FALSE, 30), TRUE),
             clip = c(0.1, 2.5), 
             xlog = TRUE, 
             col = fpColors(box = "royalblue",
                            line = "darkblue",
                            summary = "royalblue"))
dev.off()

