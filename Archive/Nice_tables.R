library(survival) # only needed for the dataset in this example
library(dplyr) # to modify the needed dataframe
library(tibble) # for rownames_to_column() function
library(stringr) # for str_squish()
library(flextable)
library(officer)
library(forcats)
library(tableone)
source("customtab.R")

breast <- survival::gbsg

variables <- names(breast)
breast <- breast %>% select(all_of(variables)) %>%
  select(-pid, -rfstime, -status)
breast <- breast %>% mutate(meno = as_factor(meno),
                            grade = as_factor(grade),
                            hormon = as_factor(hormon))

breast <- breast %>% rename(`Age, years (mean (SD))` = age,
                            Postmenopausal = meno,
                            `Tumor size, mm (mean (SD)` = size,
                            `Tumor grade` = grade,
                            `Positive lymph nodes, (n)` = nodes,
                            `Progesterone receptors, fmol/L (median [IQR])` = pgr,
                            `Estrogen receptors, fmol/L (median [IQR])` = er,
                            `Hormone treatment` = hormon)

breast$`Hormone treatment` <- breast$`Hormone treatment` %>%
  fct_recode(Treated = "1", Placebo = "0")

# All variables excluding the group variable
myVars <- breast %>% select(-`Hormone treatment`) %>% names()
# All categorical variables
catVars <- breast %>% select(where(is.factor)) %>%
  dplyr::select(-`Hormone treatment`) %>% names()

tab1 <- breast %>% CreateTableOne(vars = myVars,
                                  data = . ,
                                  factorVars = catVars,
                                  strata = "Hormone treatment",
                                  addOverall = T,
                                  test = T)

tab1_word <- print(tab1,
                   nonnormal = c("Progesterone receptors, fmol/L (median [IQR])",
                                 "Estrogen receptors, fmol/L (median [IQR])"),
                   quote = F,
                   noSpaces = T,
                   # smd = T,
                   # missing = T,
                   test = F,
                   contDigits = 1,
                   printToggle = F,
                   dropEqual = T,
                   explain = F)

# Convert to dataframe
tab1_df <- as.data.frame(tab1_word) %>% rownames_to_column(var = "Variable")

# Rename first variable from n to No.
tab1_df$Variable[1] <- "No."
# Set Table header
header <- str_squish(str_remove("Table 1. Baseline characteristics of 686
patients enrolled in the German Breast Cancer Study Group
between 1984 and 1989", "\n"))
# Set Table footer
footer <- str_squish(str_remove("Numbers are No. (%) unless otherwise noted.
SD = standard deviation, fmol/L = femtomole per liter,
IQR = interquartile range", "\n"))
# Set custom_tab() defaults
customtab_defaults()
# Create the flextable object
flextable_1 <- custom_tab(tab1_df, header, footer)


# Save as word .docx
save_as_docx(flextable_1, path = "flextab_1.docx",
             pr_section =
               prop_section(page_size = page_size(orient = "portrait"),
                            type = "continuous"))
