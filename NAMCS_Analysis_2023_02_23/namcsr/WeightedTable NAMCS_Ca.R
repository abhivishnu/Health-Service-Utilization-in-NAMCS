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


variables <- c('AGE','SEX','RACERETH', 'MAJOR', 'SPECCAT','PAYTYPER','CANCER', 'USETOBAC',
               'TOTCHRON','PASTVIS',
               'CSTRATM','CPSUM', 'PATWT')
d201618_table1 <- comb201618_namcs %>% select(all_of(variables)) 
d201618_table1$MAJOR_recoded <- ifelse(d201618_table1$MAJOR == '-9', "Left Blank", 
                                       ifelse(d201618_table1$MAJOR %in% c(2,3), "Chronic Problem",
                                        ifelse(d201618_table1$MAJOR == 6, "Preventive Care", "Other")))
                                                


d201618_table2 <- d201618_table1 %>% mutate(SEX = as_factor(SEX),
                                           RACERETH = as_factor(RACERETH),
                                           MAJOR_recoded = as_factor(MAJOR_recoded),
                                           CANCER = as_factor(CANCER),
                                           PAYTYPER = as_factor(PAYTYPER),
                                           SPECCAT = as_factor(SPECCAT),
                                           USETOBAC = as_factor(USETOBAC))


d201618_table2$SEX <- d201618_table2$SEX %>%
  fct_recode(Male = '2', Female = '1')

d201618_table2$AGEgt65 <- ifelse(d201618_table2$AGE > 65, "Yes", "No")



# All variables excluding the group variable AND Major variable as recoded above
myVars <- d201618_table2 %>% select(c(-CANCER, -CSTRATM,-PATWT,-CPSUM, -MAJOR, -AGE)) %>% names()
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
header <- str_squish(str_remove("Table 1. Baseline characteristics By Cancer Status in the 2016, 18 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS201618_CA_2.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))

