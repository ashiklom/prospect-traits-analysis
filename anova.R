source("common.R")

lfit <- lm(Cab ~ Class + Class*xOrder + CanopyPosition + 
           Drought_Tolerance + Shade_Tolerance,
           dat)
lfit_anova <- anova(lfit)[, "Sum Sq"]
