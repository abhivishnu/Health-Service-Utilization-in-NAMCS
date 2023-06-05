forms <- list(x1 = EKG ~ DM2 + AGE, 
              x2 = DME ~ DM2 + AGE, 
              x3 = COLON ~ DM2 + AGE ,
              x4 = AUDIO ~ DM2 + AGE,
              x5 = CRYO ~ DM2 + AGE, 
              x6 = SPIRO ~ DM2 + AGE ,
              x7 = MENTAL ~ DM2 + AGE,
              x8 = PT ~ DM2 + AGE, 
              x9 = PSYCHOTH ~ DM2 + AGE ,
              x10 = WOUND ~ DM2 + AGE,
              x11 = ETOH ~ DM2 + AGE, 
              x12 = BREAST ~ DM2 + AGE ,
              x13 = DEPRESS ~ DM2 + AGE,
              x14 = FOOT ~ DM2 + AGE, 
              x15 = NEURO ~ DM2 + AGE ,
              x16 = PELVIC ~ DM2 + AGE,
              x17 = RECTAL ~ DM2 + AGE, 
              x18 = RETINAL ~ DM2 + AGE ,
              x19 = SKIN ~ DM2 + AGE,
              x20 = SUBST ~ DM2 + AGE, 
              x21 = DIAEDUC ~ DM2 + AGE ,
              x22 = DIETNUTR ~ DM2 + AGE,
              x23 = EXERCISE ~ DM2 + AGE, 
              x24 = GRWTHDEV ~ DM2 + AGE ,
              x25 = INJPREV ~ DM2 + AGE,
              x26 = STRESMGT ~ DM2 + AGE, 
              x27 = SUBSTED ~ DM2 + AGE ,
              x28 = TOBACED ~ DM2 + AGE,
              x29 = WTREDUC ~ DM2 + AGE, 
              x30 = OTHSERV ~ DM2 + AGE 
)

library(purr)
regresults <- map_df(forms, ~coef(glm(.x, data = MatchedDMdata, family = binomial(link=logit)))) %>%
  select(-1, -3) 
regresultspvalue <- map_df(forms, ~coef(summary(glm(.x, data = MatchedDMdata, 
                                                     family = binomial(link=logit))))[,'Pr(>|z|)']) %>%
  select(-1, -3)
regresultsstderr <- map_df(forms, ~coef(summary(glm(.x, data = MatchedDMdata, family = binomial(link=logit))))[,2]) %>% 
  select(-1 ,-3)

regresultsterm <- c("EKG","DME","COLON","AUDIO","CRYO","SPIRO","MENTAL","PT","PSYCHOTH","WOUND","ETOH","BREAST","DEPRESS","FOOT","NEURO","PELVIC","RECTAL","RETINAL","SKIN","SUBST","DIAEDUC","DIETNUTR","EXERCISE","GRWTHDEV","INJPREV","STRESMGT","SUBSTED","TOBACED","WTREDUC","OTHSERV") 
regresultsdata <- cbind(regresultsterm, regresultscoeffs, regresultsstderr, regresultspvalue)
names(regresultsdata) <- c("Term", "Coeff", "StdErr", "P-value")
regresultsdata$OR <- exp(regresultsdata$Coeff)
regresultsdata$LOR <- exp(regresultsdata$Coeff - (2*regresultsdata$StdErr))
regresultsdata$UOR <- exp(regresultsdata$Coeff + (2*regresultsdata$StdErr))
regresultsdata <- regresultsdata[order(regresultsdata$OR),]

write.csv(regresultsdata,"C:\\Users\\Abhi\\Documents\\NAMCS2018\\RegressionResults\\regresults.csv", row.names = FALSE, quote=FALSE)

                          