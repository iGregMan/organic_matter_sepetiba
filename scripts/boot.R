# Name of libraries to call/install
libs_to_call <- list(

  "data.table",
  "ggplot2",
  "ggpubr",
  "here",
  "remotes",
  "reshape2",
  "stringr",
  "tidyverse",
  "usdm"

)

# loading/installation of libraries
lapply(
  libs_to_call,

  function(i) {

    bool <- is.element(i, .packages(all.available = TRUE))

    if (!bool) {
      install.packages(i)
    }

    library(i, character.only = TRUE)

  })


# Import fatty acids data
d <- read.csv(here("data", "raw", "acidos_graxos.csv"), sep = ";")
names(d)[1] <- "site"
# row.names(d) <- d$X
# d <- d[, -1]

# import environmental data
e <- read.csv(here("data", "raw", "environmental_data.csv"), sep = ";")
names(e)[1] <- "site"

# import correspondance site/campaign/area
s <- read.csv(here("data", "raw", "site_season_area.csv"), sep = ";")
s <- s[, 1:3]
names(s) <- c("campaign", "area", "site")
s$campaign <- substr(s$campaign, 2, 2)
s$area <- substr(s$area, 1, 3)
s$campaignXarea <- paste0(s$area, s$campaign)
# One site is missing
s <- s %>% rbind(list("2", "SEP", 201, "SEP2"))
