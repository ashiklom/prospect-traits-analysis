source("common.R")

ordinate <- function(pars, symbol = '.') {
    parlist <- c("N.mu", "Cab.mu", "Car.mu", "Cw.mu", 'Cm.mu', pars) 
    dat_trait <- dat[, parlist, with = FALSE] %>%
        .[complete.cases(.)]
    pca <- princomp(dat_trait, cor = TRUE)
    biplot(pca, xlabs = rep(symbol, nrow(dat_trait)))
}

png(file.path(figdir, 'ordination.CN.png'))
ordinate(c('leaf_C_percent', 'leaf_N_percent'))
dev.off()

dat %>% 
    filter(!is.na(leaf_deltaN15)) %>% 
    count()
png(file.path(figdir, 'ordination.dN15.png'))
ordinate(c('leaf_deltaN15'), 'x')
dev.off()

dat %>% 
    filter(!is.na(leaf_lignin_percent),
           !is.na(leaf_cellulose_percent)) %>%
    count()

png(file.path(figdir, 'ordination.lig_cell.png'))
ordinate(c('leaf_lignin_percent', 'leaf_cellulose_percent'), 'x')
dev.off()

dat %>% 
    filter(!is.na(leaf_protein_percent)) %>%
    count()

png(file.path(figdir, 'ordination.protein.png'))
ordinate(c('leaf_protein_percent'), 'x')
dev.off()

png(file.path(figdir, 'ordination.protein_N.png'))
ordinate(c('leaf_protein_percent', 'leaf_N_percent'), 'x')
dev.off()

dat %>%
    filter(!is.na(leaf_water_potential)) %>%
    count()

png(file.path(figdir, 'ordination.LWP.png'))
ordinate(c('leaf_water_potential'), '.')
dev.off()
