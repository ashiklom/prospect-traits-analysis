source("common.R")

library(RColorBrewer)

do_anova <- function(dat, xvec, 
                     yvec = paste0(prospect_pars,'.mu')) {
    x_raw <- unique(unlist(strsplit(xvec, split = "[*:]")))
    dat_ind_mat <- sapply(x_raw, function(x) !is.na(dat[[x]]))
    dat_ind <- which(apply(dat_ind_mat, 1, all))
    x_string <- paste(xvec, collapse = " + ")
    anova_list <- list()
    for (y in yvec) {
        form_string <- sprintf("%s ~ %s", y, x_string)
        form <- formula(form_string)
        #yy <- as.matrix(model.frame(form, dat)[, y, drop = FALSE])
        #datm <- model.matrix(form, dat)
        #lanova <- fast.anova(x = datm, y = yy)
        #lfit <- fastLm(form, dat)
        #lfit <- fastLmPure(datm, yy)
        #lfit <- fastLm(X = datm, y = yy)
        lfit <- lm(form, dat)
        lanova <- anova(lfit)
        lcol <- lanova[, "Sum Sq", drop = FALSE]
        anova_list[[y]] <- lcol
    }
    anova_mat <- do.call(cbind, anova_list)
    colnames(anova_mat) <- names(anova_list)
    anova_dt <- as.data.table(anova_mat, keep.rownames = TRUE)
    setnames(anova_dt, "rn", "Predictor")
    anova_melt <- reshape2::melt(anova_dt, id.vars = "Predictor",
                                 value.name = "sum_of_squares")
    anova_melt <- anova_melt[, norm_sum_of_squares := 
                    sum_of_squares / sum(sum_of_squares), 
                    by = variable]
    anova_melt <- anova_melt[, Predictor := factor(Predictor,
                                                   levels = rev(c(xvec, "Residuals")))]
    return(anova_melt)
}

anova_plot <- function(anova_out) {
    plt <- ggplot(anova_out) + 
        aes(x = variable, y = norm_sum_of_squares, fill = Predictor) + 
        geom_bar(stat = "identity") + 
        theme_bw()
    return(plt)
}

# ANOVA based on Phylogeny, to determine appropriate levels to keep in 
# main ANOVA
x_phylo <- c('Division', 'Class', 'SubClass',
             'xOrder', 'Family', 'Genus', 'SpeciesCode')
anova_phylo <- do_anova(dat, x_phylo)

species_colors <- brewer.pal(length(x_phylo) + 1, 'Set1')
species_colors[1] <- 'grey'
anova_plot(anova_phylo) + scale_fill_manual(values = species_colors)
ggsave(file.path(figdir, "anova.phylogeny.png"))

ag_table <- . %>%
    group_by(Predictor) %>%
    summarize(SS = sum(norm_sum_of_squares)) %>%
    mutate(Percent_SS = SS/sum(SS) * 100) %>%
    arrange(-Percent_SS)

anova_phylo %>% ag_table

# ANOVA with only species (no others) phylogeny category
x_simple <- c('growth_form', 'evergreen', 'leaf_type', 'ps_type',
              'SpeciesCode', 'SunShade', 'Site')
anova_simple <- do_anova(dat, x_simple)

simple_colors <- c('grey', brewer.pal(length(x_simple), 'Set1'))
anova_plot(anova_simple) + scale_fill_manual(values = simple_colors)
ggsave(file.path(figdir, "anova.attribute.png"))

anova_simple %>% ag_table
