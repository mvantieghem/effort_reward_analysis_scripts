# Basic behavior assessments
# Preregistered ANALYSES with brms 
# re-doing this November 27, 2019 

# load libraries
library(brms)
library(tidyverse)


# Load data 
## only behavior
#from data_cleaning_for_analysis 
# long version, by trial 

load("scripts/2_cleaning_QC/cleaned_data/COMPS_ONLY/beh_comp_long.Rdata")
load("scripts/2_cleaning_QC/cleaned_data/COMPS_ONLY/beh_comp_long_WSLS.Rdata")
beh_scan_long_WSLS <- beh_comp_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")


## CHOICE BEHAVIOR

## 1. depletion over time: Effect of time? NS.
## re-run because this didn't work!! 
choice_mod1_brms <- brm(Effort_Choice.n ~  
                       Trial_Number.c + AGE.c + SEX.c + Reinforce_rate.c +  #
                       (1 + Trial_Number.c | SUBJECTID), 
                     family = bernoulli(link = "logit"),
                     data = beh_comp_long,
                     cores = 4)
save(choice_mod1_brms, file = "scripts/3_analyses/COMP_ONLY/brms_models/preregistration_model_results/choice_mod1_brms.Rdata")




## 1b. Effect of Age X time?  NS

choice_mod1_ageint <- brm(Effort_Choice.n ~  
                              Trial_Number.c * AGE.c + SEX.c + Reinforce_rate.c + #
                              (1 + Trial_Number.c | SUBJECTID), 
                            family = bernoulli(link = "logit"),
                            data = beh_comp_long,
                            cores = 4)
save(choice_mod1_ageint, file = "scripts/3_analyses/COMP_ONLY/brms_models/preregistration_model_results/choice_mod1_ageint_brms.Rdata")


# WSLS (without too slow)
### mod 1: Feedback x effort: NS 
WSLS_mod2_brms <- brm(stay_shift ~ Feedback_prior * Effort_Choice_prior + 
                        Reinforce_rate.c + AGE.c + SEX.c +   Trial_Number.c + proportion_hard.c + 
                        (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      # 40 trials per subject
                      family = bernoulli(link = "logit"), 
                      data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"), cores = 4, adapt_delta = 0.9)
save(WSLS_mod2_brms, file = "scripts/3_analyses/COMP_ONLY/brms_models/preregistration_model_results/WSLS_mod2_brms.Rdata")

### mod1b: age x effort: SIG

WSLS_mod2b_brms_age_int <- brm(stay_shift ~ Feedback_prior + Effort_Choice_prior*AGE.c + 
                                 Reinforce_rate.c + SEX.c +   Trial_Number.c + proportion_hard.c + 
                                 (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                               family = bernoulli(link = "logit"), 
                               data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),
                               # adding this because divergent transitions after warmup
                               control = list(adapt_delta  = .95))
save(WSLS_mod2b_brms_age_int, file = "scripts/3_analyses/COMP_ONLY/brms_models/preregistration_model_results/WSLS_mod2b_brms_age_int.Rdata")


### mod1c: trial N interactions x effort: SIG
# but re-run because divergent transitions...meaning didn't converge properly.

WSLS_mod2c_brms_trial_int <- brm(stay_shift ~ Feedback_prior + Effort_Choice_prior*Trial_Number.c + 
                                   Reinforce_rate.c + SEX.c +   Trial_Number.c + proportion_hard.c + 
                                   (Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                                 family = bernoulli(link = "logit"), 
                                 data = subset(beh_comp_long_WSLS, Feedback_prior != "Too_slow"),cores = 4, 
                                 # adding this because divergent transitions after warmup
                                 control = list(adapt_delta  = .95))
save(WSLS_mod2c_brms_trial_int, file = "scripts/3_analyses/COMP_ONLY/brms_models/preregistration_model_results/WSLS_mod2c_brms_trial_int.Rdata")

