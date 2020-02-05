# BRMS  for WSLS behavior models! 
# notes: only using SCAN SAMPLE HERE because confound with out-of-scanner kids.
# updating January to include more self-report measures 


# remmeber that paths are relative to project home, not current folder for R script 
source("../../../../0_R_analysis_setup_file.R")

# load all data with PCA added!
load("../data/all_pacct_effort_data_with_PCA.rda")


# remember to clean the data! 
beh_scan_ECA_long_WSLS <- beh_scan_ECA_long_WSLS %>%
  filter(Feedback_prior != "Too_slow")



# WSLS Behavior ########

## 0. explore role of self-report data 
WSLS_mod1_full <- brm(stay_shift ~ PC1_log.c + Feedback_prior * Effort_Choice_prior + 
                     Trial_Number.c*Effort_Choice_prior + 
                     Reinforce_rate.c + SEX.c + proportion_hard.c + 
                     perceived_reinforce + perceived_control + 
                     lose_feeling + win_feeling + 
                     frustrated + motivated + 
                     perceived_effort_ave.c +  median_motor_RT_ave +
                     ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                   family = bernoulli(link = "logit"), 
                   data = beh_scan_ECA_long_WSLS,
                   cores = 4)
save(WSLS_mod1_full, file = "results/aim1_hypothesis2b/WSLS_mod1_full.Rdata")    


## 1. GROUP_ECA.x main effect: SIG
#including self-report measures that are significant in above. 
WSLS_mod1_g <- brm(stay_shift ~ GROUP_ECA.x + Feedback_prior * Effort_Choice_prior + 
                           Trial_Number.c*Effort_Choice_prior + 
                            perceived_effort_ave +  median_motor_RT_ave +
                           Reinforce_rate.c + SEX.c + proportion_hard.c + 
                           ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                          family = bernoulli(link = "logit"), 
                         data = beh_scan_ECA_long_WSLS,
                         cores = 4)
save(WSLS_mod1_g, file = "results/aim1_hypothesis2b/WSLS_mod1_g.Rdata")    



## GROUP_ECA.x x Feedback prior X Effort choice prior
WSLS_mod1_gxexf <- brm(stay_shift ~ GROUP_ECA.x * Feedback_prior * Effort_Choice_prior + 
                            Trial_Number.c*Effort_Choice_prior + 
                         AGE.c + perceived_effort_ave + median_motor_RT_ave + 
                            Reinforce_rate.c + SEX.c + proportion_hard.c + 
                            ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                            #(1 + Trial_Number.c | SUBJECTID),
                           family = bernoulli(link = "logit"), 
                          data = beh_scan_ECA_long_WSLS,
                          cores = 4)
save(WSLS_mod1_gxexf , file = "results/aim1_hypothesis2b/WSLS_mod1_gxexf.Rdata")  

## GROUP_ECA.x x effort choice prior 
WSLS_mod1_gxe <- brm(stay_shift ~ GROUP_ECA.x *  Effort_Choice_prior +
                       Effort_Choice_prior* Feedback_prior + 
                       Trial_Number.c*Effort_Choice_prior + 
                         AGE.c + perceived_effort_ave + median_motor_RT_ave + 
                         Reinforce_rate.c + SEX.c + proportion_hard.c +
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_gxe , file = "results/aim1_hypothesis2b/WSLS_mod1_gxe.Rdata")  


WSLS_mod1_gxa <- brm(stay_shift ~ GROUP_ECA.x * AGE.c + 
                         Feedback_prior*Effort_Choice_prior +
                       Trial_Number.c*Effort_Choice_prior + 
                         AGE.c + perceived_effort_ave + median_motor_RT_ave + 
                         Reinforce_rate.c + SEX.c + proportion_hard.c + 
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_gxa, file = "results/aim1_hypothesis2b/WSLS_mod1_gxa.Rdata")  


WSLS_mod1_gxt <- brm(stay_shift ~ GROUP_ECA.x *Trial_Number.c + 
                       Feedback_prior*Effort_Choice_prior +
                       Trial_Number.c*Effort_Choice_prior + 
                       AGE.c + perceived_effort_ave + median_motor_RT_ave + 
                       Reinforce_rate.c + SEX.c + proportion_hard.c + 
                       ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                     #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                     data = beh_scan_ECA_long_WSLS,
                     cores = 4)
save(WSLS_mod1_gxt, file = "results/aim1_hypothesis2b/WSLS_mod1_gxt.Rdata")  




## 2. PC1 main effect
WSLS_mod1_PC1 <- brm(stay_shift ~ PC1_log + 
                     Feedback_prior * Effort_Choice_prior + 
                     AGE.c + perceived_effort_ave + median_motor_RT_ave +
                     Trial_Number.c*Effort_Choice_prior + 
                     Reinforce_rate.c + SEX.c + proportion_hard.c +
                     ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                     #(1 + Trial_Number.c | SUBJECTID),
                    family = bernoulli(link = "logit"), 
                   data = beh_scan_ECA_long_WSLS,
                   cores = 4)
save(WSLS_mod1_PC1, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1.Rdata")  



## PC1 x effort x feedback
WSLS_mod1_PC1xexf <- brm(stay_shift ~ PC1_log * Effort_Choice_prior * Feedback_prior+ 
                      Trial_Number.c*Effort_Choice_prior + 
                      AGE.c + perceived_effort_ave + median_motor_RT_ave + 
                        
                      Reinforce_rate.c + SEX.c + proportion_hard.c + 
                      ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID),
                      #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                    data = beh_scan_ECA_long_WSLS,
                    cores = 4)
save(WSLS_mod1_PC1xexf, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1xexf.Rdata")  



## PC1 x effort
WSLS_mod1_PC1xe <- brm(stay_shift ~ PC1_log * Effort_Choice_prior + 
                      Feedback_prior*Effort_Choice_prior +
                        Trial_Number.c*Effort_Choice_prior + 
                      AGE.c + perceived_effort_ave + median_motor_RT_ave + 
                      Reinforce_rate.c + SEX.c + proportion_hard.c +
                      ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                      #(1 + Trial_Number.c | SUBJECTID),
                     family = bernoulli(link = "logit"), 
                    data = beh_scan_ECA_long_WSLS,
                    cores = 4)
save(WSLS_mod1_PC1xe, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1xe.Rdata")  




## PC1 x age 
WSLS_mod1_PC1xa <- brm(stay_shift ~ PC1_log * AGE.c + 
                         Feedback_prior*Effort_Choice_prior +
                         Trial_Number.c*Effort_Choice_prior + 
                         
                         AGE.c + perceived_effort_ave + median_motor_RT_ave + motivated +
                         Reinforce_rate.c + SEX.c + proportion_hard.c +
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_PC1xa, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1xa.Rdata")  


## PC1 x Trial N 
WSLS_mod1_PC1xt <- brm(stay_shift ~ PC1_log * AGE.c + 
                         Feedback_prior*Effort_Choice_prior +
                         Trial_Number.c*Effort_Choice_prior + 
                         AGE.c + perceived_effort_ave + median_motor_RT_ave + motivated +
                         Reinforce_rate.c + SEX.c + proportion_hard.c +
                         ( 1 + Trial_Number.c + Feedback_prior * Effort_Choice_prior | SUBJECTID), 
                       #(1 + Trial_Number.c | SUBJECTID),
                       family = bernoulli(link = "logit"), 
                       data = beh_scan_ECA_long_WSLS,
                       cores = 4)
save(WSLS_mod1_PC1xt, file = "results/aim1_hypothesis2b/WSLS_mod1_PC1xt.Rdata")  
