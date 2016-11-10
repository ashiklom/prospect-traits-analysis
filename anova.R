source("common.R")

#library(RcppArmadillo)
#library(RcppEigen)

do_anova <- function(dat, xvec, yvec = c("N", "Cab", "Car", "Cw", "Cm")) {
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
    return(anova_melt)
}

library(ggplot2)

xvec <- c("DOY", "SpeciesCode")
yvec <- c("Cab", "Car", "Cw", "Cm")
anova_out <- do_anova(dat, xvec)
plt <- ggplot(anova_out) + 
    aes(x = variable, y = norm_sum_of_squares, fill = Predictor) + 
    geom_bar(stat = "identity")
plot(plt)
