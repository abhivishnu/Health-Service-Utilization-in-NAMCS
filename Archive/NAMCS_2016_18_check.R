#Checking if we can merge 2016 and 2018 NAMCS data

names2016 <- names(namcs2016_sas)
names2018 <- names(namcs2018_sas)

common_list  <- Reduce(intersect, list(names2016,names2018))
setdiff(names2016, names2018)
setdiff(names2018, names2016 )


#Combining 2016 and 2018 data;

namcs2016_sas <- namcs2016_sas %>% mutate(index=paste0('2016_', 1:n()))
namcs2018_sas <- namcs2018_sas %>% mutate(index=paste0('2018_', 1:n()))

namcs2016_sas_1 <- subset(namcs2016_sas, select = c(-SPECR, -REGIONOFF))
namcs2018_sas_1 <- subset(namcs2018_sas, select = c(-CATPROC1, -CATPROC2, -CATPROC3, -CATPROC4, -CATPROC5, -CATPROC6, -CATPROC7
                                                    , -CATPROC8, -CATPROC9))

comb201618_namcs <- rbind(namcs2016_sas_1, namcs2018_sas_1)
