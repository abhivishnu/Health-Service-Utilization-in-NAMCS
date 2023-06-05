#Regression models for examining causal inference of excess burden due to DM2 in 2016 & 18 NAMCS Surveys


library(survival) # only needed for the dataset in this example
library(dplyr) # to modify the needed dataframe
library(tibble) # for rownames_to_column() function
library(stringr) # for str_squish()
library(flextable)
library(officer)
library(forcats)
library(survey)
library(tableone)
library(tidyverse)
source("customtab.R")


variables <- c("AGE","DIABTYP0","DIABTYP2",  "EKG","DME","COLON","AUDIO","CRYO","SPIRO","MENTAL","PT","PSYCHOTH",
               "WOUND","ETOH","BREAST","DEPRESS","FOOT","NEURO","PELVIC","RECTAL","RETINAL",
               "SKIN","SUBST","DIAEDUC","DIETNUTR","EXERCISE","GRWTHDEV","INJPREV","STRESMGT",
               "SUBSTED","TOBACED","WTREDUC","OTHSERV","TOTCHRON", "PATWT")
d201618_table <- comb201618_namcs %>% dplyr::select(all_of(variables)) 
d201618_table$DM2 <- ifelse(d201618_table$DIABTYP0 == "1"|d201618_table$DIABTYP2 == "1", "1","0")

d201618_table2 <- d201618_table
d201618_table2$DM2 <- d201618_table2$DM2 %>%
  fct_recode(DM = "1", `No DM` = "0")
d201618_table2$TOTCHRON2 <- if_else(d201618_table2$DM2 ==1,d201618_table2$TOTCHRON-1,d201618_table2$TOTCHRON)  



# All variables excluding the group variable
#myVars <- d201618_table2 %>% dplyr::select(c(-DM2,-DIABTYP2,-DIABTYP0)) %>% names()
# All categorical variables
##catVars <- d201618_table2 %>% dplyr::select(where(is.factor)) %>%
#  dplyr::select(-DM2) %>% names()


MatchedDM <- MatchIt::matchit(DM2 ~ AGE + PATWT, data=d201618_table2, ratio = 2, method = "nearest")
MatchedDMdata <- MatchIt::match.data(MatchedDM)

MatchedDMdata$weights  <- MatchedDMdata$subclass <- MatchedDMdata$distance <- NULL



forms <- list(x1 = EKG ~ DM2, 
              x2 = DME ~ DM2, 
              x3 = COLON ~ DM2 ,
              x4 = AUDIO ~ DM2,
              x5 = CRYO ~ DM2, 
              x6 = SPIRO ~ DM2 ,
              x7 = MENTAL ~ DM2,
              x8 = PT ~ DM2, 
              x9 = PSYCHOTH ~ DM2 ,
              x10 = WOUND ~ DM2,
              x11 = ETOH ~ DM2, 
              x12 = BREAST ~ DM2 ,
              x13 = DEPRESS ~ DM2,
              x14 = FOOT ~ DM2, 
              x15 = NEURO ~ DM2 ,
              x16 = PELVIC ~ DM2,
              x17 = RECTAL ~ DM2, 
              x18 = RETINAL ~ DM2 ,
              x19 = SKIN ~ DM2,
              x20 = SUBST ~ DM2, 
              x21 = DIAEDUC ~ DM2 ,
              x22 = DIETNUTR ~ DM2,
              x23 = EXERCISE ~ DM2, 
              x24 = GRWTHDEV ~ DM2 ,
              x25 = INJPREV ~ DM2,
              x26 = STRESMGT ~ DM2, 
              x27 = SUBSTED ~ DM2 ,
              x28 = TOBACED ~ DM2,
              x29 = WTREDUC ~ DM2, 
              x30 = OTHSERV ~ DM2 
)

regresultscoeffs <- map_df(forms, ~coef(glm(.x, data = MatchedDMdata, family = binomial(link=logit)))) %>%
  select(-1) 
regresultsstderr <- map_df(forms, ~coef(summary(glm(.x, data = MatchedDMdata, 
                                                    family = binomial(link=logit))))[,2]) %>%
  select(-1)
regresultspvalue <- map_df(forms, ~coef(summary(glm(.x, data = MatchedDMdata, 
                                                    family = binomial(link=logit))))[,4]) %>%
  select(-1)

regresultsterm <- c("EKG","DME","COLON","AUDIO","CRYO","SPIRO","MENTAL","PT","PSYCHOTH","WOUND","ETOH","BREAST","DEPRESS","FOOT","NEURO","PELVIC","RECTAL","RETINAL","SKIN","SUBST","DIAEDUC","DIETNUTR","EXERCISE","GRWTHDEV","INJPREV","STRESMGT","SUBSTED","TOBACED","WTREDUC","OTHSERV") 
regresultsdata <- cbind(regresultsterm, regresultscoeffs, regresultsstderr, regresultspvalue)
names(regresultsdata) <- c("Term", "Coeff", "StdErr","Pvalue")
regresultsdata$OR <- exp(regresultsdata$Coeff)

####Given that we are examining multiple outcomes, we will use 99% CI is stead of the traditional 95% CI
regresultsdata$LOR <- exp(regresultsdata$Coeff - (3*regresultsdata$StdErr))
regresultsdata$UOR <- exp(regresultsdata$Coeff + (3*regresultsdata$StdErr))
write.csv(regresultsdata,"C:\\Users\\Abhi\\Documents\\NAMCS2018\\RegressionResults\\regresults.csv", row.names = FALSE, quote=FALSE)










#svy_d201618 <- svydesign(id=~CSTRATM+CPSUM, fpc =NULL, weights = MatchedDMdata$PATWT, data = MatchedDMdata)
#summary(svyglm(TOTCHRON ~ DM2 + AGE, svy_d201618, family = poisson(link = "log")))


write.csv(broom::tidy(glm(EKG ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/EKG.csv")
write.csv(broom::tidy(glm(DME ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/DME.csv") 
write.csv(broom::tidy(glm(COLON ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/COLON.csv")
write.csv(broom::tidy(glm(AUDIO ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/AUDIO.csv")
write.csv(broom::tidy(glm(CRYO ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/CRYO.csv")
write.csv(broom::tidy(glm(SPIRO ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/SPIRO.csv")
write.csv(broom::tidy(glm(MENTAL ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/MENTAL.csv")
write.csv(broom::tidy(glm(PT ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/PT.csv")
write.csv(broom::tidy(glm(PSYCHOTH ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/PSYCHOTH.csv")
write.csv(broom::tidy(glm(WOUND ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/WOUND.csv")
write.csv(broom::tidy(glm(ETOH ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/ETOH.csv")
write.csv(broom::tidy(glm(BREAST ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/BREAST.csv")
write.csv(broom::tidy(glm(DEPRESS ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/DEPRESS.csv")
write.csv(broom::tidy(glm(FOOT ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/FOOT.csv")
write.csv(broom::tidy(glm(NEURO ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/NEURO.csv")
write.csv(broom::tidy(glm(PELVIC ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/PELVIC.csv")
write.csv(broom::tidy(glm(RECTAL ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/RECTAL.csv")
write.csv(broom::tidy(glm(RETINAL ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/RETINAL.csv")
write.csv(broom::tidy(glm(SKIN ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/SKIN.csv")
write.csv(broom::tidy(glm(SUBST ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/SUBST.csv")
write.csv(broom::tidy(glm(DIAEDUC ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/DIAEDUC.csv")
write.csv(broom::tidy(glm(DIETNUTR ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/DIETNUTR.csv")
write.csv(broom::tidy(glm(EXERCISE ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/EXERCISE.csv")
write.csv(broom::tidy(glm(GRWTHDEV ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/GRWTHDEV.csv")
write.csv(broom::tidy(glm(INJPREV ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/INJPREV.csv")
write.csv(broom::tidy(glm(STRESMGT ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/STRESMGT.csv")
write.csv(broom::tidy(glm(SUBSTED ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/SUBSTED.csv")
write.csv(broom::tidy(glm(TOBACED ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/TOBACOED.csv")
write.csv(broom::tidy(glm(WTREDUC ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/WTREDUC.csv")
write.csv(broom::tidy(glm(OTHSERV ~ DM2 + AGE, data = MatchedDMdata, family = binomial(link=logit))),  file = "~/NAMCS2018/RegressionResults/OTHSERV.csv")
