# Aim 2B: predicting WSLS behavior from brain stuff  
# Load scanning data 
# Remove outliers 
# remember to include all random effects! 

library(tidyverse)
library(brms)

# long version, by trial for WSLS
load("../../../2_cleaning_QC/cleaned_data/COMPS_ONLY/beh_scan_comp_long_WSLS.Rdata")
# open outlier tables
load("../tables/Choice_betas_outlier_subjects.Rdata")
load("../tables/Feedback_betas_outlier_subjects.Rdata")
load("../tables/hard_FB_contrast_betas_outlier_subjects.Rdata")

beh_scan_comp_long_WSLS <- beh_scan_comp_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")  %>%
  # exclude outliers for FB  & hard_FB_contrast 
  # removing PA067 becayse they are outlier for all feedback phase 
  filter(SUBJECTID != "PA067") %>%
  # choice outlier subjects
  mutate(
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
         hard_setback_FB_vmPFC  = ifelse(SUBJECTID %in% hard_FB_outlier_subjects$SUBJECTID[hard_FB_outlier_subjects$ROI == "vmPFC"], NA, hard_setback_FB_vmPFC),
         hard_reward_FB_mPFC = ifelse(SUBJECTID %in% hard_FB_outlier_subjects$SUBJECTID[hard_FB_outlier_subjects$ROI == "mPFC"], NA, hard_reward_FB_mPFC))

### VMPFC MODELS 
### Hypothesis 5: with hard effort setbacks only 
WSLS_vmPFC_long_brms_hard_setbacks <- brm(stay_shift ~ hard_setback_FB_vmPFC + 
                                           AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                           (1 + Trial_Number.c| SUBJECTID), 
                                         family = bernoulli(link = "logit"),
                                         data = subset(beh_scan_comp_long_WSLS, 
                                                       Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                         control = list(adapt_delta  = .95))
save(WSLS_vmPFC_long_brms_hard_setbacks, file = "preregistration_model_results/mod5_WSLS_vmPFC_long_hard_setbacks.Rdata")


## Hypothesis 5: with hard reward-setback contrast 
WSLS_vmPFC_long_brms_hard_reward_setback <- brm(stay_shift ~ hard_reward_setback_FB_vmPFC + 
                                             AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                             (1 + Trial_Number.c| SUBJECTID), 
                                           family = bernoulli(link = "logit"),
                                           data = subset(beh_scan_comp_long_WSLS, 
                                                         Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                           control = list(adapt_delta  = .95))
save(WSLS_vmPFC_long_brms_hard_reward_setback, file = "preregistration_model_results/mod5_WSLS_vmPFC_long_hard_reward_setback.Rdata")

## Hypothesis 5: all setback trials (hard + easy)
WSLS_vmPFC_long_brms_all_setbacks <- brm(stay_shift ~ setback_vmPFC + 
                                            AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                            (1 + Trial_Number.c| SUBJECTID), 
                                          family = bernoulli(link = "logit"),
                                          data = subset(beh_scan_comp_long_WSLS, 
                                                        Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                         control = list(adapt_delta  = .95))
save(WSLS_vmPFC_long_brms_all_setbacks, file = "preregistration_model_results/mod5_WSLS_vmPFC_long_all_setbacks.Rdata")

## Hypothesis 5: with reward-setback contrast (hard + easy)
WSLS_vmPFC_long_brms_all_reward_setback <- brm(stay_shift ~ reward_setback_vmPFC + 
                                           AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                           (1 + Trial_Number.c| SUBJECTID), 
                                         family = bernoulli(link = "logit"),
                                         data = subset(beh_scan_comp_long_WSLS, 
                                                       Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                         control = list(adapt_delta  = .95))
save(WSLS_vmPFC_long_brms_all_reward_setback, file = "preregistration_model_results/mod5_WSLS_vmPFC_long_all_reward_setback.Rdata")


### MPFC MODELS 
### Hypothesis 5: with hard effort setbacks only 
WSLS_mPFC_long_brms_hard_setbacks <- brm(stay_shift ~ hard_setback_FB_mPFC + 
                                            AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                            (1 + Trial_Number.c| SUBJECTID), 
                                          family = bernoulli(link = "logit"),
                                          data = subset(beh_scan_comp_long_WSLS, 
                                                        Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                         control = list(adapt_delta  = .95))
save(WSLS_mPFC_long_brms_hard_setbacks, file = "preregistration_model_results/mod5_WSLS_mPFC_long_hard_setbacks.Rdata")


## Hypothesis 5: with hard reward-setback contrast 
WSLS_mPFC_long_brms_hard_reward_setback <- brm(stay_shift ~ hard_reward_setback_FB_mPFC + 
                                                  AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                                  (1 + Trial_Number.c| SUBJECTID), 
                                                family = bernoulli(link = "logit"),
                                                data = subset(beh_scan_comp_long_WSLS, 
                                                              Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                               control = list(adapt_delta  = .95))
save(WSLS_mPFC_long_brms_hard_reward_setback, file = "preregistration_model_results/mod5_WSLS_mPFC_long_hard_reward_setback.Rdata")

## Hypothesis 5: all setback trials (hard + easy)
WSLS_mPFC_long_brms_all_setbacks <- brm(stay_shift ~ setback_mPFC + 
                                           AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                           (1 + Trial_Number.c| SUBJECTID), 
                                         family = bernoulli(link = "logit"),
                                         data = subset(beh_scan_comp_long_WSLS, 
                                                       Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                        control = list(adapt_delta  = .95))
save(WSLS_mPFC_long_brms_all_setbacks, file = "preregistration_model_results/mod5_WSLS_mPFC_long_all_setbacks.Rdata")

## Hypothesis 5: with reward-setback contrast (hard + easy)
WSLS_mPFC_long_brms_all_reward_setback <- brm(stay_shift ~ reward_setback_mPFC + 
                                                 AGE.c + SEX.c +   Trial_Number.c + Reinforce_rate.c +  proportion_hard.c + 
                                                 (1 + Trial_Number.c| SUBJECTID), 
                                               family = bernoulli(link = "logit"),
                                               data = subset(beh_scan_comp_long_WSLS, 
                                                             Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"),
                                              control = list(adapt_delta  = .95))
save(WSLS_mPFC_long_brms_all_reward_setback, file = "preregistration_model_results/mod5_WSLS_mPFC_long_all_reward_setback.Rdata")

