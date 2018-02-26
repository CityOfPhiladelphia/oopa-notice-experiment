# From https://code.analystinstitute.org/analyst_institute/aiEstimation/blob/master/R/power.R
binary_se <- function(sample_size,
                      base_level = 0.5, r_sq = 0.2, percent_treat = 0.5){
  
  stopifnot(is.numeric(base_level), is.numeric(r_sq),
            is.numeric(percent_treat), is.numeric(sample_size),
            percent_treat < 1, percent_treat > 0, r_sq < 1, r_sq >= 0,
            base_level > 0, base_level < 1)
  
  nom <- base_level * (1 - base_level) * (1 - r_sq)
  denom <- percent_treat * (1 - percent_treat) * sample_size
  sqrt(nom/denom)
}

effect_samp <- function(total_n, design_effect = 1, collect_rate = 1){
  
  stopifnot(is.numeric(total_n), is.numeric(design_effect),
            is.numeric(collect_rate), total_n > 0, design_effect > 0,
            collect_rate <= 1, collect_rate > 0)
  
  total_n * collect_rate / design_effect
}


powerb <- function(total_n, percent_treat = 0.5, 
                   base_level = 0.5, collect_rate = 1, 
                   r_sq = 0.2, tar = 1, design_effect = 1, 
                   conf_int = 0.9, desired_power = 0.8, 
                   ...){
  
  stopifnot(conf_int > 0, conf_int < 1, 
            desired_power > 0, desired_power < 1,
            tar > 0, tar <= 1)
  
  # Calculate effective sample size
  ess <- effect_samp(total_n = total_n, design_effect = design_effect, 
                     collect_rate = collect_rate)
  
  # Calculate SE
  se <- binary_se(base_level = base_level, r_sq = r_sq, 
                  percent_treat = percent_treat, sample_size = ess)
  
  # Calculate MDE
  mde <- se * (qnorm(desired_power) + qnorm(0.5 + conf_int/2))
  
  # Results
  list(
    `effective sample size` = ess,
    `percent in treatment` = percent_treat,
    `intent to treat MDE` = mde,
    `treatment on treated MDE` = mde/tar,
    `% change of ITT MDE over baseline` = mde/base_level, 
    `standard error` = se,
    `universe size` = total_n,
    `design effect` = design_effect,
    `outcome collection rate` = collect_rate,
    `outcome in control` = base_level,
    `treatment application rate` = tar,
    `covariate predictive power` = r_sq,
    `confidence interval` = conf_int,
    `power` = desired_power,
    method = 'Power calculations for a binary outcome'
  )
}
