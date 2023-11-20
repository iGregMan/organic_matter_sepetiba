libs_to_call <- list(

  "data.table",
  "ggplot2",
  "ggpubr",
  "here",
  "remotes",
  "reshape2",
  "stringr",
  "tidyverse"

)

lapply(libs_to_call, function(i) {

  bool <- is.element(i, .packages(all.available = TRUE))

  if (!bool) {
    install.packages(i)
  }

  library(i, character.only = TRUE)

}
)


# remote_libs_to_call <- list(
#   "rbbt"
# )
#
# github_accounts <- list(
#   "paleolimbot"
# )
#
# mapply(
#   function(pckg, usr) {
#
#     bool <- is.element(pckg, .packages(all.available = TRUE))
#
#     if (!bool) {
#       remotes::install_github(paste0(usr, "/", pckg))
#     }
#
#     library(pckg, character.only = TRUE)
#
#   },
#   remote_libs_to_call,
#   github_accounts,
#   SIMPLIFY = FALSE
# )
