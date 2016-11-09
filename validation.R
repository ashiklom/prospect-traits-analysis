source("common.R")

trueline <- geom_abline(slope = 1, intercept = 0, linetype = "dashed")
fitline <- geom_smooth(aes(group = NA), method = "lm", se = FALSE,
                       linetype = "3111", color = "black")
                       

# Chlorophyll
plt_cab <- ggplot(dat[!is.na(leaf_chlorophyll_total)]) +
    aes(x = Cab, y = leaf_chlorophyll_total) +
    geom_point() + 
    trueline + fitline

png("figures/validation.chlorophyll.species.png")
plot(plt_cab + aes(color = SubClass))
dev.off()

png("figures/validation.chlorophyll.projsite.png")
plot(plt_cab + aes(color = interaction(Project, Site)))
dev.off()

# Carotenoids
plt_car <- ggplot(dat[!is.na(leaf_carotenoid_total)]) +
    aes(x = Car, y = leaf_carotenoid_total) + 
    geom_point() + 
    trueline +
    fitline + 
    xlim(0, 60)

png("figures/validation.carotenoid.species.png")
plot(plt_car + aes(color = SubClass))
dev.off()

png("figures/validation.carotenoid.projsite.png")
plot(plt_car + aes(color = interaction(Project, Site)))
dev.off()

# Leaf water content
plt_cw <- ggplot(dat[!is.na(leaf_water_content)]) + 
    aes(x = Cw * 10000, y = leaf_water_content) + 
    geom_point() + 
    trueline + 
    fitline + 
    xlim(0, 1000) + 
    ylim(0, 500)

png("figures/validation.water.species.png")
plot(plt_cw + aes(color = Class))
dev.off()

png("figures/validation.water.project.png")
plot(plt_cw + aes(color = Project))
dev.off()

# Leaf mass per area
plt_cm <- ggplot(dat[!is.na(leaf_mass_per_area)]) + 
    aes(x = Cm * 10000, y = leaf_mass_per_area) + 
    geom_point() + 
    trueline + 
    fitline + 
    xlim(0, 5000)

png("figures/validation.lma.species.png")
plot(plt_cm + aes(color = Class))
dev.off()
png("figures/validation.lma.project.png")
plot(plt_cm + aes(color = Project))
dev.off()
