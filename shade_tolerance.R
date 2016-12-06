source("common.R")

shadetol <- function(yval) {
    q25 <- function(x) quantile(x, 0.025, na.rm=TRUE)
    q975 <- function(x) quantile(x, 0.975, na.rm=TRUE)
    input <- dat %>%
        filter(!is.na(dat[, yval]),
               !is.na(shade_tolerance_numeric)) %>%
        group_by(SpeciesCode) %>%
        select_(yval, "shade_tolerance_numeric") %>%
        summarize_all(c('mean', 'q25', 'q975'))
    ggplot(input) + 
        aes(x = shade_tolerance_numeric_mean) +
        aes_string(y = paste0(yval, "_mean"),
                   ymin = paste0(yval, "_q25"),
                   ymax = paste0(yval, "_q975")) +
        geom_pointrange() + 
        geom_smooth(method = 'lm')
}

for (p %in% prospect_pars) {
    yval <- paste0(p, '.mu')
    fname <- paste0('shadetol.', p, '.png')
    shadetol(yval)
    ggsave(file.path(figdir, fname))
}
