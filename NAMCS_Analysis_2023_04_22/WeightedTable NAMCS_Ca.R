#source("C:\\Users\\abhiv\\Documents\\NAMCS_Analysis_2023_04_22\\customtab.R")
#source("C:\\Users\\abhiv\\Documents\\NAMCS_Analysis_2023_04_22\\NAMCS_import.R")


variables <- c('SEX','RACERETH', 'PAYTYPER',
               'CANCER','MAMMO','COLON','MENTAL','PT','PSYCHOTH','CervicalCaScreen','DEPRESS','SKIN','DIETNUTR','EXERCISE','STRESMGT',
               'OCCUPY','GENETIC','DME','HOMEHLTH','BONEDENS','CAM','HEPTEST','SUBST','ETOH','HIVTEST','DVS','AnyService_0_1',
               'CSTRATM','CPSUM', 'PATWT')


d201618_table1 <- comb201618_namcs_cat %>% select(all_of(variables)) 

d201618_table2 <- d201618_table1 %>% mutate(SEX = as_factor(SEX),
                                           RACERETH = as_factor(RACERETH),
                                           CANCER = as_factor(CANCER),
                                           PAYTYPER = as_factor(PAYTYPER),
                                           COLON = as_factor(COLON),
                                           MAMMO = as_factor(MAMMO),
                                           PT = as_factor(PT),
                                           DIETNUTR = as_factor(DIETNUTR),
                                           EXERCISE = as_factor(EXERCISE),
                                           SKIN = as_factor(SKIN),
                                           CervicalCaScreen = as_factor(CervicalCaScreen),
                                           DEPRESS = as_factor(DEPRESS),
                                           MENTAL = as_factor(MENTAL),
                                           PSYCHOTH = as_factor(PSYCHOTH),
                                           STRESMGT = as_factor(STRESMGT),
                                           OCCUPY = as_factor(OCCUPY),
                                           GENETIC = as_factor(GENETIC),
                                           DME = as_factor(DME),
                                           HOMEHLTH = as_factor(HOMEHLTH),
                                           BONEDENS = as_factor(BONEDENS),
                                           CAM = as_factor(CAM),
                                           HEPTEST = as_factor(HEPTEST),
                                           SUBST = as_factor(SUBST),
                                           HIVTEST = as_factor(HIVTEST),
                                           DVS = as_factor(DVS),
                                           AnyService_0_1 = as_factor(AnyService_0_1)
)


d201618_table2$SEX <- d201618_table2$SEX %>%
  fct_recode(Male = '2', Female = '1')

#d201618_table2$AGEgt65 <- ifelse(d201618_table2$AGE > 65, "Yes", "No")



# All variables excluding the group variable AND Major variable as recoded above
myVars <- d201618_table2 %>% select(c(-CANCER, -CSTRATM,-PATWT,-CPSUM)) %>% names()
# All categorical variables
catVars <- d201618_table2 %>% select(where(is.factor)) %>%
  dplyr::select(-CANCER) %>% names()

svy_d201618 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d201618_table2$PATWT, data = d201618_table2)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d201618 ,
                          factorVars = catVars,
                          strata = "CANCER",
                          addOverall = T,
                          test = T,
                          includeNA = FALSE)





tab1_word <- print(tab1,
                   quote = F,
                   noSpaces = T,
                   test = T,
                   contDigits = 1,
                   printToggle = F,
                   dropEqual = T,
                   explain = F)

# Convert to dataframe
tab1_df <- as.data.frame(tab1_word) %>% rownames_to_column(var = "Variable")

# Rename first variable from n to No.
tab1_df$Variable[1] <- "No."
# Set Table header
header <- str_squish(str_remove("Table 1. Baseline characteristics By Cancer Status in the 2016, 18 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "C:\\Users\\Abhi\\Documents\\NAMCS_Analysis_2023_04_22\\NAMCS201618_CA_Tab1_servicesincluded_1.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))

# 
# 
# comb201618_namcs %>%
#   group_by(CANCER) %>%
#   summarise(avg_score = mean(PASTVIS),
#                    sd_score = sd(PASTVIS))
# 
# 
