# Aim 2A: predicting choice behavior from brain stuff. 
# Load data 
## scanning!
## removing outliers! 

library(tidyverse)
library(brms)
# long version, by trial, for choice data
load("../../../2_cleaning_QC/cleaned_data/COMPS_ONLY/beh_scan_comp_long.Rdata")
# open outlier tables
load("../tables/Choice_betas_outlier_subjects.Rdata")
load("../tables/Feedback_betas_outlier_subjects.Rdata")
load("../tables/hard_FB_contrast_betas_outlier_subjects.Rdata")

beh_scan_comp_long <- beh_scan_comp_long %>%
  # removing PA067 becayse they are outlier for all feedback phase 
  filter(SUBJECTID != "PA067") %>%
# choice outlier subjects
    mutate(choice_ACC = ifelse(SUBJECTID %in% choice_outlier_subjects$SUBJECTID[choice_outlier_subjects$ROI == "ACC"], NA, choice_ACC), 
         choice_VS = ifelse(SUBJECTID %in% choice_outlier_subjects$SUBJECTID[choice_outlier_subjects$ROI == "VS"], NA, choice_VS),
         choice_mPFC = ifelse(SUBJECTID %in% choice_outlier_subjects$SUBJECTID[choice_outlier_subjects$ROI == "mPFC"], NA, choice_mPFC),
         
         # FB outlier subjects
         reward_vmPFC = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "vmPFC"], NA, reward_vmPFC),
         reward_setback_vmPFC = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "vmPFC"], NA, reward_setback_vmPFC),
         
         reward_mPFC = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "mPFC"], NA, reward_mPFC),
         reward_setback_mPFC = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "mPFC"], NA, reward_setback_mPFC),
         
         reward_VS = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "VS"], NA, reward_VS),
         reward_setback_VS = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "VS"], NA, reward_setback_VS),
         
         reward_Amyg  = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "Amyg"], NA, reward_Amyg),
         reward_setback_Amyg = ifelse(SUBJECTID %in% FB_outlier_subjects$SUBJECTID[FB_outlier_subjects$ROI == "Amyg"], NA, reward_setback_Amyg),
         
         # hard FB contrast outlier subjects
         hard_setback_vmPFC  = ifelse(SUBJECTID %in% hard_FB_outlier_subjects$SUBJECTID[hard_FB_outlier_subjects$ROI == "vmPFC"], NA, hard_setback_FB_vmPFC),
         hard_reward_mPFC = ifelse(SUBJECTID %in% hard_FB_outlier_subjects$SUBJECTID[hard_FB_outlier_subjects$ROI == "mPFC"], NA, hard_reward_FB_mPFC))
         


# AIM 2A: CHOICES BRAIN + BEHAVIOR
## Hypothesis 3: choice reactivity in fronto-striatal (non ROI specific) will relate to proportion of effort choices 

### Model 3 for ACC: long version
mod3_ACC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                            AGE.c + SEX.c +   
                            choice_ACC + (1 + Trial_Number.c | SUBJECTID), 
                          family = bernoulli(link = "logit"), 
                          data = beh_scan_comp_long, cores = 4)
save(mod3_ACC_long_brms, file = "preregistration_model_results/mod3_ACC_long_brms.Rdata")


### mod 3 with mPFC: long version
mod3_mPFC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                             AGE.c + SEX.c +   
                             choice_mPFC + (1 + Trial_Number.c | SUBJECTID), 
                           family =bernoulli(link = "logit"),  
                           data = beh_scan_comp_long, cores = 4)
save(mod3_mPFC_long_brms, file = "preregistration_model_results/mod3_mPFC_long_brms.Rdata")

### mod 3 with VS: long version
mod3_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                           AGE.c + SEX.c +   
                           choice_VS +  (1 + Trial_Number.c | SUBJECTID), 
                         family = bernoulli(link = "logit"),  
                         data = beh_scan_comp_long, cores = 4)
save(mod3_VS_long_brms, file = "preregistration_model_results/mod3_VS_long_brms.Rdata")


## Hypothesis 4: Greater striatal response to rewards will be associated with a 
# greater proportion of hard-effort choices.

### Reward vs. setbacks all trials

mod4_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                           AGE.c + SEX.c +  
                           reward_setback_VS + 
                           ( 1 + Trial_Number.c | SUBJECTID), 
                         family = bernoulli(link = "logit"),  
                         data = beh_scan_comp_long, cores = 4) 
save(mod4_VS_long_brms, file = "preregistration_model_results/mod4_VS_long_brms.Rdata")


### hard rewards vs. hard setbacks

mod4_hard_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                                AGE.c + SEX.c +  
                                hard_reward_setback_VS + 
                                ( 1 + Trial_Number.c | SUBJECTID), 
                              family = bernoulli(link = "logit"),  
                              data = beh_scan_comp_long, cores = 4) 
save(mod4_hard_VS_long_brms, file = "preregistration_model_results/mod4_hard_VS_long_brms.Rdata")

### hard rewards only 

mod4_hard_reward_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                                AGE.c + SEX.c +  
                                hard_reward_VS + 
                                ( 1 + Trial_Number.c | SUBJECTID), 
                              family = bernoulli(link = "logit"),  
                              data = beh_scan_comp_long, cores = 4) 
save(mod4_hard_reward_VS_long_brms, file = "preregistration_model_results/mod4_hard_reward_VS_long_brms.Rdata")

### hard setbacks only 
mod4_hard_setback_VS_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c +
                                       AGE.c + SEX.c +  
                                       hard_setback_VS + 
                                       ( 1 + Trial_Number.c | SUBJECTID), 
                                     family = bernoulli(link = "logit"),  
                                     data = beh_scan_comp_long, cores = 4) 
save(mod4_hard_setback_VS_long_brms, file = "preregistration_model_results/mod4_hard_setback_VS_long_brms.Rdata")


######## FOLLOW UPS WITH OTHER REGIONS# ###########

### Model 4 with Amyg: long version

mod4_Amyg_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c + 
                             AGE.c + SEX.c +  
                             reward_setback_Amyg + 
                             ( 1 + Trial_Number.c | SUBJECTID), 
                           family = bernoulli(link = "logit"),  
                           data = beh_scan_comp_long, cores = 4) 
save(mod4_Amyg_long_brms, file = "preregistration_model_results/mod4_Amyg_long_brms.Rdata")




### Model 4 with vmPFC: long version

mod4_vmPFC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c + 
                              AGE.c + SEX.c +  
                              reward_setback_vmPFC + 
                              ( 1 + Trial_Number.c | SUBJECTID), 
                            family = bernoulli(link = "logit"),  
                            data = beh_scan_comp_long, cores = 4) 
save(mod4_vmPFC_long_brms, file = "preregistration_model_results/mod4_vmPFC_long_brms.Rdata")


### Model 4 with mPFC: long version

mod4_mPFC_long_brms <- brm(Effort_Choice.n ~ Reinforce_rate.c + Trial_Number.c + 
                             AGE.c + SEX.c +  
                             reward_setback_mPFC + 
                             ( 1 + Trial_Number.c | SUBJECTID), 
                           family = bernoulli(link = "logit"),  
                           data = beh_scan_comp_long, cores = 4) 
save(mod4_mPFC_long_brms, file = "preregistration_model_results/mod4_mPFC_long_brms.Rdata")


