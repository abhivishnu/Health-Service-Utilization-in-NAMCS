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


variables <- c('AGE', 'CANCER','DIABTYP2','DIABTYP0', 'HTN','CKD','COPD','CHF','CAD','ESRD','HYPLIPID','OBESITY',
               'OSA','HPE','CEBVD','TOTCHRON','CSTRATM','CPSUM','PATWT')




d201618_table <- comb201618_namcs %>% dplyr::select(all_of(variables)) 
d201618_table$DM2 <- ifelse(d201618_table$DIABTYP0 == "1"|d201618_table$DIABTYP2 == "1", "1","0")
d201618_table2 <- d201618_table %>% mutate(DM2 = as_factor(DM2),
                                       CANCER = as_factor(CANCER),
                                       HTN = as_factor(HTN),
                                       CKD = as_factor(CKD),
                                       COPD = as_factor(COPD),
                                       CHF = as_factor(CHF),
                                       CAD = as_factor(CAD),
                                       ESRD = as_factor(ESRD),
                                       HYPLIPID = as_factor(HYPLIPID),
                                       OBESITY = as_factor(OBESITY),
                                       OSA = as_factor(OSA),
                                       HPE = as_factor(HPE),
                                       CEBVD = as_factor(CEBVD)
)


d201618_table2$DM2 <- d201618_table2$DM2 %>%
  fct_recode(DM = "1", `No DM` = "0")

d201618_table2$CANCER <- d201618_table2$CANCER %>%
  fct_recode(CANCER = "1", `No CANCER` = "0")

#d2016_table2$SEX <- d2016_table2$SEX %>%
#  fct_recode(Male = '2', Female = '1')

d201618_table2$DM3 <- as.numeric(d201618_table2$DM2) -1

#Creating a dataset with Matching on Age for DM patients
#this will be useful for comparison esp. in Table 2. Final regression analysis does
#not need to use only matched dataset as it will adjust for "AGE"

MatchedDM <- MatchIt::matchit(DM3 ~ AGE + PATWT, data=d201618_table2, ratio = 2, method = "nearest")
MatchedDMdata <- MatchIt::match.data(MatchedDM)

# All variables excluding the group variable
myVars <- MatchedDMdata %>% dplyr::select(c(-AGE, -DM2,-DM3, -DIABTYP0 ,-DIABTYP2,-CSTRATM,-PATWT,
                                            -CPSUM, -distance, -weights, -subclass)) %>% names()
# All categorical variables
catVars <- MatchedDMdata %>% dplyr::select(where(is.factor)) %>%
  dplyr::select(-DM2, -subclass, -CANCER) %>% names()


MatchedDMdata$weights  <- MatchedDMdata$subclass <- MatchedDMdata$distance <- NULL

svy_d201618 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = MatchedDMdata$PATWT, data = MatchedDMdata)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d201618 ,
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
header <- str_squish(str_remove("Table 2. Comparison of Comorbidities among DM Patients with Age-matched non-DM patients in the 2016-2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS201618_DM_weighted_Comorbidities_Tab2.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))

