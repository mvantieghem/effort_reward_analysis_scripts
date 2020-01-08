# brms models for looking at differences in actual effort
# using scanning-only data for primary analyses, because we are 100% sure which button box used 


# remmeber that paths are relative to project home, not current folder for R script 
source("0_R_analysis_setup_file.R")

# load all data with PCA added!
load("10_planned_analyses/COMP_ECA/2_Planned_Analyses/data/all_pacct_effort_data_with_PCA.rda")
# load specific button RT data reformatted 
load("10_planned_analyses/COMP_ECA/2_Planned_Analyses/data/button_RT_df.Rdata")


# 1. ECA effects on number of button presses during hard/easy tasks

## main effects 
key_count_mod_brms <- brm(effort_key_count ~ PC1_log + Effort_Choice.n +
                         AGE.c + SEX.c + 
                         Trial_Number.c + perceived_effort_ave + median_motor_RT_ave +  max_keys +
                         (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                       data = filter(button_RT_df, Effort_Choice != "Miss"), 
                     chains = 1, cores = 1)
save(key_count_mod_brms, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/effort_key_count_main_effects.Rdata")  



## PC1 x effort choice

key_count_mod_brms_PC1xe <- brm (effort_key_count ~ PC1_log*Effort_Choice.n + 
                               AGE.c + SEX.c + 
                               Trial_Number.c + perceived_effort_ave +  median_motor_RT_ave + max_keys + 
                               (1 + Effort_Choice.n  + Trial_Number.c | SUBJECTID),
                               data = filter(button_RT_df, Effort_Choice != "Miss"), 
                               chains = 1, cores = 1)

save(key_count_mod_brms_PC1xe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/effort_key_count_PC1xe.Rdata")


### PC1 log x  perceived effort ave 
key_count_mod_PC1xpe <- brm(effort_key_count ~ PC1_log*perceived_effort_ave + 
                                AGE.c + SEX.c + Effort_Choice.n +
                                Trial_Number.c +  median_motor_RT_ave + max_keys + 
                                (1 + Effort_Choice.n  + Trial_Number.c | SUBJECTID),
                              data = filter(button_RT_df, Effort_Choice != "Miss"), 
                              chains = 1, cores = 1)

save(key_count_mod_PC1xpe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/effort_key_count_PC1xpe.Rdata")


#2. ECA effects on overshoots (button press - max keys)

## main effect of condition (easy/hard) & motor speed on overshoots

overshoot_mod <- brm(effort_key_overshoot ~ PC1_log + Effort_Choice.n + 
                         AGE.c + SEX.c + 
                         Trial_Number.c + perceived_effort_ave + median_motor_RT_ave +
                         (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                       filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 
save(overshoot_mod, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/overshoot_main_effects.Rdata")



## PC1 X Effort effects on overshoot
overshoot_mod_PC1xe <- brm (effort_key_overshoot ~ PC1_log * Effort_Choice.n + 
                               AGE.c + SEX.c + 
                               Trial_Number.c + perceived_effort_ave + median_motor_RT_ave + 
                               (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                             filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 

save(overshoot_mod_PC1xe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/overshoot_PC1xe.Rdata")



## PC1 X perceived_Effort effects on overshoot: 

overshoot_mod_PC1xpe <- brm (effort_key_overshoot ~ PC1_log * perceived_effort_ave + Effort_Choice.n + 
                                AGE.c + SEX.c +
                                Trial_Number.c + median_motor_RT_ave + 
                                (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                              filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 

save(overshoot_mod_PC1xpe,file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/overshoot_PC1xpe.Rdata")


## PC1 X perceived_Effort X Effort Choice: 

overshoot_mod_PC1xpexe <- brm (effort_key_overshoot ~ PC1_log * perceived_effort_ave * Effort_Choice.n + 
                                  AGE.c + SEX.c +
                                  Trial_Number.c + median_motor_RT_ave + 
                                  (1 + Effort_Choice.n + Trial_Number.c  | SUBJECTID),
                                filter(button_RT_df, Effort_Choice != "Miss"), chains = 1, cores = 1) 

save(overshoot_mod_PC1xpexe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/overshoot_PC1xpexe.Rdata")


# 3. Reaction time during button presses. 

## main effects 
press_RT_mod <- brm(median_RT_button_press ~ PC1_log + Effort_Choice.n + 
                        AGE.c + SEX.c + median_motor_RT_ave + perceived_effort_ave + 
                        (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                      filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)

save(press_RT_mod, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/key_press_RT_main_effects.Rdata")

## age x choice interaction
press_RT_mod_axe <- brm (median_RT_button_press ~ PC1_log  + AGE.c  * Effort_Choice.n + 
                            + SEX.c + median_motor_RT_ave + perceived_effort_ave + 
                            (1 + Effort_Choice.n + Trial_Number.c| SUBJECTID),
                          filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)


save(press_RT_mod_axe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/key_press_RT_axe.Rdata")

## PC1 x choice
press_RT_mod_PC1xe <- brm (median_RT_button_press ~ PC1_log * Effort_Choice.n + 
                            AGE.c + SEX.c + median_motor_RT_ave + perceived_effort_ave + 
                            (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                          filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)


save(press_RT_mod_PC1xe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/key_press_RT_PC1xc.Rdata")


## PC1 x perceived effort 
press_RT_mod_PC1xpe <- brm (median_RT_button_press ~ PC1_log * perceived_effort_ave +
                              AGE.c + SEX.c + median_motor_RT_ave + Effort_Choice.n +  
                              (1 + Effort_Choice.n + Trial_Number.c | SUBJECTID),
                            filter(button_RT_df, Effort_Choice != "Miss"), cores = 1, chains = 1)

save(press_RT_mod_PC1xpe, file = "10_planned_analyses/COMP_ECA/2_Planned_Analyses/brms_models/results/actual_effort/key_press_RT_PC1xpe.Rdata")



