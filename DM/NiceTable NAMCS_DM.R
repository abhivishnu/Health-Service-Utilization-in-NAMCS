library(survival) # only needed for the dataset in this example
library(dplyr) # to modify the needed dataframe
library(tibble) # for rownames_to_column() function
library(stringr) # for str_squish()
library(flextable)
library(officer)
library(forcats)
library(survey)
library(tableone)
library(Matching)
source("customtab.R")



variables <- c('AGE','SEX','RACERETH', 'DIABTYP2','DIABTYP0', 'HTN',
               'TOTCHRON', 'PASTVIS','PAYTYPER',
               'CSTRATM','CPSUM','PATWT')
d201618_table <- comb201618_namcs %>% dplyr::select(all_of(variables)) 
d201618_table$DM2 <- ifelse(d201618_table$DIABTYP0 == "1"|d201618_table$DIABTYP2 == "1", "1","0")

d201618_table2 <- d201618_table %>% mutate(SEX = as_factor(SEX),
                                       DM2 = as_factor(DM2),
                            HTN = as_factor(HTN),
                            PAYTYPER = as_factor(PAYTYPER),
                            RACERETH = as_factor(RACERETH))

#d2016_table2 <- d2016_table1 %>% rename(`Age, years (mean (SD))` = AGE,
#                            Hypertension = HT,
#                            `Type 2 Diabetes` = DM2,
#                            `Race_Ethnicity` = RACERETH,
#                            Sex = SEX
#                            )

#d201618_table2$DM2 <- d201618_table2$DM2 %>%
#  fct_recode(DM = "1", `No DM` = "0")

d201618_table2$DM3 <- as.numeric(d201618_table2$DM2) -1 

d201618_table2$SEX <- d201618_table2$SEX %>%
  fct_recode(Male = '2', Female = '1')

d201618_table2$SEX <- d201618_table2$SEX %>%
  fct_recode(Male = '2', Female = '1')


# All variables excluding the group variable
myVars <- d201618_table2 %>% dplyr::select(c(-DM2,-DIABTYP2,-DIABTYP0, -CSTRATM,-PATWT,-CPSUM)) %>% names()
# All categorical variables
catVars <- d201618_table2 %>% dplyr::select(where(is.factor)) %>%
  dplyr::select(-DM2) %>% names()




svy_d201618 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d201618_table2$PATWT, data = d201618_table2)



tab1 <- svyCreateTableOne(vars = myVars,data = svy_d201618 ,
                                  factorVars = catVars,
                                 strata = "DM2",
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
header <- str_squish(str_remove("Table 1. Baseline characteristics of Diabetes Patients in the 2016 & 2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS201618_DM_Tab1.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))

