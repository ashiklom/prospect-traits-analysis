source("common.R")

parlist <- c("N", "Cab", "Car", "Cw", 'Cm', 
             'leaf_N_percent',
             'leaf_C_percent',
             'leaf_lignin_percent', 
             'leaf_cellulose_percent',
             'leaf_mass_per_area'
             )

dat_trait <- dat[, parlist, with = FALSE] %>%
    .[complete.cases(.)]

pca <- princomp(dat_trait, cor = TRUE)
biplot(pca)

