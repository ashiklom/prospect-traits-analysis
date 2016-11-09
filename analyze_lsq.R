library(dtplyr)
library(dplyr)
library(data.table)
library(specobs)
library(ggplot2)

traitdat <- readRDS("traitdat.rds")
outdat <- readRDS("lsqinv.rds")
dat1 <- merge(traitdat, outdat, by = "FullName")

usda_all <- src_sqlite("usda_plants.sqlite3") %>% tbl("usda")

usda <- usda_all %>% 
    filter(Symbol %in% dat1[, SpeciesCode]) %>%
    collect()

usda_sub <- usda %>% 
    select(Symbol, Category, Leaf_Retention, Shade_Tolerance, 
           Class, xOrder, Family, Duration, Growth_Form) %>% 
    setDT() %>% 
    setkey(Symbol)

setkey(dat1, SpeciesCode)
dat <- usda_sub[dat1] %>% rename(SpeciesCode = Symbol)

# Chlorophyll
datcl <- dat[!is.na(leaf_chlorophyll_total)]
plt_cab <- ggplot(datcl) + 
    aes(x = Cab, y = leaf_chlorophyll_total) + 
    facet_wrap("Project", scales = "free") + 
    geom_point(aes(color = Family)) + 
    geom_abline(slope = 1, intercept = 0, linetype = "dashed")
plot(plt_cab)

# Carotenoids
plt_car <- plt_cab + 
    aes(x = Car, y = leaf_carotenoid_total, color = Project) +
    xlim(0, 60)
plot(plt_car)

# Leaf water content
plt_cw <- plt_cab + 
    aes(x = Cw * 10000, y = leaf_water_content, color = Project) +
    ylim(0, 600) + 
    xlim(0, 1000)
plot(plt_cw)

# Leaf mass per area
plot_cm <- plt_cab + 
    aes(x = Cm * 10000, y = leaf_mass_per_area, color = Project) +
    xlim(0, 1000)
plot(plot_cm)
