# brms models for COMP preregistration analyses - PART 2

# load libraries
library(brms)
library(tidyverse)


# Load data 
## only behavior
#from data_cleaning_for_analysis 
# long version, by trial 
load("cleaned_data_for_analysis/beh_comp_long.Rdata")
load("cleaned_data_for_analysis/beh_comp_long_WSLS.Rdata")
beh_scan_long_WSLS <- beh_comp_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")

## with scanning data 
# long version, by trial 
load("cleaned_data_for_analysis/beh_scan_comp_long.Rdata")
load("cleaned_data_for_analysis/beh_scan_comp_long_WSLS.Rdata")
beh_scan_comp_long_WSLS <- beh_scan_comp_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")


## Hypothesis 5: The degree of prefrontal modulation in response to setbacks will 
# correspond to lose-stay decision- making strategies

### Model 5 long version hard effort setbacks only 
#### reward vs. setback

WSLS_Amyg_long_brms_hard_setbacks <- brm(stay_shift ~ reward_setback_Amyg + 
                                           AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                           ( 1 + Trial_Number.c | SUBJECTID), 
                                         family = bernoulli(link = "logit"),
                                         data = subset(beh_scan_comp_long_WSLS, 
                                                       Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_Amyg_long_brms_hard_setbacks, file = "brms_models/WSLS_Amyg_long_hard_setbacks.Rdata")

#### VS 
WSLS_VS_long_brms_hard_setbacks <- brm(stay_shift ~ reward_setback_VS + 
                                         AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                         ( 1 + Trial_Number.c | SUBJECTID), 
                                       family = bernoulli(link = "logit"),
                                       data = subset(beh_scan_comp_long_WSLS, 
                                                     Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_VS_long_brms_hard_setbacks, file = "brms_models/WSLS_VS_long_brms_hard_setbacks.Rdata")

#### vmPFC 
WSLS_vmPFC_long_brms_hard_setbacks <- brm(stay_shift ~ reward_setback_vmPFC + 
                                            AGE.c + SEX.c +IQ.c +  Trial_Number.c +  
                                            ( 1 + Trial_Number.c | SUBJECTID), 
                                          family = bernoulli(link = "logit"),
                                          data = subset(beh_scan_comp_long_WSLS, 
                                                        Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_vmPFC_long_brms_hard_setbacks, file = "brms_models/WSLS_vmPFC_long_brms_hard_setbacks.Rdata")

#### mPFC 
WSLS_mPFC_long_brms_hard_setbacks <- brm(stay_shift ~ reward_setback_mPFC + 
                                           AGE.c + SEX.c + IQ.c +  Trial_Number.c +  
                                           ( 1 + Trial_Number.c | SUBJECTID), 
                                         family = bernoulli(link = "logit"),
                                         data = subset(beh_scan_comp_long_WSLS, 
                                                       Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_mPFC_long_brms_hard_setbacks, file = "brms_models/WSLS_mPFC_long_brms_hard_setbacks.Rdata")


#### reward conditin only. 

WSLS_Amyg_long_brms_hard_setbacks_reward_only <- brm(stay_shift ~ reward_Amyg + 
                                                       AGE.c + SEX.c + IQ.c +  Trial_Number.c +  
                                                       ( 1 + Trial_Number.c | SUBJECTID), 
                                                     family = bernoulli(link = "logit"),
                                                     data = subset(beh_scan_comp_long_WSLS, 
                                                                   Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_Amyg_long_brms_hard_setbacks_reward_only, file = "brms_models/WSLS_Amyg_long_brms_hard_setbacks_reward_only.Rdata")

#### VS 
WSLS_VS_long_brms_hard_setbacks_reward_only <- brm(stay_shift ~ reward_VS + 
                                                     AGE.c + SEX.c + IQ.c +  Trial_Number.c +  
                                                     ( 1 + Trial_Number.c | SUBJECTID), 
                                                   family = bernoulli(link = "logit"),
                                                   data = subset(beh_scan_comp_long_WSLS, 
                                                                 Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_VS_long_brms_hard_setbacks_reward_only, file = "brms_models/WSLS_VS_long_brms_hard_setbacks_reward_only.Rdata")


#### vmPFC 
WSLS_vmPFC_long_brms_hard_setbacks_reward_only <- brm(stay_shift ~ reward_vmPFC + 
                                                        AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                                        ( 1 + Trial_Number.c | SUBJECTID), 
                                                      family = bernoulli(link = "logit"),
                                                      data = subset(beh_scan_comp_long_WSLS, 
                                                                    Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_vmPFC_long_brms_hard_setbacks_reward_only, file = "brms_models/WSLS_vmPFC_long_brms_hard_setbacks_reward_only.Rdata")

#### mPFC 
WSLS_mPFC_long_brms_hard_setbacks_reward_only <- brm(stay_shift ~ reward_mPFC + 
                                                       AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                                       ( 1 + Trial_Number.c | SUBJECTID), 
                                                     family = bernoulli(link = "logit"),
                                                     data = subset(beh_scan_comp_long_WSLS, 
                                                                   Feedback_prior == "Setback" & Effort_Choice_prior == "Hard"))
save(WSLS_mPFC_long_brms_hard_setbacks_reward_only, file = "brms_models/WSLS_mPFC_long_brms_hard_setbacks_reward_only.Rdata")


### Model 5 long version with all conditions. 
#### reward vs. setback

WSLS_Amyg_long_brms_all <- brm(stay_shift ~ reward_setback_Amyg*Feedback_prior*Effort_Choice_prior + 
                                 AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                 ( 1 + Trial_Number.c + Feedback_prior*Effort_Choice_prior | SUBJECTID), 
                               family = bernoulli(link = "logit"),
                               data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_Amyg_long_brms_all, file = "brms_models/WSLS_Amyg_long_brms_all.Rdata")

WSLS_VS_long_brms_all <- brm(stay_shift ~ reward_setback_VS*Feedback_prior*Effort_Choice_prior + 
                               AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                               ( 1 + Trial_Number.c + Feedback_prior*Effort_Choice_prior | SUBJECTID), 
                             family = bernoulli(link = "logit"),
                             data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_VS_long_brms_all, file = "brms_models/WSLS_VS_long_brms_all.Rdata")

WSLS_vmPFC_long_brms_all <- brm(stay_shift ~ reward_setback_vmPFC*Feedback_prior*Effort_Choice_prior + 
                                  AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                  ( 1 + Trial_Number.c + Feedback_prior*Effort_Choice_prior | SUBJECTID), 
                                family = bernoulli(link = "logit"),
                                data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_vmPFC_long_brms_all, file = "brms_models/WSLS_vmPFC_long_brms_all.Rdata")


WSLS_mPFC_long_brms_all <- brm(stay_shift ~ reward_setback_mPFC*Feedback_prior*Effort_Choice_prior + 
                                 AGE.c + SEX.c + IQ.c + Trial_Number.c +  
                                 ( 1 + Trial_Number.c + Feedback_prior*Effort_Choice_prior | SUBJECTID), 
                               family = bernoulli(link = "logit"),
                               data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mPFC_long_brms_all, file = "brms_models/WSLS_mPFC_long_brms_all.Rdata")


# exploratory analyses 

## choice behavior without any brain stuff. 
### mod 1: Feedback x effort 
WSLS_mod1_brms <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior + 
                        Reinforce_rate.c + AGE.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                        (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      # 40 trials per subject
                      family = bernoulli(link = "logit"), 
                      data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"), cores = 4)
save(WSLS_mod1_brms, file = "brms_models/WSLS_mod1_brms.Rdata")

### mod1b: age interactions 

WSLS_mod1b_brms_age_int <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*AGE.c + 
                                 Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                 (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                               family = bernoulli(link = "logit"), 
                               data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod1b_brms_age_int, file = "brms_models/WSLS_mod1b_brms_age_int.Rdata")


### mod1c: trial N interactions

WSLS_mod1c_brms_trial_int <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*Trial_Number.c + 
                                   Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                   (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                 family = bernoulli(link = "logit"), 
                                 data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod1c_brms_trial_int, file = "brms_models/WSLS_mod1c_brms_trial_int.Rdata")


### mod2: perceived control, controlling for IQ. 

WSLS_mod2_brms_perceived_control <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*perceived_control + 
                        Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                        (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      family = bernoulli(link = "logit"), 
                      data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod2_brms_perceived_control, file = "brms_models/WSLS_mod2_brms_perceived_control.Rdata")


### mod3: perceived effort, controlling for motor skills.

WSLS_mod3_brms_perceived_effort <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*hard_effort + 
                                         motor_skills_hard + motor_skills_easy +
                                         Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                         (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                       family = bernoulli(link = "logit"), 
                                       data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod3_brms_perceived_effort, file = "brms_models/WSLS_mod3_brms_perceived_effort.Rdata")

### mod4: frustrated, controllign for motivation

WSLS_mod4_brms_frustrated <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*frustrated + motivated +
                                   Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                   (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                 family = bernoulli(link = "logit"), 
                                 data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod4_brms_frustrated, file = "brms_models/WSLS_mod4_brms_frustated.Rdata")

### mod4: motivation controllign for frustration

WSLS_mod4_brms_motivated <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*motivated + frustrated +
                                  Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                  (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                family = bernoulli(link = "logit"), 
                                data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod4_brms_motivated, file = "brms_models/WSLS_mod4_brms_motivated.Rdata")


### mod5: lose feeling, controlling for win feeling

WSLS_mod5_brms_lose_feeling <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*lose_feeling +  win_feeling +
                                     Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                     (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                   family = bernoulli(link = "logit"), 
                                   data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod5_brms_lose_feeling, file = "brms_models/WSLS_mod5_brms_lose_feeling.Rdata")

### mod5: win feeling, controlling for lose feeling

WSLS_mod5_brms_win_feeling <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior*win_feeling + lose_feeling +
                                    Reinforce_rate.c + SEX.c + IQ.c + Trial_Number.c + proportion_hard.c + 
                                    (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                  family = bernoulli(link = "logit"), 
                                  data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4)
save(WSLS_mod5_brms_win_feeling, file = "brms_models/WSLS_mod5_brms_win_feeling.Rdata")

