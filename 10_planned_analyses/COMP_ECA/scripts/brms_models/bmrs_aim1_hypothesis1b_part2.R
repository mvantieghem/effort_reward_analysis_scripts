# brms models for Aim 1 hypothesis 1b
# using scanning-only data for primary analyses, because we are 100% sure which button box used 
# updating January to include more self-report measures 

# remmeber that paths are relative to project home, not current folder for R script 
#source("0_R_analysis_setup_file.R")
source("../../../../0_R_analysis_setup_file.R")


# load all data with PCA added!
#load("10_planned_analyses/COMP_ECA/2_Planned_Analyses/data/all_pacct_effort_data_with_PCA.rda")
load("../data/all_pacct_effort_data_with_PCA.rda")



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



