
forms <- list(x2 = MAMMO ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
              x3 = COLON ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
              x7 = MENTAL ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x8 = PT ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
              x9 = PSYCHOTH ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
              x10 = HIVTEST ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
              x11 = ETOH ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
              x13 = DEPRESS ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x14 = OCCUPY ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x15 = DME ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x16 = HOMEHLTH ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
              x17 = BONEDENS ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x18 = CAM ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
              x22 = DIETNUTR ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x23 = EXERCISE ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
              x26 = STRESMGT ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
              x28 = DVS ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x29 = GENETIC ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x30 = HEPTEST ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x31 = SUBST ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x32 = CervicalCaScreen ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
              x33 = AnyService_0_1 ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER
)



library(purrr)
regresults <- map_df(forms, ~coef(glm(.x, data = comb201618_namcs, family = binomial(link=logit)))) %>%
  select(-1, -3) 
regresultsstderr <- map_df(forms, ~coef(summary(glm(.x, data = comb201618_namcs, family = binomial(link=logit))))[,2]) %>% 
  select(-1 ,-3)
regresultspvalue <- map_df(forms, ~coef(summary(glm(.x, data = comb201618_namcs, 
                                                    family = binomial(link=logit))))[,'Pr(>|z|)']) %>%
  select(-1, -3)
regresultscoeffs <- map_df(forms, ~coef(summary(glm(.x, data = comb201618_namcs, family = binomial(link=logit))))[,1]) %>% 
  select(-1 ,-3)

regresultsterm <- c("MAMMO","COLON","MENTAL","PT","PSYCHOTH","HIVTEST","ETOH", "DEPRESS","OCCUPY","DME","HOMEHLTH","BONEDENS",
                    "CAM", "DIETNUTR","EXERCISE","STRESMGT","DVS","GENETIC","HEPTEST","SUBST","CervicalCaScreen", "ANY SERVICE") 
regresultsdata <- cbind(regresultsterm, regresultscoeffs, regresultsstderr, regresultspvalue)
regresultsdata <- regresultsdata[,c(1,2,13,24)]

names(regresultsdata) <- c("Term", "Coeff", "StdErr", "P-value")
regresultsdata$OR <- exp(regresultsdata$Coeff)
regresultsdata$LOR <- exp(regresultsdata$Coeff - (2*abs(regresultsdata$StdErr)))
regresultsdata$UOR <- exp(regresultsdata$Coeff + (2*abs(regresultsdata$StdErr)))
regresultsdata <- regresultsdata[order(regresultsdata$OR),]

write.csv(regresultsdata,"C:\\Users\\Abhi\\Documents\\NAMCS_Analysis_2023_04_22\\CA_regresults_2023_04_22_1.csv", row.names = FALSE, quote=FALSE)

