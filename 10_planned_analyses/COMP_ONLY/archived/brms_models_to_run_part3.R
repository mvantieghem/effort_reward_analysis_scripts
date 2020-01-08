#brms models to run - part 3


# load libraries
library(brms)
library(tidyverse)


# Load data 
## RT data.
load("cleaned_data_for_analysis/beh_comp_long_RT.Rdata")
load("cleaned_data_for_analysis/beh_comp_long_WSLS_RT.Rdata")
beh_comp_long_WSLS_RT <- beh_comp_long_WSLS_RT %>%
  filter(Feedback_prior != "Too_slow")


## RT based on choices 
RT_mod1_brms <- brm(key_resp_choice.rt ~ Effort_Choice + AGE.c + SEX.c + IQ.c + Trial_Number.c +
                  motor_skills_hard + motor_skills_easy + version + 
                  (1 + Trial_Number.c | SUBJECTID), cores = 4,
                  data = beh_comp_long_RT)
save(RT_mod1_brms, file = "brms_models/RT_mod1_brms.Rdata")

### RT based on WSLS
RT_mod2_brms <- brm(key_resp_choice.rt ~ Effort_Choice_prior * Feedback_prior + stay_shift.coded +
                  AGE.c + SEX.c + Trial_Number.c +
                  motor_skills_hard + motor_skills_easy + version + 
                  (1 + EFfort_choice_prior*Feedback_prior + Trial_Number.c | SUBJECTID), cores = 4,
                  data = beh_comp_long_WSLS_RT)
save(RT_mod2_brms, file = "brms_models/RT_mod2_brms.Rdata")

