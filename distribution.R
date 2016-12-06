source("common.R")

ggdens <- function(xvar) {
    ggplot(dat) + 
        aes_string(x = xvar) +
        geom_density()
}

ggdens('N.mu') + xlim(0, 4)
ggdens('Cab.mu') + xlim(0, 150) 
ggdens('Car.mu') + xlim(0, 40)
ggdens('Cw.mu') + xlim(0, 0.06)
ggdens('Cm.mu') + xlim(0, 0.025)
