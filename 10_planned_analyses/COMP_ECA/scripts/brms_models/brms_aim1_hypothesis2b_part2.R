# part 2: adding perceived reinforcement to decision-making 


# remmeber that paths are relative to project home, not current folder for R script 
source("../../../../0_R_analysis_setup_file.R")

# load all data with PCA added!
load("../data/all_pacct_effort_data_with_PCA.rda")


# remember to clean the data! 
beh_scan_ECA_long_WSLS <- beh_scan_ECA_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")



## is group effect still signififant when you include perceived reinforcement? 
WSLS_mod1_g_pr <- brm(stay_shift ~ GROUP_ECA.x + Feedback_prior * Effort_Choice_prior + 
                        Trial_Number.c*Effort_Choice_prior + 
                        perceived_effort_ave +  median_motor_RT_ave +
                        perceived_reinforce + 
                        Reinforce_rate.c + AGE.c + SEX.c + proportion_hard.c + 
                        ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      family = bernoulli(link = "logit"), 
                      data = beh_scan_ECA_long_WSLS,
                      chains = 1, cores = 1)
save(WSLS_mod1_g_pr, file = "results/aim1_hypothesis2b/WSLS_mod1_g_pr.Rdata") 


## is group effect still signififant when you include perceived reinforcement? 
WSLS_mod1_gxe_pr <- brm(stay_shift ~ GROUP_ECA.x*Effort_Choice_prior +
                        Feedback_prior * Effort_Choice_prior + 
                        Trial_Number.c*Effort_Choice_prior + 
                        perceived_effort_ave +  median_motor_RT_ave +
                        perceived_reinforce + 
                        Reinforce_rate.c + AGE.c + SEX.c + proportion_hard.c + 
                        ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      family = bernoulli(link = "logit"), 
                      data = beh_scan_ECA_long_WSLS,
                      chains = 1, cores = 1)
save(WSLS_mod1_gxe_pr, file = "results/aim1_hypothesis2b/WSLS_mod1_gxe_pr.Rdata") 


## what about including perceived reinforcement? stille ffect of PC1? 
WSLS_mod1_PC1_pr <- brm(stay_shift ~ PC1_log + 
                          Feedback_prior * Effort_Choice_prior + 
                          Trial_Number.c*Effort_Choice_prior + 
                           perceived_effort_ave + median_motor_RT_ave +
                          perceived_reinforce + 
                          Reinforce_rate.c+ AGE.c + SEX.c + proportion_hard.c +
                          ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                        #(1 + Trial_Number.c | SUBJECTID),
                        family = bernoulli(link = "logit"), 
                        data = beh_scan_ECA_long_WSLS,
                        chains = 1, cores = 1)
save(WSLS_mod1_PC1_pr, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1_pr.Rdata")  

## PC1 x effort controlling for perceived reinforcement 
WSLS_mod1_PC1xe_pr <- brm(stay_shift ~ PC1_log * Effort_Choice_prior + 
                            Feedback_prior * Effort_Choice_prior + 
                            Trial_Number.c*Effort_Choice_prior + 
                            perceived_effort_ave + median_motor_RT_ave +
                            perceived_reinforce + 
                            Reinforce_rate.c+ AGE.c + SEX.c + proportion_hard.c +  ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                          #(1 + Trial_Number.c | SUBJECTID),
                          family = bernoulli(link = "logit"), 
                          data = beh_scan_ECA_long_WSLS,
                          chains = 1, cores = 1)
save(WSLS_mod1_PC1xe_pr, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1xe_pr.Rdata") 
