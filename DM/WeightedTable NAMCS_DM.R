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


variables <- c('DM2', 'HT','AGE','SEX', 'TGSRES', 'LDLRES', 'A1CRES', 'RACERETH','CSTRATM','CPSUM','PATWT')
d2016_table <- namcs2016_sas %>% select(all_of(variables)) 
d2016_table2 <- d2016_table %>% mutate(SEX = as_factor(SEX),
                                       DM2 = as_factor(DM2),
                                       HT = as_factor(HT),
                                       RACERETH = as_factor(RACERETH))

#d2016_table2 <- d2016_table1 %>% rename(`Age, years (mean (SD))` = AGE,
#                            Hypertension = HT,
#                            `Type 2 Diabetes` = DM2,
#                            `Race_Ethnicity` = RACERETH,
#                            Sex = SEX
#                            )

d2016_table2$DM2 <- d2016_table2$DM2 %>%
  fct_recode(DM = "Yes", `No DM` = "No")

d2016_table2$SEX <- d2016_table2$SEX %>%
  fct_recode(Male = '2', Female = '1')


# All variables excluding the group variable
myVars <- d2016_table2 %>% select(-DM2) %>% names()
# All categorical variables
catVars <- d2016_table2 %>% select(where(is.factor)) %>%
  dplyr::select(-DM2) %>% names()

svy_d2016 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d2016_table2$PATWT, data = d2016_table2)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d2016 ,
                          factorVars = catVars,
                                                           strata = 'DM2',
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
header <- str_squish(str_remove("Table 1. Baseline characteristics Diabetes Patients in the NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS2016_DM_weighted_1.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))
