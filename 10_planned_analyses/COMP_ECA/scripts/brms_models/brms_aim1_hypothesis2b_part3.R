# part 3: adding perceived control and effort to WSLS RT 

# remmeber that paths are relative to project home, not current folder for R script 
source("../../../../0_R_analysis_setup_file.R")

# load all data with PCA added!
load("../data/all_pacct_effort_data_with_PCA.rda")


# remember to clean the data! 
beh_scan_ECA_long_WSLS <- beh_scan_ECA_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")


## REACTION TIME ############

## 0. expore self-report measures 
WSLS_RT_mod1_full <- brm(key_resp_choice.rt ~ GROUP_ECA.x +
                           Feedback_prior*stay_shift + 
                           Effort_Choice_prior*stay_shift +
                           AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                           # all self-report
                           perceived_reinforce + perceived_control + 
                           lose_feeling + win_feeling + 
                           frustrated + motivated + 
                           perceived_effort_ave.c +  median_motor_RT_ave +
                           ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                         data = beh_scan_ECA_long_WSLS, 
                         chains = 1, cores = 1)

save(WSLS_RT_mod1_full, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_full.Rdata")  
# motivation is not significant
# perceived control and perceived effort are! 
# so we added those below. 


## 1. group effects
#does RT differ by past 4 conditions and the choice you make? 
# removed feedback x effort choice random effects, because crashed computer. 
WSLS_RT_mod1_g <- brm(key_resp_choice.rt ~ GROUP_ECA.x +
                        Feedback_prior*stay_shift + 
                        perceived_effort_ave + median_motor_RT_ave + perceived_control +
                        Effort_Choice_prior*stay_shift +
                        AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                        ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                      data = beh_scan_ECA_long_WSLS, 
                      chains = 1, cores = 1)

save(WSLS_RT_mod1_g, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_g.Rdata")  

# now trryr Group x SS and remove the 3 way interaction 
WSLS_RT_mod1_gxss <- brm(key_resp_choice.rt ~ 
                           GROUP_ECA.x*stay_shift +
                           perceived_effort_ave + median_motor_RT_ave + perceived_control +
                           Feedback_prior + 
                           Effort_Choice_prior*stay_shift + 
                           AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                           ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                         data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_gxss, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_gxss.Rdata")  



# now trryr Group x SS x effort 
WSLS_RT_mod1_gxssxe <- brm(key_resp_choice.rt ~ 
                             GROUP_ECA.x*stay_shift*Effort_Choice_prior +
                             Feedback_prior  +
                             perceived_effort_ave + median_motor_RT_ave + perceived_control +
                             #Effort_Choice_prior*stay_shift + 
                             AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                             ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                           data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_gxssxe, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_gxssxe.Rdata")  

## 2. cumulative ECA effects 
#does RT differ by past 4 conditions and the choice you make? 
# removed feedback x effort choice random effects, because crashed computer. 
WSLS_RT_mod1_PC1 <- brm(key_resp_choice.rt ~ PC1_log +
                          Feedback_prior*stay_shift + 
                          perceived_effort_ave + median_motor_RT_ave + perceived_control +
                          Effort_Choice_prior*stay_shift +
                          AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                          ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                        data = beh_scan_ECA_long_WSLS, 
                        chains = 1, cores = 1)

save(WSLS_RT_mod1_PC1, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_PC1.Rdata")  

# now trryr Group x SS and remove the 3 way interaction 
WSLS_RT_mod1_PC1xss <- brm(key_resp_choice.rt ~ 
                             PC1_log*stay_shift +
                             Feedback_prior + perceived_effort_ave + median_motor_RT_ave + perceived_control +
                             Effort_Choice_prior*stay_shift + 
                             AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                             ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                           data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_PC1xss, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_PC1xss.Rdata")  



# now trryr Group x SS x effort 
WSLS_RT_mod1_PC1xssxe <- brm(key_resp_choice.rt ~ 
                               PC1_log*stay_shift*Effort_Choice_prior +
                               Feedback_prior  + 
                               perceived_effort_ave + median_motor_RT_ave + perceived_control +
                               AGE.c +  Reinforce_rate.c + SEX.c + proportion_hard.c +  Trial_Number.c +
                               ( 1 + Trial_Number.c + Feedback_prior + Effort_Choice_prior | SUBJECTID), 
                             data = beh_scan_ECA_long_WSLS, chains = 1, cores = 1)

save(WSLS_RT_mod1_PC1xssxe, file = "results/aim1_hypothesis2b/WSLS_RT_mod1_PC1xssxe.Rdata")  



