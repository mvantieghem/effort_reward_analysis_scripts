# BRMS  for ECA behavior models! 

library(tidyverse)

library(readxl)
library(brms)


# Load data 
load("scripts/3_analyses/COMP_ECA/1_PCA/data/all_pacct_effort_data_with_PCA.rda")

# remember to clean the data! 
beh_ECA_long_WSLS <- beh_ECA_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")


## 1. Effect of GROUP on choices 
choice_mod1_brms <- brm(Effort_Choice.n ~ GROUP + Trial_Number.c +
                       AGE.c + SEX.c + Reinforce_rate.c +  #
                       (1 + Trial_Number.c | SUBJECTID), 
                      family = bernoulli(link = "logit"),
                     data = beh_ECA_long,
                     cores = 4)
save(choice_mod1_brms, file = "results/choice_mod1_brms.Rdata")  


## 2. Effect of PC1 on choice
choice_mod2_brms <- brm(Effort_Choice.n ~ PC1_sqrt + Trial_Number.c +
                       AGE.c + SEX.c + Reinforce_rate.c +  #
                       (1 + Trial_Number.c | SUBJECTID), 
                      family = bernoulli(link = "logit"),
                     data = beh_ECA_long,
                     cores = 4)
save(choice_mod2_brms, file = "results/choice_mod2_brms.Rdata")  


# Behavioral measures: WSLS

## 1. GROUP main effect: SIG
WSLS_mod1_brms <- brm(stay_shift ~ GROUP + Feedback_prior * Effort_Choice_prior + 
                           AGE.c*Effort_Choice_prior + 
                           Trial_Number.c*Effort_Choice_prior + 
                           Reinforce_rate.c + SEX.c + proportion_hard.c + 
                           ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                           #(1 + Trial_Number.c | SUBJECTID),
                          family = bernoulli(link = "logit"), 
                         data = beh_ECA_long_WSLS,
                         cores = 4)
save(WSLS_mod1_brms, file = "results/WSLS_mod1_brms.Rdata")    

## 1b. GROUP x Feedback prior X Effort choice prior
WSLS_mod1b_brms <- brm(stay_shift ~ GROUP * Feedback_prior * Effort_Choice_prior + 
                            AGE.c*Effort_Choice_prior + 
                            Trial_Number.c*Effort_Choice_prior + 
                            Reinforce_rate.c + SEX.c + proportion_hard.c + 
                            ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                            #(1 + Trial_Number.c | SUBJECTID),
                           family = bernoulli(link = "logit"), 
                          data = beh_ECA_long_WSLS,
                          cores = 4)
save(WSLS_mod1b_brms, file = "results/WSLS_mod1b_brms.Rdata")  



## 2. PCA Continuous measure of adversity 
WSLS_mod2_brms <- brm(stay_shift ~ PC1_sqrt + 
                     Feedback_prior * Effort_Choice_prior + 
                     AGE.c*Effort_Choice_prior + 
                     Trial_Number.c*Effort_Choice_prior + 
                     Reinforce_rate.c + SEX.c + proportion_hard.c + 
                     ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                     #(1 + Trial_Number.c | SUBJECTID),
                    family = bernoulli(link = "logit"), 
                   data = beh_ECA_long_WSLS,
                   cores = 4)
save(WSLS_mod2_brms, file = "results/WSLS_mod2_brms.Rdata")  




## 2b. 3 way 
WSLS_mod2b_brms <- brm(stay_shift ~ PC1_sqrt * Effort_Choice_prior * Feedback_prior+ 
                      AGE.c*Effort_Choice_prior + 
                      Trial_Number.c*Effort_Choice_prior + 
                      Reinforce_rate.c + SEX.c + proportion_hard.c + 
                      ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                      #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                    data = beh_ECA_long_WSLS,
                    cores = 4)
save(WSLS_mod2b_brms, file = "results/WSLS_mod2b_brms.Rdata")  



## 2c. way 
WSLS_mod2c_brms <- brm(stay_shift ~ PC1_sqrt * Effort_Choice_prior + 
                      Feedback_prior*Effort_Choice_prior +
                      AGE.c*Effort_Choice_prior + 
                      Trial_Number.c*Effort_Choice_prior + 
                      Reinforce_rate.c + SEX.c + proportion_hard.c + 
                      ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                    data = beh_ECA_long_WSLS,
                    cores = 4)
save(WSLS_mod2c_brms, file = "results/WSLS_mod2c_brms.Rdata")  


