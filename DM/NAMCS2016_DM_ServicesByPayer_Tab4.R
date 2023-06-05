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


variables <- c('CANCER','AUDIO','BIOPROV', 'SIGPROV','CARDIAC','COLON','CRYO','EKG','EEG','EMG','EXCIPROV','SPIRO',
               'TONO','EGD','CSW','CAM','DME', 'HOMEHLTH','MENTAL','OCCUPY','PT','PSYCHOTH','RADTHER',
               'WOUND','ETOH','BREAST','DEPRESS','DVS','FOOT','NEURO','PELVIC','RECTAL','RETINAL','SKIN','SUBST',
               'ETOHED','ASTHMAED','ASTHMAP','DIAEDUC','DIETNUTR','EXERCISE','FAMPLAN','GENETIC','GRWTHDEV','INJPREV','STDPREV',
               'STRESMGT','SUBSTED','TOBACED','WTREDUC','OTHSERV',
               'CSTRATM','CPSUM','PATWT','DIABTYP0','DIABTYP2','PAYTYPER')

d2016_table1 <- comb201618_namcs %>% select(all_of(variables)) 
d2016_table1$DM2 <- ifelse(d2016_table1$DIABTYP0 == "1"|d2016_table1$DIABTYP2 == "1", "1","0")
d2016_table <- subset(d2016_table1, DM2 == "1")
d2016_table2 <- d2016_table %>% mutate(AUDIO = as_factor(AUDIO),
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
                                       SUBST = as_factor(SUBST),
                                       PAYTYPER = as_factor(PAYTYPER)
                                       
)
#d2016_table2 <- d2016_table1 %>% rename(`Age, years (mean (SD))` = AGE,
#                            Hypertension = HT,
#                            `Type 2 Diabetes` = DM2,
#                            `Race_Ethnicity` = RACERETH,
#                            Sex = SEX
#                            )


#d2016_table2$SEX <- d2016_table2$SEX %>%
#  fct_recode(Male = '2', Female = '1')


# All variables excluding the group variable
myVars <- d2016_table2 %>% select(c(-PAYTYPER,-CSTRATM,-PATWT,-CPSUM)) %>% names()
# All categorical variables
catVars <- d2016_table2 %>% select(where(is.factor)) %>%
  dplyr::select(-PAYTYPER) %>% names()

svy_d2016 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = d2016_table2$PATWT, data = d2016_table2)

tab1 <- svyCreateTableOne(vars = myVars,data = svy_d2016 ,
                          factorVars = catVars,
                          strata = 'PAYTYPER',
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
header <- str_squish(str_remove("Table 4.Comparison of Service provided among DM2 Patients By Payer Type in the 2016-2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS201618_DM2_ServicesByPayer_Tab4.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "landscape"),
                            type = "continuous"))
