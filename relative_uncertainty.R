source('common.R')

rel_unc_names <- paste0(c('N', 'Cab', 'Car', 'Cw', 'Cm'), '.cv')

dat <- dat %>%
    .[, N.range := N.q975 - N.q25] %>%
    .[, Cab.range := Cab.q975 - Cab.q25] %>%
    .[, Car.range := Car.q975 - Car.q25] %>%
    .[, Cw.range := Cw.q975 - Cw.q25] %>%
    .[, Cm.range := Cm.q975 - Cm.q25] %>%
    .[, N.cv := N.range/N.mu] %>%
    .[, Cab.cv := Cab.range/Cab.mu] %>%
    .[, Car.cv := Car.range/Car.mu] %>%
    .[, Cw.cv := Cw.range/Cw.mu] %>%
    .[, Cm.cv := Cm.range/Cm.mu]

ggdens <- function(xval, aesval, ...) {
    ggplot(dat) + aes_string(x = xval) +
        geom_density(...) + 
        facet_wrap(aesval) +
        scale_color_brewer(palette = 'Set1') + 
        theme_bw()
}

#ggdens('N.range', 'Project') + xlim(0, 4)
#ggdens('Cab.range', 'Project') + xlim(0, 150)
#ggdens('Car.range', 'Project') + xlim(0, 75)
#ggdens('Cw.range', 'Project') + xlim(0, 0.05)
#ggdens('Cm.range', 'Project') + xlim(0, 0.05)

figdir <- 'figures'

if (!interactive()) png('/dev/null')
ggdens('N.cv', 'Project') + coord_cartesian(xlim = c(0,2)) + 
    geom_vline(xintercept = 1, linetype = 'dashed')
ggsave(file.path(figdir, 'cv.N.png'))
ggdens('Cab.cv', 'Project') + coord_cartesian(xlim = c(0,3)) + 
    geom_vline(xintercept = 1, linetype = 'dashed')
ggsave(file.path(figdir, 'cv.Cab.png'))
ggdens('Car.cv', 'Project') + coord_cartesian(xlim = c(0,5)) + 
    geom_vline(xintercept = 1, linetype = 'dashed')
ggsave(file.path(figdir, 'cv.Car.png'))
ggdens('Cw.cv', 'Project') + coord_cartesian(xlim = c(0,3)) + 
    geom_vline(xintercept = 1, linetype = 'dashed')
ggsave(file.path(figdir, 'cv.Cw.png'))
ggdens('Cm.cv', 'Project') + coord_cartesian(xlim = c(0,4)) + 
    geom_vline(xintercept = 1, linetype = 'dashed')
ggsave(file.path(figdir, 'cv.Cm.png'))
if (!interactive()) dev.off()
