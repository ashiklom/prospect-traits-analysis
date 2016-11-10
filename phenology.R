source("common.R")

# Plot phenology
dat_yang <- dat[Project == "yang_pheno" & !is.na(DOY)] %>%
    .[,treeID := gsub("^(.*)_[[:digit:]]+$", "\\1", SampleName)]

cab_pheno <- ggplot(dat_yang) + 
    aes(x = DOY, y = Cab, group = treeID) +
    geom_line() + 
    aes(color = SpeciesCode) + 
    facet_wrap(~ Site, scales = "free") +
    scale_color_brewer(palette = "Set1")

png("figures/phenology.chlorophyll.png", width = 1200)
plot(cab_pheno)
dev.off()

car_pheno <- cab_pheno + aes(y = Car)

png("figures/phenology.carotenoids.png", width = 1000)
plot(car_pheno)
dev.off()

cw_pheno <- cab_pheno + aes(y = Cw)

png("figures/phenology.water.png")
plot(cw_pheno)
dev.off()

cm_pheno <- cw_pheno + aes(y = Cm)

png("figures/phenology.lma.png")
plot(cm_pheno)
dev.off()
