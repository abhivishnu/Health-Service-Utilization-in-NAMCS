library(dplyr) 
library(tibble)
library(stringr) 
library(flextable)
library(officer)
library(forcats)
library(tableone)
source("customtab.R")


# myVars <- c('COLON','MENTAL','PT','MAMMO', 'PSYCHOTH','BREAST','DEPRESS','DIETNUTR','EXERCISE','STRESMGT',
#             'TOBACED','SIGMOID','OCCUPY','GENETIC','DME','HOMEHLTH','RADTHER','BONEDENS','CAM','AnyService_0_1',
#             'CANCER','AGEgt65','AGE', 'PATWT','CSTRATM','CPSUM','RACERETH','SEX','PAYTYPER')
myVars <- c('DME', 'COLON', 'SIGMOID', 'MENTAL', 'PT', 'PSYCHOTH', 'OCCUPY', 'CervicalCaScreen', 'DEPRESS', 'DIETNUTR', 'EXERCISE', 'STRESMGT', 'MAMMO', 
            'HOMEHLTH', 'TOBACED', 'CAM', 'BONEDENS', 'GENETIC', 'RADTHER', 'HEPTEST', 'SUBST', 'ETOHED', 'HIV','AnyService_0_1','CANCER','AGEgt65','AGE', 
            'PATWT','CSTRATM','CPSUM','RACERETH','SEX','PAYTYPER')

myVars2 <- c('DME', 'COLON', 'SIGMOID', 'MENTAL', 'PT', 'PSYCHOTH', 'OCCUPY', 'CervicalCaScreen', 'DEPRESS', 'DIETNUTR', 'EXERCISE', 'STRESMGT', 'MAMMO', 
             'HOMEHLTH', 'TOBACED', 'CAM', 'BONEDENS', 'GENETIC', 'RADTHER', 'HEPTEST', 'SUBST', 'ETOHED', 'HIV','AnyService_0_1','CANCER','AGEgt65','RACERETH',
             'SEX','PAYTYPER')
  
# All categorical variables
catVars <- myVars2

#Creating a dataset with Matching on Age for Cancer patients
#this will be useful for comparison esp. in Table 2. Final regression analysis does
#not need to use only matched dataset as it will adjust for "AGE"
#comb201618_namcs$AGEgt65 <- ifelse(comb201618_namcs$AGE > 65, "Yes", "No")
d201618_match = comb201618_namcs[,myVars]


# d201618_match$TotalServices <- d201618_match$EKG + d201618_match$DME + d201618_match$COLON + d201618_match$AUDIO +
#   d201618_match$CRYO + d201618_match$SPIRO + d201618_match$MENTAL + d201618_match$PT + d201618_match$PSYCHOTH +
#   d201618_match$WOUND + d201618_match$ETOH + d201618_match$BREAST + d201618_match$DEPRESS + d201618_match$FOOT +
#   d201618_match$NEURO + d201618_match$PELVIC + d201618_match$RECTAL + d201618_match$RETINAL + d201618_match$SKIN +
#   d201618_match$SUBST + d201618_match$DIAEDUC + d201618_match$DIETNUTR + d201618_match$EXERCISE +
#   d201618_match$GRWTHDEV + d201618_match$INJPREV + d201618_match$STRESMGT + d201618_match$SUBSTED +
#   d201618_match$TOBACED + d201618_match$WTREDUC + d201618_match$OTHSERV
# d201618_match$TotalServices_0_1 <- ifelse(d201618_match$TotalServices == 0, 0, 1)
# 
# 
# d201618_match$AnyService <- d201618_match$DME + d201618_match$COLON + d201618_match$SIGMOID +
#   d201618_match$MENTAL + d201618_match$PT + d201618_match$PSYCHOTH +
#   d201618_match$OCCUPY + d201618_match$BREAST + d201618_match$DEPRESS +
#    d201618_match$DIETNUTR + d201618_match$EXERCISE +
#   d201618_match$STRESMGT + d201618_match$MAMMO + d201618_match$HOMEHLTH +
#   d201618_match$TOBACED + d201618_match$CAM + d201618_match$BONEDENS + d201618_match$GENETIC +
#   d201618_match$RADTHER
# d201618_match$AnyService_0_1 <- ifelse(d201618_match$AnyService == 0, 0, 1)



MatchedCA <- MatchIt::matchit(CANCER ~ AGE + PATWT, data=d201618_match, ratio = 2, method = "nearest")

MatchedCAdata <- MatchIt::match.data(MatchedCA)

MatchedCAdata$weights  <- MatchedCAdata$subclass <- MatchedCAdata$distance <- NULL
svy_d201618_matched <- survey::svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = MatchedCAdata$PATWT, data = MatchedCAdata)

tab1 <- svyCreateTableOne(vars = myVars2,data = svy_d201618_matched ,
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
tab1_df <- as.data.frame(tab1_word) %>% tibble::rownames_to_column(var = "Variable")

# Rename first variable from n to No.
tab1_df$Variable[1] <- "No."
# Set Table header
header <- str_squish(str_remove("Table 3. Comparison of Services provided in Visits among CANCER Patients Vs. Age-Matched non-Cancer patients in the 2016-2018 NAMCS Study", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "NAMCS2016_Cancer_weighted_Services_Tab3_Final.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))

