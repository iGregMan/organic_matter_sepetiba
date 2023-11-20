# makefile :
# All the codes in order and what they do

# Charges packages and useful data regularly used in other codes
source(here::here("scripts", "boot.R"))

# Produce profiles of fatty acids for different
source(here::here("scripts", "fatty_acids_profiles.R"))

# Pre-processing (colinearity, VIF, expert selection) of environmental data
source(here::here("scripts", "environmental_data_selection.R"))

# Relationship between fatty acids/fatty acids profiles and environmental data
source(here::here("scripts", "relationship_fa_environment.R"))
