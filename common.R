suppressPackageStartupMessages({
    library(dtplyr)
    library(dplyr)
    library(data.table)
    library(ggplot2)
})

if (!interactive()) {
    png('/dev/null')
    on.exit(dev.off())
}

prospect_pars <- c('N', 'Cab', 'Car', 'Cw', 'Cm')

figdir <- 'figures'

dat <- readRDS('cleaned_data.rds') %>%
    filter(N.mu < 4) %>%
    .[leaf_mass_per_area < 0, leaf_mass_per_area := NA] %>%
    .[leaf_N_percent < 0, leaf_N_percent := NA] %>%
    .[leaf_C_percent < 0, leaf_C_percent := NA] %>%
    .[leaf_CN_ratio < 0, leaf_CN_ratio := NA] %>%
    .[leaf_water_potential < -98, leaf_water_potential := NA] %>%
    .[SubClass == '', SubClass := Class] %>%
    .[CanopyPosition %in% c("M", "B", 'bottom'), SunShade := 'shade'] %>%
    .[CanopyPosition %in% c('T', 'top'), SunShade := 'sun'] %>%
    .[Project == 'ngee_tropics', SunShade := 'sun'] %>%
    .[Project == 'ngee_arctic', SunShade := 'sun'] %>%
    .[Project == 'LOPEX' , SunShade := 'sun'] %>%
    .[Project == 'ANGERS', SunShade := 'sun'] %>%
    .[Project == 'ACCP', SunShade := 'sun']

