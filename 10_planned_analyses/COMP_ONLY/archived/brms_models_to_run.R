# brms models for COMP preregistration analyses 

# load libraries
library(brms)
library(tidyverse)


# Load data 
## only behavior
#from data_cleaning_for_analysis 
# long version, by trial 
load("../../2_cleaning_QC/cleaned_data/beh_comp_long.Rdata")
load("../../2_cleaning_QC/cleaned_data/beh_comp_long_WSLS.Rdata")
beh_scan_long_WSLS <- beh_comp_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")


## with scanning data 
# long version, by trial 
load("../../2_cleaning_QC/cleaned_data/beh_scan_comp_long.Rdata")
load("../../2_cleaning_QC/cleaned_data/beh_scan_comp_long_WSLS.Rdata")
beh_scan_comp_long_WSLS <- beh_scan_comp_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")

# Aim 2: brain behavior relationships 
## Hypothesis 3: choice reactivity will relate to proportion of effort choices 

### Model 3 for ACC: long version
mod3_ACC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                         AGE.c + SEX.c +  IQ.c + 
                         choice_ACC + (1 + Trial_Number.c | SUBJECTID), 
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_comp_long, cores = 4)
save(mod3_ACC_long_brms, file = "brms_models/mod3_ACC_long_brms.Rdata")


### mod 3 with mPFC: long version
mod3_mPFC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                          AGE.c + SEX.c +  IQ.c + 
                          choice_mPFC + (1 + Trial_Number.c | SUBJECTID), 
                        family =bernoulli(link = "logit"),  
                        data = beh_scan_comp_long, cores = 4)
save(mod3_mPFC_long_brms, file = "brms_models/mod3_mPFC_long_brms.Rdata")

### mod 3 with VS: long version
mod3_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                        AGE.c + SEX.c +  IQ.c + 
                          choice_VS +  (1 + Trial_Number.c | SUBJECTID), 
                        family = bernoulli(link = "logit"),  
                        data = beh_scan_comp_long, cores = 4)
save(mod3_VS_long_brms, file = "brms_models/mod3_VS_long_brms.Rdata")

## Hypothesis 4: Greater striatal response to rewards will be associated with a 
# greater proportion of hard-effort choices.

### Model 4 with Amyg: long version

mod4_Amyg_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c + 
                              AGE.c + SEX.c +  IQ.c +
                              reward_setback_Amyg + 
                              ( 1 + Trial_Number.c | SUBJECTID), 
                            family = bernoulli(link = "logit"),  
                            data = beh_scan_comp_long, cores = 4) 
save(mod4_Amyg_long_brms, file = "brms_models/mod4_Amyg_long_brms.Rdata")


### Model 4 with VS: long version

mod4_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                              AGE.c + SEX.c +  IQ.c +
                              reward_setback_VS + 
                              ( 1 + Trial_Number.c | SUBJECTID), 
                            family = bernoulli(link = "logit"),  
                            data = beh_scan_comp_long, cores = 4) 
save(mod4_VS_long_brms, file = "brms_models/mod4_VS_long_brms.Rdata")

### Model 4 with vmPFC: long version

mod4_vmPFC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c + 
                           AGE.c + SEX.c +  IQ.c +
                           reward_setback_vmPFC + 
                           ( 1 + Trial_Number.c | SUBJECTID), 
                         family = bernoulli(link = "logit"),  
                         data = beh_scan_comp_long, cores = 4) 
save(mod4_vmPFC_long_brms, file = "brms_models/mod4_vmPFC_long_brms.Rdata")


### Model 4 with mPFC: long version

mod4_mPFC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c + 
                              AGE.c + SEX.c +  IQ.c +
                              reward_setback_mPFC + 
                              ( 1 + Trial_Number.c | SUBJECTID), 
                            family = bernoulli(link = "logit"),  
                            data = beh_scan_comp_long, cores = 4) 
save(mod4_mPFC_long_brms, file = "brms_models/mod4_mPFC_long_brms.Rdata")

