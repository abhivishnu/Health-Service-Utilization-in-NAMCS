###FOR TABLE 2 i.e. comorbidities among DM patients


library(survival) # only needed for the dataset in this example
library(dplyr) # to modify the needed dataframe
library(tibble) # for rownames_to_column() function
library(stringr) # for str_squish()
library(flextable)
library(officer)
library(forcats)
library(survey)
library(tableone)
source("customtab.R")

library(dplyr)
namcs2016_dm_rx <- namcs2016_sas %>% filter_at(vars(ends_with("V2C1")|
                                         ends_with("V2C2")|
                                         ends_with("V2C3")|
                                         ends_with("V2C4")), any_vars(. == '099')) %>%
  mutate(flag = 1)

variables <- c('DIABTYP2', 'HTN','CKD','COPD','CHF','CAD','ESRD','HYPLIPID','OBESITY','OSA','HPE',
               'CEBVD','TOTCHRON',
               'CSTRATM','CPSUM','PATWT')
d2016_table <- namcs2016_sas %>% select(all_of(variables)) 
d2016_table2 <- d2016_table %>% mutate(DIABTYP2 = as_factor(DIABTYP2),
                                       HTN = as_factor(HTN),
                                       CKD = as_factor(CKD),
                                       COPD = as_factor(COPD),
                                       CHF = as_factor(CHF),
                                       CAD = as_factor(CAD),
                                       ESRD = as_factor(ESRD),
                                       HYPLIPID = as_factor(HYPLIPID),
                                       OBESITY = as_factor(OBESITY),
                                       OSA = as_factor(OSA),
                                       )

#d2016_table2 <- d2016_table1 %>% rename(`Age, years (mean (SD))` = AGE,
#                            Hypertension = HT,
#                            `Type 2 Diabetes` = DM2,
#                            `Race_Ethnicity` = RACERETH,
#                            Sex = SEX
#                            )

d2016_table2$DIABTYP2 <- d2016_table2$DIABTYP2 %>%
  fct_recode(DM = "1", `No DM` = "0")

#d2016_table2$SEX <- d2016_table2$SEX %>%
#  fct_recode(Male = '2', Female = '1')


# All variables excluding the group variable
myVars <- d2016_table2 %>% select(c(-DIABTYP2, -CSTRATM,-PATWT,-CPSUM)) %>% names()
# All categorical variables
catVars <- d2016_table2 %>% select(where(is.factor)) %>%
  dplyr::select(-DIABTYP2) %>% names()

svy_d2016 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d2016_table2$PATWT, data = d2016_table2)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d2016 ,
                          factorVars = catVars,
                                                           strata = 'DIABTYP2',
                                                            addOverall = T,
                                                            test = T,
                          includeNA = FALSE)





tab1_word <- print(tab1,
                   #                   nonnormal = c("Progesterone receptors, fmol/L (median [IQR])",
                   #                                 "Estrogen receptors, fmol/L (median [IQR])"),
                   quote = F,
                   noSpaces = T,
                   #  smd = T,
                   # missing = T,
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
header <- str_squish(str_remove("Table 2. Comorbidities among Diabetes Patients in the 2016 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS2016_DM_weighted_Comorbidities_Tab2.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))
