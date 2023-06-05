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


variables <- c('AGE', 'CANCER','AUDIO','BIOPROV', 'SIGPROV','CARDIAC','COLON','CRYO','EKG','EEG','EMG','EXCIPROV','SPIRO',
               'TONO','EGD','CSW','CAM','DME', 'HOMEHLTH','MENTAL','OCCUPY','PT','PSYCHOTH','RADTHER',
               'WOUND','ETOH','BREAST','DEPRESS','DVS','FOOT','NEURO','PELVIC','RECTAL','RETINAL','SKIN','SUBST',
               'ETOHED','ASTHMAED','ASTHMAP','DIAEDUC','DIETNUTR','EXERCISE','FAMPLAN','GENETIC','GRWTHDEV','INJPREV','STDPREV',
               'STRESMGT','SUBSTED','TOBACED','WTREDUC','OTHSERV',
               'CSTRATM','CPSUM','PATWT','DIABTYP0','DIABTYP2')

d201618_table <- comb201618_namcs %>% dplyr::select(all_of(variables)) 
d201618_table$DM2 <- ifelse(d201618_table$DIABTYP0 == "1"|d201618_table$DIABTYP2 == "1", "1","0")
d201618_table2 <- d201618_table %>% mutate(AUDIO = as_factor(AUDIO),
                                       CANCER = as_factor(CANCER),
                                       BIOPROV = as_factor(BIOPROV),
                                       SIGPROV = as_factor(SIGPROV),
                                       CARDIAC = as_factor(CARDIAC),
                                       COLON = as_factor(COLON),
                                       CRYO = as_factor(CRYO),
                                       EKG = as_factor(EKG),
                                       EEG = as_factor(EEG),
                                       EMG = as_factor(EMG),
                                       EXCIPROV = as_factor(EXCIPROV),
                                       SPIRO = as_factor(SPIRO),
                                       TONO = as_factor(TONO),
                                       EGD = as_factor(EGD),
                                       CSW = as_factor(CSW),
                                       CAM = as_factor(CAM),
                                       DME = as_factor(DME),
                                       HOMEHLTH = as_factor(HOMEHLTH),
                                       MENTAL = as_factor(MENTAL),
                                       OCCUPY = as_factor(OCCUPY),
                                       PT = as_factor(PT),
                                       PSYCHOTH = as_factor(PSYCHOTH),
                                       RADTHER = as_factor(RADTHER),
                                       WOUND = as_factor(WOUND),
                                       ETOHED = as_factor(ETOHED),
                                       ASTHMAED = as_factor(ASTHMAED),
                                       ASTHMAP = as_factor(ASTHMAP),
                                       DIAEDUC = as_factor(DIAEDUC),
                                       DIETNUTR = as_factor(DIETNUTR),
                                       EXERCISE = as_factor(EXERCISE),
                                       FAMPLAN = as_factor(FAMPLAN),
                                       GENETIC = as_factor(GENETIC),
                                       GRWTHDEV = as_factor(GRWTHDEV),
                                       INJPREV = as_factor(INJPREV),
                                       STDPREV = as_factor(STDPREV),
                                       STRESMGT = as_factor(STRESMGT),
                                       SUBSTED = as_factor(SUBSTED),
                                       TOBACED = as_factor(TOBACED),
                                       WTREDUC = as_factor(WTREDUC),
                                       OTHSERV = as_factor(OTHSERV),
                                       ETOH = as_factor(ETOH),
                                       BREAST = as_factor(BREAST),
                                       DEPRESS = as_factor(DEPRESS),
                                       DVS = as_factor(DVS),
                                       FOOT = as_factor(FOOT),
                                       NEURO = as_factor(NEURO),
                                       PELVIC = as_factor(PELVIC),
                                       RECTAL = as_factor(RECTAL),
                                       RETINAL = as_factor(RETINAL),
                                       SKIN = as_factor(SKIN),
                                       SUBST = as_factor(SUBST)
                                      
)

#d201618_table2 <- d201618_table1 %>% rename(`Age, years (mean (SD))` = AGE,
#                            Hypertension = HT,
#                            `Type 2 Diabetes` = DM2,
#                            `Race_Ethnicity` = RACERETH,
#                            Sex = SEX
#                            )

d201618_table2$DM2 <- d201618_table2$DM2 %>%
  fct_recode(DM = "1", `No DM` = "0")

d201618_table2$CANCER <- d201618_table2$CANCER %>%
  fct_recode(CANCER = "1", `No CANCER` = "0")

#d2016_table2$SEX <- d2016_table2$SEX %>%
#  fct_recode(Male = '2', Female = '1')


# All variables excluding the group variable
myVars <- d201618_table2 %>% dplyr::select(c(-DM2,-CSTRATM,-PATWT,-CPSUM)) %>% names()
# All categorical variables
catVars <- d201618_table2 %>% select(where(is.factor)) %>%
  dplyr::select(-DM2) %>% names()

svy_d201618 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d201618_table2$PATWT, data = d201618_table2)

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
header <- str_squish(str_remove("Table 3. Service provided among DM2 Patients in the 2016-2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS2016_DM_weighted_Services_Tab3.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))











###########################
#TABLE FOR PUBLICATION
#WITH SELECTED VARIABELS



# All variables excluding the group variable
myVars <- c("EKG", "DME", "COLON", "AUDIO", "CRYO", "SPIRO", "MENTAL", "PT", "PSYCHOTH", "WOUND", 
                                      "ETOH", "BREAST", "DEPRESS", "FOOT", 'NEURO', "PELVIC", "RECTAL", 'RETINAL', "SKIN", "SUBST",
                                      "DIAEDUC", "DIETNUTR", "EXERCISE", "GRWTHDEV", "INJPREV", 'STRESMGT', 'SUBSTED', 'TOBACED',
                                      "WTREDUC", 'OTHSERV')
# All categorical variables
catVars <- myVars


#Creating a dataset with Matching on Age for DM patients
#this will be useful for comparison esp. in Table 2. Final regression analysis does
#not need to use only matched dataset as it will adjust for "AGE"

MatchedDM <- MatchIt::matchit(DM2 ~ AGE + PATWT, data=d201618_table2, ratio = 2, method = "nearest")
MatchedDMdata <- MatchIt::match.data(MatchedDM)

MatchedDMdata$weights  <- MatchedDMdata$subclass <- MatchedDMdata$distance <- NULL

svy_d201618_matched <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = MatchedDMdata$PATWT, data = MatchedDMdata)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d201618_matched ,
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
header <- str_squish(str_remove("Table 3. Comparison of Services provided in Visits among DM2 Patients Vs. Age-Matched non-DM patients in the 2016-2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS2016_DM_weighted_Services_Tab3_Final.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))


