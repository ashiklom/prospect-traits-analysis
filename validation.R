source('common.R')

validation <- function(prospect_param, trait, mult = 1) {
    dat_sub <- dat[!is.na(dat[[trait]])]
    dat_sub[[trait]] <- dat_sub[[trait]] * 1/mult
    plt <- ggplot(dat_sub) + 
        aes_string(x = paste0(prospect_param, ".mu"),
                   #xmin = paste0(prospect_param, ".q25"),
                   #xmax = paste0(prospect_param, ".q975"),
                   y = trait) + 
        geom_point(size = 1.5) +
        #geom_errorbarh(size = 0.5, alpha = 0.25) + 
        geom_abline(slope = 1, intercept = 0, linetype = "dashed") + 
        geom_smooth(aes(group = NA), method = "lm", se = FALSE, 
                    linetype = "3111", color = "black")
    return(plt)
}

# Chlorophyll
plt_cab <- validation("Cab", "leaf_chlorophyll_total")

plot(plt_cab + aes(color = SubClass))
ggsave(file.path(figdir, 'validation.Cab.class.png'))

plot(plt_cab + aes(color = interaction(Project, Site)))
ggsave(file.path(figdir, 'validation.Cab.project.png'))

# Carotenoids
plt_car <- validation("Car", "leaf_carotenoid_total")

plot(plt_car + aes(color = SubClass))
ggsave(file.path(figdir, 'validation.Car.class.png'))

plot(plt_car + aes(color = interaction(Project, Site)))
ggsave(file.path(figdir, 'validation.Car.project.png'))

# Leaf water content
plt_cw <- validation("Cw", "leaf_water_content", 10000) + 
    xlim(0, 0.06) + 
    ylim(0, 0.06)

plot(plt_cw + aes(color = Class))
ggsave(file.path(figdir, 'validation.Cw.class.png'))

plot(plt_cw + aes(color = Project))
ggsave(file.path(figdir, 'validation.Cw.project.png'))

# Leaf mass per area
plt_cm <- validation("Cm", "leaf_mass_per_area", 10000) + 
    xlim(0, 0.015) + 
    ylim(0, 0.025)

plot(plt_cm + aes(color = Class))
ggsave(file.path(figdir, 'validation.Cm.class.png'))

plot(plt_cm + aes(color = Project))
ggsave(file.path(figdir, 'validation.Cm.project.png'))

if (!interactive()) dev.off()
