# brms models for Aim 1 hypothesis 1b
# using scanning-only data for primary analyses, because we are 100% sure which button box used 
# updating January to include more self-report measures 

# remmeber that paths are relative to project home, not current folder for R script 
#source("0_R_analysis_setup_file.R")
source("../../../../0_R_analysis_setup_file.R")


# load all data with PCA added!
#load("10_planned_analyses/COMP_ECA/2_Planned_Analyses/data/all_pacct_effort_data_with_PCA.rda")
load("../data/all_pacct_effort_data_with_PCA.rda")

# choice behavior 
## 0. exploratory models with all possible self-report measures / covariates 

choice_mod1_brms_full <- brm(Effort_Choice.n ~ GROUP_ECA.x +
                               perceived_reinforce + perceived_control + 
                               lose_feeling + win_feeling + 
                               frustrated + motivated + 
                               perceived_effort_ave.c +
                               # CONFOUNDS
                               median_motor_RT_ave +
                               AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                               (1 + Trial_Number.c | SUBJECTID), 
                             family = bernoulli(link = "logit"),
                             data = beh_scan_ECA_long, 
                             cores = 1, chains = 1)
save(choice_mod1_brms_full, file = "results/aim1_hypothesis1b/choice_mod1_full.Rdata")  

## now moving forward, add only relevant covariates. 
choice_mod1_new <- brm(Effort_Choice.n ~ GROUP_ECA.x + perceived_effort_ave.c +  
                          median_motor_RT_ave + motivated + 
                               AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                               (1 + Trial_Number.c | SUBJECTID), 
                             family = bernoulli(link = "logit"),
                             data = beh_scan_ECA_long, 
                             cores = 1, chains = 1)
save(choice_mod1_new, file = "results/aim1_hypothesis1b/choice_mod1_new.Rdata")  

## interaction between group and perceived effort. 
choice_mod1_brms_gxpe <- brm(Effort_Choice.n ~ GROUP_ECA.x * perceived_effort_ave.c +  median_motor_RT_ave +
                                               AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                                               (1 + Trial_Number.c | SUBJECTID), 
                                             family = bernoulli(link = "logit"),
                                             data = beh_scan_ECA_long, 
                                             cores = 1, chains = 1)
save(choice_mod1_brms_gxpe, file = "results/aim1_hypothesis1b/choice_mod1_brms_gxpe.Rdata")  


## 2. Effect of PC1 on choice
choice_mod2_brms <- brm(Effort_Choice.n ~ PC1_log + Trial_Number.c +median_motor_RT_ave +
                          AGE.c + SEX.c + 
                          Reinforce_rate.c + perceived_effort_ave.c + #
                          (1 + Trial_Number.c | SUBJECTID), 
                        family = bernoulli(link = "logit"),
                        data = beh_scan_ECA_long, 
                        cores = 1, chains = 1)
save(choice_mod2_brms, file = "results/aim1_hypothesis1b/choice_mod2_brms.Rdata")  


## interaction between PC1 and perceived effort. 
choice_mod2_brms_PC1xpe <- brm(Effort_Choice.n ~ PC1_log * perceived_effort_ave.c +  median_motor_RT_ave +
                                                 AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                                                 (1 + Trial_Number.c | SUBJECTID), 
                                               family = bernoulli(link = "logit"),
                                               data = beh_scan_ECA_long,
                                               chains = 1, cores = 1)
save(choice_mod2_brms_PC1xpe, file = "results/aim1_hypothesis1b/choice_mod2_brms_PC1xpe.Rdata")  


# choice RT 

## 0. explre with additional covariates 
choice_RT_mod1_full <- brm(key_resp_choice.rt ~  perceived_reinforce + perceived_control + 
                             lose_feeling + win_feeling + 
                             frustrated + motivated + 
                             perceived_effort_ave.c +  median_motor_RT_ave +
                             AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                          (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                        data = beh_scan_ECA_long, 
                        cores = 1, chains = 1)

save(choice_RT_mod1_full, file = "results/aim1_hypothesis1b/choice_RT_mod1_full.Rdata")  


## 1. group effects
choice_RT_mod1_g <- brm(key_resp_choice.rt ~ GROUP_ECA.x + AGE.c  + Effort_Choice.n + SEX.c + 
                           Trial_Number.c + Reinforce_rate.c +
                          perceived_effort_ave.c + median_motor_RT_ave +
                           (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                         data = beh_scan_ECA_long, 
                        cores = 1, chains = 1)

save(choice_RT_mod1_g, file = "results/aim1_hypothesis1b/choice_RT_mod1_g.Rdata")  


choice_RT_mod1_gxa <- brm(key_resp_choice.rt ~ GROUP_ECA.x*AGE.c  + Effort_Choice.n + AGE.c + SEX.c + 
                             Trial_Number.c + Reinforce_rate.c +  
                            perceived_effort_ave.c +median_motor_RT_ave + #
                             (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                           data = beh_scan_ECA_long, 
                          cores = 1, chains = 1)

save(choice_RT_mod1_gxa, file = "results/aim1_hypothesis1b/choice_RT_mod1_gxa.Rdata")

choice_RT_mod1_gxc <- brm(key_resp_choice.rt ~ GROUP_ECA.x* Effort_Choice.n + AGE.c + SEX.c + 
                             Trial_Number.c + Reinforce_rate.c + 
                            perceived_effort_ave.c +median_motor_RT_ave +
                             (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                           data = beh_scan_ECA_long, 
                          cores = 1, chains = 1)

save(choice_RT_mod1_gxc, file = "results/aim1_hypothesis1b/choice_RT_mod1_gxc.Rdata")



choice_RT_mod1_gxpe <- brm(key_resp_choice.rt ~ GROUP_ECA.x*perceived_effort_ave.c + 
                            Effort_Choice.n + AGE.c + SEX.c + 
                            Trial_Number.c + Reinforce_rate.c +  median_motor_RT_ave +
                            (1 + Trial_Number.c + Effort_Choice.n  | SUBJECTID), 
                          data = beh_scan_ECA_long, 
                          cores = 1, chains = 1)
save(choice_RT_mod1_gxpe, file = "results/aim1_hypothesis1b/choice_RT_mod1_gxpe.Rdata")

### PART 2 run from here.

choice_RT_mod1_txe <- brm(key_resp_choice.rt ~ Effort_Choice.n *Trial_Number.c +
                            GROUP_ECA.x + perceived_effort_ave.c + 
                             AGE.c + SEX.c + 
                             Trial_Number.c + Reinforce_rate.c +  median_motor_RT_ave +
                             (1 + Trial_Number.c + Effort_Choice.n  | SUBJECTID), 
                           data = beh_scan_ECA_long, 
                           cores = 1, chains = 1)
save(choice_RT_mod1_txe, file = "results/aim1_hypothesis1b/choice_RT_mod1_txe.Rdata")


## 2. continous  ECA score
choice_RT_mod1_PC1 <- brm(key_resp_choice.rt ~ PC1_log + AGE.c  + Effort_Choice.n + SEX.c + 
                             Trial_Number.c + Reinforce_rate.c + 
                            perceived_effort_ave.c + median_motor_RT_ave +
                             (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                           data = beh_scan_ECA_long, 
                          cores = 1, chains = 1)
save(choice_RT_mod1_PC1,file = "results/aim1_hypothesis1b/choice_RT_mod1_PC1.Rdata")


choice_RT_mod1_PC1xa <- brm(key_resp_choice.rt ~ PC1_log*AGE.c  + Effort_Choice.n + AGE.c + SEX.c + 
                               Trial_Number.c + Reinforce_rate.c + 
                              perceived_effort_ave.c + median_motor_RT_ave +
                               (1 + Trial_Number.c + Effort_Choice.n| SUBJECTID), 
                             data = beh_scan_ECA_long, 
                            cores = 1, chains = 1)

save(choice_RT_mod1_PC1xa,file = "results/aim1_hypothesis1b/choice_RT_mod1_PC1xa.Rdata")


choice_RT_mod1_PC1xc <- brm(key_resp_choice.rt ~ PC1_log*Effort_Choice.n + AGE.c + SEX.c + 
                               Trial_Number.c + Reinforce_rate.c + 
                              perceived_effort_ave.c + median_motor_RT_ave +
                               (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                             data = beh_scan_ECA_long, 
                             cores = 1, chains = 1)
save(choice_RT_mod1_PC1xc, file = "results/aim1_hypothesis1b/choice_RT_mod1_PC1xc.Rdata")


choice_RT_mod1_PC1xpe <- brm(key_resp_choice.rt ~ PC1_log*perceived_effort_ave.c +
                                Effort_Choice + AGE.c + SEX.c + 
                               Trial_Number.c + Reinforce_rate.c + median_motor_RT_ave +
                               (1 + Trial_Number.c + Effort_Choice.n | SUBJECTID), 
                             data = filter(beh_scan_ECA_long), 
                             cores = 1, chains = 1)

save(choice_RT_mod1_PC1xpe, file = "results/aim1_hypothesis1b/choice_RT_mod1_PC1xpe.Rdata")





