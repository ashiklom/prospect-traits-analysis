#!/usr/bin/Rscript
suppressPackageStartupMessages({
    library(dtplyr)
    library(dplyr)
    library(data.table)
    library(methods)
})

traitdat <- readRDS("traitdat.rds")
outdat <- readRDS("all_results.rds")

prospect_names <- c("N", "Cab", "Car", "Cw", "Cm")
dat <- merge(traitdat, outdat, by = "FullName")

saveRDS(dat, 'cleaned_data.rds')
