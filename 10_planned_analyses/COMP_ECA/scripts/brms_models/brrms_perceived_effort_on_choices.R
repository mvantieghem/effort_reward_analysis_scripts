# brms models for looking at perceived effort effects on choices and WSLS
# using scanning-only data for primary analyses, because we are 100% sure which button box used 
# won't need this soon. 

# remmeber that paths are relative to project home, not current folder for R script 
source("0_R_analysis_setup_file.R")

# load all data with PCA added!
load("10_planned_analyses/COMP_ECA/1_PCA/data/all_pacct_effort_data_with_PCA.rda")



## 3. mean perceived effort (hard + easy)


## interaction between group and perceived effort. 
perceived_effort_ave_choice_brms_gxpe <- brm(Effort_Choice.n ~ GROUP_ECA.x * perceived_effort_ave.c +  
                                                AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                                                (1 + Trial_Number.c | SUBJECTID), 
                                              family = bernoulli(link = "logit"),
                                              data = beh_scan_ECA_long,
                                              chains = 1, cores = 1)
save(perceived_effort_ave_choice_brms_gxpe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/perceived_effort/perceived_effort_ave_choice_brms_gxpe.Rdata")  

## main effects
perceived_effort_ave_choice_brms_g <- brm(Effort_Choice.n ~ GROUP_ECA.x + perceived_effort_ave.c +  
                                             AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                                             (1 + Trial_Number.c | SUBJECTID), 
                                           family = bernoulli(link = "logit"),
                                           data = beh_scan_ECA_long,
                                           chains = 1, cores = 1)
save(perceived_effort_ave_choice_brms_g, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/perceived_effort/perceived_effort_ave_choice_brms_g.Rdata")  


## interaction between PC1 and perceived effort. 
perceived_effort_ave_choice_brms_PC1xpe <- brm(Effort_Choice.n ~ PC1_log.c * perceived_effort_ave.c +  
                                                  AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                                                  (1 + Trial_Number.c | SUBJECTID), 
                                                family = bernoulli(link = "logit"),
                                                data = beh_scan_ECA_long,
                                                chains = 1, cores = 1)
save(perceived_effort_ave_choice_brms_PC1xpe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/perceived_effort/perceived_effort_ave_choice_brms_PC1xpe.Rdata")  

## main effects of PC1s
perceived_effort_ave_choice_brms_PC1 <- brm(Effort_Choice.n ~ PC1_log.c + perceived_effort_ave.c +  
                                               AGE.c + SEX.c + Reinforce_rate.c + Trial_Number.c +
                                               (1 + Trial_Number.c | SUBJECTID), 
                                             family = bernoulli(link = "logit"),
                                             data = beh_scan_ECA_long,
                                             chains = 1, cores = 1)
save(perceived_effort_ave_choice_brms_PC1, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/perceived_effort/perceived_effort_ave_choice_brms_PC1.Rdata")  


