source("common.R")

# Plot phenology
dat_yang <- dat[Project == "yang_pheno", 
           treeID := gsub("^(.*)_[[:digit:]]+$", "\\1", SampleName)]
plt_pheno <- ggplot(dat_yang[!is.na(Cab) & !is.na(DOY)]) + 
    aes(x = DOY, y = Cab, group = treeID) +
    geom_line() + 
    aes(color = Genus) + 
    facet_wrap(~ Site, scales = "free") +
    scale_color_brewer(palette = "Set1")

png("figures/chlorophyll.phenology.png", width = 1200)
plot(plt_pheno)
dev.off()

# Plot phenology
car_pheno <- ggplot(dat_yang[!is.na(Car) & !is.na(DOY)]) + 
    aes(x = DOY, y = Car, group = treeID) +
    geom_line() + 
    aes(color = Genus) + 
    facet_wrap(~ Site, scales = "free") +
    scale_color_brewer(palette = "Set1")

png("figures/carotenoid.phenology.png", width = 1000)
plot(car_pheno)
dev.off()
