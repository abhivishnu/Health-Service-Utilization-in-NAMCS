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
#source("customtab.R")
source("C:/Users/abhiv/Downloads/customtab.R")


variables <- c('CSTRATM','PATWT','CPSUM','CANCER','MAMMO',  'COLON','MENTAL','PT','PSYCHOTH','CervicalCaScreen','DEPRESS','SKIN','DIETNUTR','EXERCISE','STRESMGT',
               'TOBACED','SIGMOID','OCCUPY','GENETIC','DME','HOMEHLTH','RADTHER','BONEDENS','CAM','AnyService_0_1','HEPTEST','SUBST','ETOHED','HIV')

d2016_table1 <- comb201618_namcs %>% select(all_of(variables)) 


d2016_table2 <- d2016_table1 %>% mutate(
  CANCER = as_factor(CANCER),
  COLON = as_factor(COLON),
  MAMMO = as_factor(MAMMO),
  PT = as_factor(PT),
  DIETNUTR = as_factor(DIETNUTR),
  EXERCISE = as_factor(EXERCISE),
  SKIN = as_factor(SKIN),
  TOBACED = as_factor(TOBACED),
  CervicalCaScreen = as_factor(CervicalCaScreen),
  DEPRESS = as_factor(DEPRESS),
  MENTAL = as_factor(MENTAL),
  PSYCHOTH = as_factor(PSYCHOTH),
  STRESMGT = as_factor(STRESMGT),
  SIGMOID = as_factor(SIGMOID),
  OCCUPY = as_factor(OCCUPY),
  GENETIC = as_factor(GENETIC),
  DME = as_factor(DME),
  HOMEHLTH = as_factor(HOMEHLTH),
  RADTHER = as_factor(RADTHER),
  BONEDENS = as_factor(BONEDENS),
  CAM = as_factor(CAM),
  HEPTEST = as_factor(HEPTEST),
  SUBST = as_factor(SUBST),
  ETOHED = as_factor(ETOHED),
  HIV = as_factor(HIV),
  AnyService_0_1 = as_factor(AnyService_0_1)
)

d2016_table2$CANCER <- d2016_table2$CANCER %>%
  fct_recode(CANCER = "1", `No CANCER` = "0")


# All variables excluding the group variable
myVars <- d2016_table2 %>% select(c(-CANCER,-CSTRATM,-PATWT,-CPSUM)) %>% names()
# All categorical variables
catVars <- d2016_table2 %>% select(where(is.factor)) %>%
  dplyr::select(-CANCER) %>% names()

svy_d2016 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d2016_table2$PATWT, data = d2016_table2)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d2016 ,
                          factorVars = catVars,
                          strata = 'CANCER',
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
header <- str_squish(str_remove("Table 2. Service provided By Cancer Status in the 2016-2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS2016_CA_weighted_Services_Tab2.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))
