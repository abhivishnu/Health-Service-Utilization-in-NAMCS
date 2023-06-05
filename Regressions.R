# breast exam - BREAST
# 
# skin exam - SKIN
# 
# depression screening - DEPRESS
# 
# bone mineral density - BONEDENS
# 
# mammography -MAMMO
# 
# colonoscopy (can also look at colonoscopy provided) – will not know indication - COLON
# 
# sigmoidoscopy (can also look at sigmoidoscopy provided) -will not know indication - SIGMOID
# 
# complementary and alternative medicine - CAM
# 
# durable medical equipment - DME
# 
# home health care - HOMEHLTH
#
# mental health counseling - MENTAL
# 
# occupational therapy - OCCUPY
# 
# physical therapy - PT
# 
# psychotherapy - PSYCHOTH
# 
# radiation therapy - RADTHER
# 
# diet/nutrition - DIETNUTR
# 
# exercise - EXERCISE
# 
# genetic counseling - GENETIC
# 
# stress management - STRESMGT
# 
# tobacco use/exposure - TOBACED


# 
# 
# forms <- list(x2 = MAMMO ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x3 = COLON ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
#               x7 = MENTAL ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x8 = PT ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x9 = PSYCHOTH ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
#               x12 = BREAST ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER ,
#               x13 = DEPRESS ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x22 = DIETNUTR ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x23 = EXERCISE ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x26 = STRESMGT ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x28 = TOBACED ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x30 = SIGMOID ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x13 = OCCUPY ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x19 = GENETIC ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x22 = DME ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x23 = HOMEHLTH ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x26 = RADTHER ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x28 = BONEDENS ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER,
#               x29 = CAM ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER, 
#               x31 = AnyService_0_1 ~ CANCER + AGEgt65 + RACERETH + SEX + PAYTYPER
# )
# 
# 
# forms <-	list(x1	=	EKG	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x2	=	DME	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x3	=	COLON	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x4	=	AUDIO	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x5	=	CRYO	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x6	=	SPIRO	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x7	=	MENTAL	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x8	=	PT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x9	=	PSYCHOTH	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x10	=	WOUND	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x11	=	ETOH	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x12	=	CervicalCaScreen	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x13	=	DEPRESS	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x14	=	FOOT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x15	=	NEURO	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x16	=	PELVIC	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x17	=	RECTAL	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x18	=	RETINAL	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x19	=	SKIN	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x20	=	SUBST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x21	=	DIAEDUC	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x22	=	DIETNUTR	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x23	=	EXERCISE	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x24	=	GRWTHDEV	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x25	=	INJPREV	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x26	=	STRESMGT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x27	=	SUBSTED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x28	=	TOBACED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x29	=	WTREDUC	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x30	=	OTHSERV	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x31	=	HEPTEST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x32	=	SUBST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x33	=	ETOHED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x34	=	HIV	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#               x35	=	AnyService_0_1	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER
# )
# 
# 
# forms <- 	list(x1	=	DME	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x2	=	COLON	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x3	=	SIGMOID	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x4	=	MENTAL	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x5	=	PT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x6	=	PSYCHOTH	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x7	=	OCCUPY	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x8	=	CervicalCaScreen	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x9	=	DEPRESS	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x10	=	DIETNUTR	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x11	=	EXERCISE	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x12	=	STRESMGT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x13	=	MAMMO	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x14	=	HOMEHLTH	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x15	=	TOBACED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x16	=	CAM	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x17	=	BONEDENS	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x18	=	GENETIC	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x19	=	RADTHER	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x20	=	HEPTEST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER, 
#                x21	=	SUBST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x22	=	ETOHED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x23	=	HIV	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER,
#                x24	=	AnyService_0_1	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER
# )


forms <- 	list(x1	=	DME	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x2	=	COLON	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x3	=	SIGMOID	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x4	=	MENTAL	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x5	=	PT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x6	=	PSYCHOTH	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x7	=	OCCUPY	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x8	=	CervicalCaScreen	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x9	=	DEPRESS	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x10	=	DIETNUTR	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x11	=	EXERCISE	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x12	=	STRESMGT	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x13	=	MAMMO	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x14	=	HOMEHLTH	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x15	=	TOBACED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x16	=	CAM	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x17	=	BONEDENS	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x18	=	GENETIC	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x19	=	RADTHER	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x20	=	HEPTEST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON, 
               x21	=	SUBST	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x22	=	ETOHED	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x23	=	HIV	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON,
               x24	=	AnyService_0_1	~	CANCER	+	AGEgt65	+	RACERETH	+	SEX	+	PAYTYPER + TOTCHRON
)
# 
# 
# forms <- 	list(x1	=	DME	~	CANCER	+	AGE	+ TOTCHRON,
#                x2	=	COLON	~	CANCER	+	AGE	+ TOTCHRON,
#                x3	=	SIGMOID	~	CANCER	+	AGE	+ TOTCHRON,
#                x4	=	MENTAL	~	CANCER	+	AGE	+ TOTCHRON,
#                x5	=	PT	~	CANCER	+	AGE	+ TOTCHRON,
#                x6	=	PSYCHOTH	~	CANCER	+	AGE	+ TOTCHRON,
#                x7	=	OCCUPY	~	CANCER	+	AGE	+ TOTCHRON,
#                x8	=	CervicalCaScreen	~	CANCER	+	AGE	+ TOTCHRON,
#                x9	=	DEPRESS	~	CANCER	+	AGE	+ TOTCHRON,
#                x10	=	DIETNUTR	~	CANCER	+	AGE	+ TOTCHRON,
#                x11	=	EXERCISE	~	CANCER	+	AGE	+ TOTCHRON,
#                x12	=	STRESMGT	~	CANCER	+	AGE	+ TOTCHRON,
#                x13	=	MAMMO	~	CANCER	+	AGE	+ TOTCHRON,
#                x14	=	HOMEHLTH	~	CANCER	+	AGE	+ TOTCHRON,
#                x15	=	TOBACED	~	CANCER	+	AGE	+ TOTCHRON,
#                x16	=	CAM	~	CANCER	+	AGE	+ TOTCHRON,
#                x17	=	BONEDENS	~	CANCER	+	AGE	+ TOTCHRON,
#                x18	=	GENETIC	~	CANCER	+	AGE	+ TOTCHRON,
#                x19	=	RADTHER	~	CANCER	+	AGE	+ TOTCHRON,
#                x20	=	HEPTEST	~	CANCER	+	AGE	+ TOTCHRON, 
#                x21	=	SUBST	~	CANCER	+	AGE	+ TOTCHRON,
#                x22	=	ETOHED	~	CANCER	+	AGE	+ TOTCHRON,
#                x23	=	HIV	~	CANCER	+	AGE	+ TOTCHRON,
#                x24	=	AnyService_0_1	~	CANCER	+	AGE	+ TOTCHRON
# )
# 
# 
# 
# forms <- 	list(x1	=	DME	~	CANCER		,
#                x2	=	COLON	~	CANCER		,
#                x3	=	SIGMOID	~	CANCER		,
#                x4	=	MENTAL	~	CANCER		,
#                x5	=	PT	~	CANCER		,
#                x6	=	PSYCHOTH	~	CANCER		,
#                x7	=	OCCUPY	~	CANCER		,
#                x8	=	CervicalCaScreen	~	CANCER		,
#                x9	=	DEPRESS	~	CANCER		,
#                x10	=	DIETNUTR	~	CANCER		,
#                x11	=	EXERCISE	~	CANCER		,
#                x12	=	STRESMGT	~	CANCER		,
#                x13	=	MAMMO	~	CANCER		,
#                x14	=	HOMEHLTH	~	CANCER		,
#                x15	=	TOBACED	~	CANCER		,
#                x16	=	CAM	~	CANCER		,
#                x17	=	BONEDENS	~	CANCER		,
#                x18	=	GENETIC	~	CANCER		,
#                x19	=	RADTHER	~	CANCER		,
#                x20	=	HEPTEST	~	CANCER		, 
#                x21	=	SUBST	~	CANCER		,
#                x22	=	ETOHED	~	CANCER		,
#                x23	=	HIV	~	CANCER		,
#                x24	=	AnyService_0_1	~	CANCER		
# )
# 
# 
# forms <- 	list(x1	=	DME	~	CANCER		+ TOTCHRON,
#                x2	=	COLON	~	CANCER		+ TOTCHRON,
#                x3	=	SIGMOID	~	CANCER		+ TOTCHRON,
#                x4	=	MENTAL	~	CANCER		+ TOTCHRON,
#                x5	=	PT	~	CANCER		+ TOTCHRON,
#                x6	=	PSYCHOTH	~	CANCER		+ TOTCHRON,
#                x7	=	OCCUPY	~	CANCER		+ TOTCHRON,
#                x8	=	CervicalCaScreen	~	CANCER		+ TOTCHRON,
#                x9	=	DEPRESS	~	CANCER		+ TOTCHRON,
#                x10	=	DIETNUTR	~	CANCER		+ TOTCHRON,
#                x11	=	EXERCISE	~	CANCER		+ TOTCHRON,
#                x12	=	STRESMGT	~	CANCER		+ TOTCHRON,
#                x13	=	MAMMO	~	CANCER		+ TOTCHRON,
#                x14	=	HOMEHLTH	~	CANCER		+ TOTCHRON,
#                x15	=	TOBACED	~	CANCER		+ TOTCHRON,
#                x16	=	CAM	~	CANCER		+ TOTCHRON,
#                x17	=	BONEDENS	~	CANCER		+ TOTCHRON,
#                x18	=	GENETIC	~	CANCER		+ TOTCHRON,
#                x19	=	RADTHER	~	CANCER		+ TOTCHRON,
#                x20	=	HEPTEST	~	CANCER		+ TOTCHRON, 
#                x21	=	SUBST	~	CANCER		+ TOTCHRON,
#                x22	=	ETOHED	~	CANCER		+ TOTCHRON,
#                x23	=	HIV	~	CANCER		+ TOTCHRON,
#                x24	=	AnyService_0_1	~	CANCER		+ TOTCHRON
# )

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

regresultsterm <- c('DME', 'COLON', 'SIGMOID', 'MENTAL', 'PT', 'PSYCHOTH', 'OCCUPY', 'CervicalCaScreen', 'DEPRESS', 'DIETNUTR', 'EXERCISE', 'STRESMGT', 'MAMMO', 'HOMEHLTH', 'TOBACED', 'CAM', 'BONEDENS', 'GENETIC', 'RADTHER', 'HEPTEST', 'SUBST', 'ETOHED', 'HIV', 'AnyService_0_1') 
regresultsdata <- cbind(regresultsterm, regresultscoeffs, regresultsstderr, regresultspvalue)
regresultsdata <- regresultsdata[,c(1,2,14,26)]

names(regresultsdata) <- c("Term", "Coeff", "StdErr", "P-value")
regresultsdata$OR <- exp(regresultsdata$Coeff)
regresultsdata$LOR <- exp(regresultsdata$Coeff - (2*abs(regresultsdata$StdErr)))
regresultsdata$UOR <- exp(regresultsdata$Coeff + (2*abs(regresultsdata$StdErr)))
regresultsdata <- regresultsdata[order(regresultsdata$OR),]

write.csv(regresultsdata,"C:\\Users\\Abhi\\Documents\\NAMCS2018\\RegressionResults\\CA_regresults_2023_03_29_NoMatch_ADJ_TOTcHRON.csv", row.names = FALSE, quote=FALSE)

