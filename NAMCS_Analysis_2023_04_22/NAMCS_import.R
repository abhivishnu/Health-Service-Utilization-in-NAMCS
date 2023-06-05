library(haven)
library(naniar)
library(ggplot2)
library(survival) # only needed for the dataset in this example
library(dplyr) # to modify the needed dataframe
library(tibble) # for rownames_to_column() function
library(stringr) # for str_squish()
library(flextable)
library(officer)
library(forcats)
library(survey)
library(tableone)


namcs2016_sas <- read_sas("C:/Users/Abhi/Downloads/namcs2016_sas/namcs2016_sas.sas7bdat", NULL)
namcs2018_sas <- read_sas("NAMCS2018/namcs2018_sas/namcs2018_sas.sas7bdat")

#namcs2016_sas <- read_sas("C:/Users/abhiv/Downloads/namcs2016_sas/namcs2016_sas.sas7bdat", NULL)
#namcs2018_sas <- read_sas("C:/Users/abhiv/Downloads/namcs2018_sas/namcs2018_sas.sas7bdat", NULL)

namcs2016_sas_1 <- subset(namcs2016_sas, select = c(-SPECR, -REGIONOFF))
namcs2018_sas_1 <- subset(namcs2018_sas, select = c(-CATPROC1, -CATPROC2, -CATPROC3, -CATPROC4, -CATPROC5, -CATPROC6, -CATPROC7, -CATPROC8, -CATPROC9))

comb201618_namcs <- rbind(namcs2016_sas_1, namcs2018_sas_1)
comb201618_namcs$CervicalCaScreen <- dplyr::if_else(comb201618_namcs$PAP == 1 | comb201618_namcs$HPVDNA == 1, 1, 0)

weighted.mean(namcs2016_sas$BPSYS, namcs2016_sas$PATWT)

#need to replace '-9' '-998' with NA

comb201618_namcs <- comb201618_namcs %>% naniar::replace_with_na(replace = list(BPDIAS = c(-9, 998), 
                                                                    BPSYS = c(-9,998),
                                                                    TGSRES = c(-9, 998,-7),
                                                                    LDLRES = c(-9, 998,-7),
                                                                    A1CRES = c(-9, 998,-7),
                                                                    FBGRES = c(-9, 998,-7),
                                                                    PASTVIS = c(-7),
                                                                    PAYTYPER = c(-9, -8),
                                                                    BIOPROV = c(-9, -7),
                                                                    SIGPROV = c(-9, -7),
                                                                    EXCIPROV = c(-9, -7),
                                                                    TOTCHRON = c(-9)))


comb201618_namcs$MAJOR_recoded <- ifelse(comb201618_namcs$MAJOR == '-9', "Left Blank", 
                                       ifelse(comb201618_namcs$MAJOR %in% c(2,3), "Chronic Problem",
                                              ifelse(comb201618_namcs$MAJOR == 6, "Preventive Care", "Other")))


comb201618_namcs$TotalServices <- comb201618_namcs$EKG + comb201618_namcs$DME + comb201618_namcs$COLON + comb201618_namcs$AUDIO + 
  comb201618_namcs$CRYO + comb201618_namcs$SPIRO + comb201618_namcs$MENTAL + comb201618_namcs$PT + comb201618_namcs$PSYCHOTH + 
  comb201618_namcs$WOUND + comb201618_namcs$ETOH + comb201618_namcs$CervicalCaScreen + comb201618_namcs$DEPRESS + comb201618_namcs$FOOT + 
  comb201618_namcs$NEURO + comb201618_namcs$PELVIC + comb201618_namcs$RECTAL + comb201618_namcs$RETINAL + comb201618_namcs$SKIN + 
  comb201618_namcs$SUBST + comb201618_namcs$DIAEDUC + comb201618_namcs$DIETNUTR + comb201618_namcs$EXERCISE + 
  comb201618_namcs$GRWTHDEV + comb201618_namcs$INJPREV + comb201618_namcs$STRESMGT + comb201618_namcs$SUBSTED + 
  comb201618_namcs$TOBACED + comb201618_namcs$WTREDUC + comb201618_namcs$OTHSERV + comb201618_namcs$HEPTEST + comb201618_namcs$SUBST + comb201618_namcs$ETOHED + comb201618_namcs$HIV
comb201618_namcs$TotalServices_0_1 <- ifelse(comb201618_namcs$TotalServices == 0, 0, 1)



comb201618_namcs$AnyService <- comb201618_namcs$DME + comb201618_namcs$COLON + comb201618_namcs$DVS + 
  comb201618_namcs$MENTAL + comb201618_namcs$PT + comb201618_namcs$PSYCHOTH + 
  comb201618_namcs$OCCUPY + comb201618_namcs$CervicalCaScreen + comb201618_namcs$DEPRESS + 
  comb201618_namcs$DIETNUTR + comb201618_namcs$EXERCISE + 
  comb201618_namcs$STRESMGT + comb201618_namcs$MAMMO + comb201618_namcs$HOMEHLTH +
  comb201618_namcs$CAM + comb201618_namcs$BONEDENS + comb201618_namcs$GENETIC +
  comb201618_namcs$HEPTEST + comb201618_namcs$SUBST + comb201618_namcs$ETOH + comb201618_namcs$HIVTEST
comb201618_namcs$AnyService_0_1 <- ifelse(comb201618_namcs$AnyService == 0, 0, 1)


comb201618_namcs$AGEgt65 <- ifelse(comb201618_namcs$AGE > 65, "Yes", "No")

comb201618_namcs <- comb201618_namcs %>% mutate(SEX = as_factor(SEX),
                                            RACERETH = as_factor(RACERETH),
                                            MAJOR_recoded = as_factor(MAJOR_recoded),
                                            CANCER = as_factor(CANCER),
                                            PAYTYPER = as_factor(PAYTYPER),
                                            SPECCAT = as_factor(SPECCAT))
                                           


comb201618_namcs_cat <- comb201618_namcs %>% mutate(USETOBAC = as_factor(USETOBAC),                                           CANCER = as_factor(CANCER),
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
                                            STRESMGT = as_fact9or(STRESMGT),
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
