source('common.R')

library(corrplot)

dat4pairs <- dat %>%
    select(ends_with(".mu")) %>%
    filter(N.mu < 4)

png(file.path(figdir, "pairs.png"))
pairs(dat4pairs, pch = '.')
dev.off()

png(file.path(figdir, "correlation.png"))
corrplot.mixed(cor(dat4pairs), lower = 'ellipse', upper = 'number')
dev.off()

