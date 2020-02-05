# brms models for looking at differences in actual effort
# using scanning-only data for primary analyses, because we are 100% sure which button box used 
# updating January to include more self-report measures 


# remmeber that paths are relative to project home, not current folder for R script 
source("../../../../0_R_analysis_setup_file.R")

# load all data with PCA added!
load("../data/all_pacct_effort_data_with_PCA.rda")
# load specific button RT data reformatted 
load("../data/button_RT_df.Rdata")


# 1. ECA effects on number of button presses during hard/easy tasks
## exploratory with self-report measures 
key_count_mod_brms_full <- brm(effort_key_count ~ PC1_log + Effort_Choice.n +
                            AGE.c + SEX.c +  Trial_Number.c + max_keys +
                              perceived_reinforce + perceived_control + 
                              lose_feeling + win_feeling + 
                              frustrated + motivated + 
                              perceived_effort_ave.c +  median_motor_RT_ave +
                            (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                          data = filter(button_RT_df, Effort_Choice != "Miss"), 
                          chains = 1, cores = 1)
save(key_count_mod_brms_full, file = "results/actual_effort/effort_key_count_brms_full.Rdata")  


## main effects 
key_count_mod_brms <- brm(effort_key_count ~ PC1_log + Effort_Choice.n +
                            AGE.c + SEX.c + Trial_Number.c +  max_keys +
                            motivated + perceived_effort_ave + median_motor_RT_ave + 
                         (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                       data = filter(button_RT_df, Effort_Choice != "Miss"), 
                     chains = 1, cores = 1)
save(key_count_mod_brms, file = "results/actual_effort/effort_key_count_main_effects.Rdata")  



## PC1 x effort choice

key_count_mod_brms_PC1xe <- brm (effort_key_count ~ PC1_log*Effort_Choice.n + 
                                   AGE.c + SEX.c + Trial_Number.c +  max_keys +
                                   motivated + perceived_effort_ave + median_motor_RT_ave + 
                               (1 + Effort_Choice.n  + Trial_Number.c | SUBJECTID),
                               data = filter(button_RT_df, Effort_Choice != "Miss"), 
                               chains = 1, cores = 1)

save(key_count_mod_brms_PC1xe, file = "results/actual_effort/effort_key_count_PC1xe.Rdata")


### PC1 log x  perceived effort ave 
key_count_mod_PC1xpe <- brm(effort_key_count ~ PC1_log*perceived_effort_ave + 
                              Effort_Choice.n + 
                              AGE.c + SEX.c + Trial_Number.c +  max_keys +
                              motivated + perceived_effort_ave + median_motor_RT_ave + 
                                (1 + Effort_Choice.n  + Trial_Number.c | SUBJECTID),
                              data = filter(button_RT_df, Effort_Choice != "Miss"), 
                              chains = 1, cores = 1)

save(key_count_mod_PC1xpe, file = "results/actual_effort/effort_key_count_PC1xpe.Rdata")


#2. ECA effects on overshoots (button press - max keys)

## exploratory with self-report measures 
overshoot_mod_full <- brm(effort_key_overshoot ~ PC1_log + Effort_Choice.n +
                                 AGE.c + SEX.c +  Trial_Number.c + 
                                 perceived_reinforce + perceived_control + 
                                 lose_feeling + win_feeling + 
                                 frustrated + motivated + 
                                 perceived_effort_ave.c +  median_motor_RT_ave +
                                 (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                               data = filter(button_RT_df, Effort_Choice != "Miss"), 
                               chains = 1, cores = 1)
save(overshoot_mod_full, file = "results/actual_effort/overshoot_mod_full.Rdata")  



## main effect of condition (easy/hard) & motor speed on overshoots

overshoot_mod <- brm(effort_key_overshoot ~ PC1_log + Effort_Choice.n + 
                       AGE.c + SEX.c + Trial_Number.c + 
                       motivated + perceived_effort_ave + median_motor_RT_ave +
                         (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                       filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 
save(overshoot_mod, file = "results/actual_effort/overshoot_main_effects.Rdata")


## PC1 X Effort effects on overshoot
overshoot_mod_PC1xe <- brm (effort_key_overshoot ~ PC1_log * Effort_Choice.n + 
                              AGE.c + SEX.c + Trial_Number.c +
                              motivated + perceived_effort_ave + median_motor_RT_ave +
                               (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                             filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 

save(overshoot_mod_PC1xe, file = "results/actual_effort/overshoot_PC1xe.Rdata")



## PC1 X perceived_Effort effects on overshoot: 

overshoot_mod_PC1xpe <- brm (effort_key_overshoot ~ PC1_log * perceived_effort_ave + Effort_Choice.n + 
                               AGE.c + SEX.c + Trial_Number.c +  
                               motivated + perceived_effort_ave + median_motor_RT_ave +
                                (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                              filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 

save(overshoot_mod_PC1xpe,file = "results/actual_effort/overshoot_PC1xpe.Rdata")


## PC1 X perceived_Effort X Effort Choice: 

overshoot_mod_PC1xpexe <- brm (effort_key_overshoot ~ PC1_log * perceived_effort_ave * Effort_Choice.n + 
                                 AGE.c + SEX.c + Trial_Number.c +  
                                 motivated + perceived_effort_ave + median_motor_RT_ave +
                                  (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                                filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 

save(overshoot_mod_PC1xpexe, file = "results/actual_effort/overshoot_PC1xpexe.Rdata")


# 3. Reaction time during button presses. 

## exploratory with self-report measures 
press_RT_mod_full <- brm(median_RT_button_press ~ PC1_log + Effort_Choice.n +
                                 AGE.c + SEX.c +  Trial_Number.c + max_keys +
                                 perceived_reinforce + perceived_control + 
                                 lose_feeling + win_feeling + 
                                 frustrated + motivated + 
                                 perceived_effort_ave.c +  median_motor_RT_ave +
                                 (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                               data = filter(button_RT_df, Effort_Choice != "Miss"), 
                               chains = 1, cores = 1)
save(press_RT_mod_full, file = "results/actual_effort/press_RT_mod_full.Rdata")  

## main effects 
press_RT_mod <- brm(median_RT_button_press ~ PC1_log + Effort_Choice.n + 
                      AGE.c + SEX.c + Trial_Number.c +  
                      motivated + perceived_effort_ave + median_motor_RT_ave +
                        (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                      filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)

save(press_RT_mod, file = "results/actual_effort/key_press_RT_main_effects.Rdata")

## age x choice interaction
press_RT_mod_axe <- brm (median_RT_button_press ~ PC1_log  + AGE.c  * Effort_Choice.n + 
                           AGE.c + SEX.c + Trial_Number.c +  
                           motivated + perceived_effort_ave + median_motor_RT_ave +
                            (1 + Effort_Choice.n + Trial_Number.c| SUBJECTID),
                          filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)


save(press_RT_mod_axe, file = "results/actual_effort/key_press_RT_axe.Rdata")

## PC1 x choice
press_RT_mod_PC1xe <- brm (median_RT_button_press ~ PC1_log * Effort_Choice.n +
                             AGE.c + SEX.c + Trial_Number.c +  max_keys +
                             motivated + perceived_effort_ave + median_motor_RT_ave +
                            (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                          filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)


save(press_RT_mod_PC1xe, file = "results/actual_effort/key_press_RT_PC1xc.Rdata")


## PC1 x perceived effort 
press_RT_mod_PC1xpe <- brm (median_RT_button_press ~ PC1_log * perceived_effort_ave +
                              Effort_Choice.n + 
                              AGE.c + SEX.c + Trial_Number.c +  max_keys +
                              motivated + perceived_effort_ave + median_motor_RT_ave + 
                              (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                            filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)

save(press_RT_mod_PC1xpe, file = "results/actual_effort/key_press_RT_PC1xpe.Rdata")



