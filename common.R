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

usda_sub <- usda %>% setDT() %>% setkey(Symbol)

setkey(dat1, SpeciesCode)
dat <- usda_sub[dat1] %>% rename(SpeciesCode = Symbol) %>%
    .[is.na(Site), Site := ""]

# Columns in USDA:
# $ id 
# $ Symbol
# $ Accepted_Symbol_x 
# $ Synonym_Symbol_x 
# $ Scientific_Name_x
# $ Hybrid_Genus_Indicator 
# $ Hybrid_Species_Indicator        
# $ Species                         
# $ Subspecies_Prefix               
# $ Hybrid_Subspecies_Indicator     
# $ Subspecies                      
# $ Variety_Prefix                  
# $ Hybrid_Variety_Indicator        
# $ Variety                         
# $ Subvariety_Prefix               
# $ Subvariety                      
# $ Forma_Prefix                    
# $ Forma                           
# $ Genera_Binomial_Author          
# $ Trinomial_Author                
# $ Quadranomial_Author             
# $ Questionable_Taxon_Indicator    
# $ Parents                         
# $ Common_Name                     
# $ State_and_Province              
# $ Category                        
# $ Genus                           
# $ Family                          
# $ Family_Symbol                   
# $ Family_Common_Name              
# $ xOrder                          
# $ SubClass                        
# $ Class                           
# $ SubDivision                     
# $ Division                        
# $ SuperDivision                   
# $ SubKingdom                      
# $ Kingdom                         
# $ Duration                        
# $ Growth_Habit                    
# $ Native_Status                   
# $ Federal_Noxious_Status          
# $ State_Noxious_Status            
# $ State_Noxious_Common_Name       
# $ Invasive                        
# $ Federal_T_E_Status              
# $ State_T_E_Status                
# $ State_T_E_Common_Name           
# $ Accepted_Symbol_y               
# $ Synonym_Symbol_y                
# $ Scientific_Name_y               
# $ Active_Growth_Period            
# $ After_Harvest_Regrowth_Rate     
# $ Bloat                           
# $ C_N_Ratio                       
# $ Coppice_Potential               
# $ Fall_Conspicuous                
# $ Fire_Resistance                 
# $ Flower_Color                    
# $ Flower_Conspicuous              
# $ Foliage_Color                   
# $ Foliage_Porosity_Summer         
# $ Foliage_Porosity_Winter         
# $ Foliage_Texture                 
# $ Fruit_Color                     
# $ Fruit_Conspicuous               
# $ Growth_Form                     
# $ Growth_Rate                     
# $ Height_at_Base_Age_Maximum_feet 
# $ Height_Mature_feet              
# $ Known_Allelopath                
# $ Leaf_Retention                  
# $ Lifespan                        
# $ Low_Growing_Grass               
# $ Nitrogen_Fixation               
# $ Resprout_Ability                
# $ Shape_and_Orientation           
# $ Toxicity                        
# $ Adapted_to_Coarse_Textured_Soil 
# $ Adapted_to_Medium_Textured_Soil 
# $ Adapted_to_Fine_Textured_Soils  
# $ Anaerobic_Tolerance             
# $ CaCO_3_Tolerance                
# $ Cold_Stratification_Required    
# $ Drought_Tolerance               
# $ Fertility_Requirement           
# $ Fire_Tolerance                  
# $ Frost_Free_Days_Minimum         
# $ Hedge_Tolerance                 
# $ Moisture_Use                    
# $ pH_Minimum                      
# $ pH_Maximum                      
# $ Planting_Density_per_Acre_Minimm
# $ Planting_Density_per_Acre_Maximm
# $ Precipitation_Minimum           
# $ Precipitation_Maximum           
# $ Root_Depth_Minimum_inches       
# $ Salinity_Tolerance              
# $ Shade_Tolerance                 
# $ Temperature_Minimum_F           
# $ Bloom_Period                    
# $ Commercial_Availability         
# $ Fruit_Seed_Abundance            
# $ Fruit_Seed_Period_Begin         
# $ Fruit_Seed_Period_End           
# $ Fruit_Seed_Persistence          
# $ Propogated_by_Bare_Root         
# $ Propogated_by_Bulbs             
# $ Propogated_by_Container         
# $ Propogated_by_Corms             
# $ Propogated_by_Cuttings          
# $ Propogated_by_Seed              
# $ Propogated_by_Sod               
# $ Propogated_by_Sprigs            
# $ Propogated_by_Tubers            
# $ Seeds_per_Pound                 
# $ Seed_Spread_Rate                
# $ Seedling_Vigor                  
# $ Small_Grain                     
# $ Vegetative_Spread_Rate          
# $ Berry_Nut_Seed_Product          
# $ Christmas_Tree_Product          
# $ Fodder_Product                  
# $ Fuelwood_Product                
# $ Lumber_Product                  
# $ Naval_Store_Product             
# $ Nursery_Stock_Product           
# $ Palatable_Browse_Animal         
# $ Palatable_Graze_Animal          
# $ Palatable_Human                 
# $ Post_Product                    
# $ Protein_Potential               
# $ Pulpwood_Product                
# $ Veneer_Product                  
