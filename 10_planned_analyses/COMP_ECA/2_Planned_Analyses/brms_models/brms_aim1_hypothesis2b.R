# BRMS  for ECA behavior models! 

# notes: only using SCAN SAMPLE HERE because confound with out-of-scanner kids.

# remmeber that paths are relative to project home, not current folder for R script 
source("0_R_analysis_setup_file.R")

# load all data with PCA added!
load("10_planned_analyses/COMP_ECA/1_PCA/data/all_pacct_effort_data_with_PCA.rda")


# remember to clean the data! 
beh_scan_ECA_long_WSLS <- beh_scan_ECA_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")



# WSLS Behavior ########

## 1. GROUP_ECA.x main effect: SIG
WSLS_mod1_g <- brm(stay_shift ~ GROUP_ECA.x + Feedback_prior * Effort_Choice_prior + 
                           AGE.c*Effort_Choice_prior + 
                           Trial_Number.c*Effort_Choice_prior + 
                           Reinforce_rate.c + SEX.c + proportion_hard.c + 
                           ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                          family = bernoulli(link = "logit"), 
                         data = beh_scan_ECA_long_WSLS,
                         cores = 4)
save(WSLS_mod1_g, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_g.Rdata")    

## GROUP_ECA.x x Feedback prior X Effort choice prior
WSLS_mod1_gxexf <- brm(stay_shift ~ GROUP_ECA.x * Feedback_prior * Effort_Choice_prior + 
                            AGE.c +
                            Trial_Number.c*Effort_Choice_prior + 
                            Reinforce_rate.c + SEX.c + proportion_hard.c + 
                            ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                            #(1 + Trial_Number.c | SUBJECTID),
                           family = bernoulli(link = "logit"), 
                          data = beh_scan_ECA_long_WSLS,
                          cores = 4)
save(WSLS_mod1_gxexf , file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_gxexf.Rdata")  

## GROUP_ECA.x x effort choice prior 
WSLS_mod1_gxe <- brm(stay_shift ~ GROUP_ECA.x *  Effort_Choice_prior + Feedback_prior + 
                         AGE.c + 
                         Trial_Number.c*Effort_Choice_prior + 
                         Reinforce_rate.c + SEX.c + proportion_hard.c + 
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_gxe , file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_gxe.Rdata")  


WSLS_mod1_gxa <- brm(stay_shift ~ GROUP_ECA.x * AGE.c + 
                         Feedback_prior*Effort_Choice_prior +
                         AGE.c + 
                         Trial_Number.c*Effort_Choice_prior + 
                         Reinforce_rate.c + SEX.c + proportion_hard.c + 
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_gxa, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_gxa.Rdata")  


WSLS_mod1_gxt <- brm(stay_shift ~ GROUP_ECA.x *Trial_Number.c + 
                       Feedback_prior*Effort_Choice_prior +
                       AGE.c + 
                       Trial_Number.c*Effort_Choice_prior + 
                       Reinforce_rate.c + SEX.c + proportion_hard.c + 
                       ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                     #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                     data = beh_scan_ECA_long_WSLS,
                     cores = 4)
save(WSLS_mod1_gxt, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_gxt.Rdata")  




## 2. PC1 main effect
WSLS_mod1_PC1 <- brm(stay_shift ~ PC1_log + 
                     Feedback_prior * Effort_Choice_prior + 
                     AGE.c + 
                     Trial_Number.c*Effort_Choice_prior + 
                     Reinforce_rate.c + SEX.c + proportion_hard.c + 
                     ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                     #(1 + Trial_Number.c | SUBJECTID),
                    family = bernoulli(link = "logit"), 
                   data = beh_scan_ECA_long_WSLS,
                   cores = 4)
save(WSLS_mod1_PC1, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_PC1.Rdata")  




## PC1 x effort x feedback
WSLS_mod1_PC1xexf <- brm(stay_shift ~ PC1_log * Effort_Choice_prior * Feedback_prior+ 
                      AGE.c + 
                      Trial_Number.c*Effort_Choice_prior + 
                      Reinforce_rate.c + SEX.c + proportion_hard.c + 
                      ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                      #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                    data = beh_scan_ECA_long_WSLS,
                    cores = 4)
save(WSLS_mod1_PC1xexf, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_PC1xexf.Rdata")  



## PC1 x effort
WSLS_mod1_PC1xe <- brm(stay_shift ~ PC1_log * Effort_Choice_prior + 
                      Feedback_prior*Effort_Choice_prior +
                      AGE.c + 
                      Trial_Number.c*Effort_Choice_prior + 
                      Reinforce_rate.c + SEX.c + proportion_hard.c + 
                      ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                    data = beh_scan_ECA_long_WSLS,
                    cores = 4)
save(WSLS_mod1_PC1xe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_PC1xe.Rdata")  


## PC1 x age 
WSLS_mod1_PC1xa <- brm(stay_shift ~ PC1_log * AGE.c + 
                         Feedback_prior*Effort_Choice_prior +
                         AGE.c + 
                         Trial_Number.c*Effort_Choice_prior + 
                         Reinforce_rate.c + SEX.c + proportion_hard.c + 
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_PC1xa, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_PC1xa.Rdata")  


## PC1 x Trial N 
WSLS_mod1_PC1xt <- brm(stay_shift ~ PC1_log * AGE.c + 
                         Feedback_prior*Effort_Choice_prior +
                         AGE.c + 
                         Trial_Number.c*Effort_Choice_prior + 
                         Reinforce_rate.c + SEX.c + proportion_hard.c + 
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_PC1xt, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_mod1_PC1xt.Rdata")  

## REACTION TIME ############


## 1. group effects
#does RT differ by past 4 conditions and the choice you make? 
# removed feedback x effort choice random effects, because crashed computer. 
WSLS_RT_mod1_g <- brm(key_resp_choice.rt ~ GROUP_ECA.x +
                        Feedback_prior*stay_shift
                        Effort_Choice_prior*stay_shift +
                        AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                        ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                        data = beh_scan_ECA_long_WSLS, 
                        chains = 1, cores = 1)

save(WSLS_RT_mod1_g, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_RT_mod1_g.Rdata")  

# now trryr Group x SS and remove the 3 way interaction 
WSLS_RT_mod1_gxss <- brm(key_resp_choice.rt ~ 
                        GROUP_ECA.x*stay_shift +
                        Feedback_prior + 
                        Effort_Choice_prior*stay_shift + 
                        AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                        ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                      data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_gxss, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_RT_mod1_gxss.Rdata")  



# now trryr Group x SS x effort 
WSLS_RT_mod1_gxssxe <- brm(key_resp_choice.rt ~ 
                           GROUP_ECA.x*stay_shift*Effort_Choice_prior +
                           Feedback_prior  +
                           #Effort_Choice_prior*stay_shift + 
                           AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                           ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                         data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_gxssxe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_RT_mod1_gxssxe.Rdata")  

## 2. cumulative ECA effects 
#does RT differ by past 4 conditions and the choice you make? 
# removed feedback x effort choice random effects, because crashed computer. 
WSLS_RT_mod1_PC1 <- brm(key_resp_choice.rt ~ PC1_log +
                        Feedback_prior*stay_shift + 
                      Effort_Choice_prior*stay_shift +
                        AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                        ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                      data = beh_scan_ECA_long_WSLS, 
                      chains = 1, cores = 1)

save(WSLS_RT_mod1_PC1, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_RT_mod1_PC1.Rdata")  

# now trryr Group x SS and remove the 3 way interaction 
WSLS_RT_mod1_PC1xss <- brm(key_resp_choice.rt ~ 
                           PC1_log*stay_shift +
                           Feedback_prior + 
                           Effort_Choice_prior*stay_shift + 
                           AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                           ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                         data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_PC1xss, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_RT_mod1_PC1xss.Rdata")  



# now trryr Group x SS x effort 
WSLS_RT_mod1_PC1xssxe <- brm(key_resp_choice.rt ~ 
                             PC1_log*stay_shift*Effort_Choice_prior +
                             Feedback_prior  +
                             #Effort_Choice_prior*stay_shift + 
                             AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                             ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                           data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_PC1xssxe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/aim1_hypothesis2b/WSLS_RT_mod1_PC1xssxe.Rdata")  



