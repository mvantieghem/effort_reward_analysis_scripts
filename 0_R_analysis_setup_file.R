#analysis set up files
library(kableExtra) # for pretty tables
library(tidyverse) # data cleaning
library(lmerTest) # linear mixed effects models
library(brms) # bayesian model
library(effects) # getting out effects of models 
library(corrplot) # for pretty correlation plots 
library(psycho) # for pretty correlation tables.
library(broom) # for tidy tables of models
library(gridExtra)# for combining ggplots into single figures
library(readxl) # reading in excel files easily 
library(haven) # read in spss files
library(Hmisc) # easy pairwise correlations with missing data
library(corrplot) # for pretty correlation plots
library(psych) # KMO function and other useful things
library(REdaS) # for diagnostic data checks before FA
library(knitr) # Required for knitting
library(papaja) # Required for APA template
library(citr) # Required for easy insertion of citations
library(broman) # Required for myround() function that doesn't truncate digits
library(psych) # Required to calculate Cronbach's alpha
library(cocron) # Required to statistically compare Cronbach's alphas
library(kableExtra) # Required for table styling
library(ggplot2) # Required for plotslibrary(interactions) # IN REVISION (DUE TO PACKAGE UPDATE): Required for Johnson-Neyman and simple slopes analyses
library(cowplot) # Required for sim_slopes
library(boot) # Required for bootstrapping CIs in mediation analysis
library(lavaan) # Required for mediation analyses
library(apaTables)
library(mediation) # for mediation analyses 
library(purrr) # for code from Dani Cosme for sensitivity analyses
library(cowplot)# for code from Dani Cosme for sensitivity analysis 

# Seed for random number generation
set.seed(1234)


# color scheme 
my_colors <-  scale_color_manual(values=c("#0006CC", "#CC0000", "black", "black"))
my_colors2 <- scale_fill_manual(values=c("#0006CC", "#CC0000","black", "black"))
dark_blue = "#0006CC"
dark_Red = "#CC0000"
  

# Functions
pval <- function(x) {
  if (x >= .05) {
    result <- "n.s."
  }
  else if (x < .05 & x >= .01) {
    result <- "p < .05"
  }
  else if (x < .01 & x >= .001) {
    result <- "p < .01"
  }
  else {
    result <- "p < .001"
  }
  return(result)
}  

  ######### lmer Version for simple slopes #######
  condslope.lmer.slopes <- function(x, z, c, y){
    #  condslope.lmer( "age1","GROUP", 0, Amyg_piecewise_orig)
    # x = name of x variable
    # z = name of z variable (moderator)
    # c = conditional value of z
    # y = reg object
    # lmer model must be in this order x + z + x*z
    # updated slightly by MVT on March 4, 2019 
    # bcause tidy doesn't work.
    
    out <- summary(y)
    xz <- paste(x, z, sep=":")
    #zx <- paste(z, x, sep = ":")
    w0.intercept <- fixef(y)["(Intercept)"] + fixef(y)[z]*c
    w1.slope <- fixef(y)[x] + fixef(y)[xz]*c 
    #y.cond <- w0.intercept + w1.slope*xvalue
    require(broom)
    modtidy <- data.frame(summary(y)$coef)
    modtidy$rownames <- rownames(modtidy)
    modtidy$df <- 100
    coef2.var <- subset(modtidy, rownames == x)$Std..Error^2
    coef4.var <- subset(modtidy, rownames == xz)$Std..Error^2
    out.vcov <- vcov(y)
    cond.se <- sqrt(coef2.var + (c) * (c) * coef4.var + 2 * (c) * out.vcov[x, xz])
    t.val <- w1.slope/cond.se
    p.val <- 2*(1-pt(abs(t.val), subset(modtidy, rownames == x)$df, lower.tail=T))
    lower95 <- w1.slope-qt(0.975, subset(modtidy, rownames == x)$df)*cond.se
    upper95 <- w1.slope+qt(0.975, subset(modtidy, rownames == x)$df)*cond.se
    # z.out <- z.test(w1.slope, sigma.x= cond.se)
    return(list(w0.intercept=round(w0.intercept, digits = 2), w1.slope=round(w1.slope, digits = 2),
                df = subset(modtidy, rownames == x)$df[1],
                t.val = round(t.val, digits = 2), p.val = round(p.val, digits = 3), 
                lower95 = round(lower95, digits = 2), 
                upper95 = round(upper95, digits = 2)))
  }
  

  ### round to 3 decimal places
  
  roundto3 <- function(x) {
    (ifelse(abs(x) < .01, 
            format(round(x, 3), nsmall = 3),
            format(round(x, 2), nsmall = 2)))
  }
  
  
  #### frequentist linear model reporting
  regtable <- function(model) {
    tidymod <- cbind(tidy(model), tidy(confint(model)))
    # citidy <- tidy(confint(model))
    tidymod$term <- row.names(tidymod)
    tidymod$var <- paste(model$terms)[2]
    tidymod$df <- model$df.residual
    colnames(tidymod) <- c("term", "estimate", "std.error", "t.value", 
                              "p.value", "term2", "lower", "upper", "var", "df")
    tidymod$p.round <- ifelse(tidymod$p.value < .001, "<.001", format(round(tidymod$p.value, digits =3), nsmall = 3))
    tidymod$estimate.round <-  format(round(tidymod$estimate, digits =2), nsmall = 2)
    tidymod$t.value.round <- format(round(tidymod$t.value, digits =2), nsmall = 2)
    tidymod$lower.round <- format(round(tidymod$lower, digits =2), nsmall = 2)
    tidymod$upper.round <- format(round(tidymod$upper, digits = 2), nsmall = 2)
    tidymod$std.error.round <- format(round(tidymod$std.error, digits = 2), nsmall = 2)
    tidymod$r <- sqrt(tidymod$t.value^2/(tidymod$t.value^2+tidymod$df))
    tidymod$err <- (1/sqrt(nobs(model)-3))
    tidymod$r.round <- format(round(tidymod$r, digits = 2), nsmall = 2)
    tidymod$err.round <- format(round(tidymod$err, digits = 2), nsmall = 2)
    tidymod2 <- dplyr::select(tidymod, var, term, estimate.round, std.error.round, t.value.round, df, p.round,
                                 lower.round, upper.round, r.round, err.round)
    colnames(tidymod2) <- c("var", "term", "estimate", "se", "t", "df", "p", "lwr", "upr", "r", "err")
    print(tidymod2)
  }
  
  ## lmer model reporting
  lmer_table <- function(model) {
    tidymod <- cbind(tidy(model), tidy(confint(model)))
    colnames(tidymod) <- c("effect", "group", "term", "estimate", "std.error", "t.value", "df", 
                              "p.value", "term2", "lower", "upper")
    tidymod$p.round <- ifelse(tidymod$p.value < .001, "<.001", format(round(tidymod$p.value, digits =3), nsmall = 3))
    tidymod$estimate.round <-  format(round(tidymod$estimate, digits =2), nsmall = 2)
    tidymod$t.value.round <- format(round(tidymod$t.value, digits =2), nsmall = 2)
    tidymod$lower.round <- format(round(tidymod$lower, digits =2), nsmall = 2)
    tidymod$upper.round <- format(round(tidymod$upper, digits = 2), nsmall = 2)
    tidymod$std.error.round <- format(round(tidymod$std.error, digits = 2), nsmall = 2)
    tidymod$r <- sqrt(tidymod$t.value^2/(tidymod$t.value^2+tidymod$df))
    tidymod$err <- (1/sqrt(nobs(model)-3))
    tidymod$r.round <- format(round(tidymod$r, digits = 2), nsmall = 2)
    tidymod$err.round <- format(round(tidymod$err, digits = 2), nsmall = 2)
    tidymod2 <- dplyr::select(tidymod, term, estimate.round, std.error.round, t.value.round, df, p.round,
                                 lower.round, upper.round, r.round, err.round)
    colnames(tidymod2) <- c("term", "estimate", "se", "t", "df", "p", "lwr", "upr", "r", "err")
    print(tidymod2)
  }
  

  #### brms bayesian mrel reporting
  
  blm_table <- function(model, id) {
    library(broom)
    modtidy <- as.data.frame(fixef(model))
    modtidy$term <- row.names(modtidy)
    modtidy$var <- colnames(model$data)[1]
    
    modtidy$Estimate <- ifelse(abs(modtidy$Estimate) < .01, format(round(modtidy$Estimate, 3), nsmall = 3),
                               format(round(modtidy$Estimate, 2), nsmall = 2))
    
    modtidy$SE <- ifelse(abs(modtidy$Est.Error) < .01, format(round(modtidy$Est.Error, 3), nsmall = 3),
                         format(round(modtidy$Est.Error, 2), nsmall =2))
    
    modtidy$Lower <- ifelse(abs(modtidy$Q2.5) < .01, format(round(modtidy$Q2.5, 3), nsmall = 3), 
                            format(round(modtidy$Q2.5, 2), nsmall = 2))
    
    
    modtidy$Upper <- ifelse(abs(modtidy$Q97.5) < .01, format(round(modtidy$Q97.5, 3), nsmall = 3), 
                            format(round(modtidy$Q97.5, 2), nsmall = 2))
    
    modtidy90 <- as.data.frame(fixef(model, prob = c(.05, .95)))
    modtidy$Lower90 <- ifelse(abs(modtidy90$Q5) < .01, format(round(modtidy90$Q5, 3), nsmall = 3), 
                              format(round(modtidy90$Q5, 2), nsmall = 2))
    
    modtidy$Upper90 <- ifelse(abs(modtidy90$Q95) < .01, format(round(modtidy90$Q95, 3), nsmall = 3), 
                              format(round(modtidy90$Q95, 2), nsmall = 2))
    
    modtidy$N_Subj <- ifelse( length(unique(model$data$id)) == 0, nrow(model$data), length(unique(model$data$id)))
    modtidy$N_Obs <- nobs(model)
    modtidy <- dplyr::select(modtidy, var, term, Estimate, SE, Lower, Upper, Lower90, Upper90, N_Subj, N_Obs)
    
    row.names(modtidy) <- c()
    return(modtidy)
    
  }
  
  
  #### helper function for generating in-line reporting of stats
  txt_lmer <- function(model, est) {
    # get the model into a nicer format
    
    tidymod <- cbind(tidy(model), tidy(confint(model)))
    colnames(tidymod) <- c("effect", "group", "term", "estimate", "std.error", "t.value", "df", 
                              "p.value", "term2", "lower", "upper")
    tidymod$p.round <- ifelse(tidymod$p.value < .001, "<.001", format(round(tidymod$p.value, digits =3), nsmall = 3))
    tidymod$estimate.round <-  format(round(tidymod$estimate, digits =2), nsmall = 2)
    tidymod$t.value.round <- format(round(tidymod$t.value, digits =2), nsmall = 2)
    tidymod$lower.round <- format(round(tidymod$lower, digits =2), nsmall = 2)
    tidymod$upper.round <- format(round(tidymod$upper, digits = 2), nsmall = 2)
    tidymod$std.error.round <- format(round(tidymod$std.error, digits = 2), nsmall = 2)
    tidymod$r <- sqrt(tidymod$t.value^2/(tidymod$t.value^2+tidymod$df))
    tidymod$err <- (1/sqrt(nobs(model)-3))
    tidymod$r.round <- format(round(tidymod$r, digits = 2), nsmall = 2)
    tidymod$err.round <- format(round(tidymod$err, digits = 2), nsmall = 2)
    tidymod <- dplyr::select(tidymod, term, estimate.round, std.error.round, t.value.round, df, p.round,
                                 lower.round, upper.round, r.round, err.round)
    colnames(tidymod) <- c("term", "estimate", "se", "t", "df", "p", "lwr", "upr", "r", "err")
    
  # format text
    b <- "*b* = "
    se <- "*SE* = "
    p <- "*p* = "
    lwr <- "95% CI ["
    upr <- "]"
    # pull out coefficeints
    bval <- tidymod %>%
      filter(term == est) %>%
      select(estimate)%>%
      as.numeric()
    seval <- tidymod %>%
      filter(term == est) %>%
      select(se)%>%
      as.numeric()
    lwrval <-tidymod %>%
      filter(term == est) %>%
      select(lwr)%>%
      as.numeric()
    uprval <- tidymod %>%
      filter(term == est) %>%
      select(upr)%>%
      as.numeric()
    pval <- tidymod %>%
      filter(term == est) %>%
      select(p) %>%
      as.numeric()
    
    # string together in text
    noquote(paste(b, ifelse(abs(bval) < .01, 
                            format(round(mean(bval), 3), nsmall = 3), 
                            format(round(mean(bval), 2), nsmall = 2)),
                  ", ",
                  p, ifelse(abs(pval) < .01, 
                            format(round(mean(pval), 3), nsmall = 3), 
                            format(round(mean(pval), 2), nsmall = 2)),
                  # se, ifelse(abs(mean(seval)) < .01, 
                  #            format(round(mean(seval), 3), nsmall = 3), 
                  #            format(round(mean(seval), 2), nsmall = 2)),
                  ", ", 
                  
                  lwr, ifelse(abs(lwrval) < .01, 
                              format(round(mean(lwrval), 3), nsmall = 3), 
                              format(round(mean(lwrval), 2), nsmall = 2)),
                  ", ", 
                  
                  ifelse(abs(uprval) < .01, 
                         format(round(mean(uprval), 3), nsmall = 3), 
                         format(round(mean(uprval), 2), nsmall = 2)),   upr,
                  
                  sep = ""))
    
    
  }
  

  