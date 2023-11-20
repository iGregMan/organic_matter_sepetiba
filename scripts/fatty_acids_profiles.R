# Fatty acids profiles Sepetiba
# Chi square tests

# separate main table into a list of different tables
# according to the campaign
acidos_graxos <- d %>% left_join(subset(s, select = c("site", "campaign")))
row.names(acidos_graxos) <- acidos_graxos$site
acidos_graxos <- acidos_graxos[, -1]
acidos_graxos_list <- split(acidos_graxos, f = acidos_graxos$campaign)
acidos_graxos_list <- lapply(acidos_graxos_list, \(df) df[, -ncol(df)])
# change names of the list
names(acidos_graxos_list) <- paste0("C", names(acidos_graxos_list))
View(acidos_graxos_list$C1)

# example of chi square test
df <- acidos_graxos_list$C1
# /!\ It is not a contingency table because the sum of rows and columns do not
# equal to the number of individuals in the studied population
# https://en.wikipedia.org/wiki/Contingency_table

# David et al., 2020 (2.5 Data analysis)
# Kruskal-Wallis + Wilcoxon Mann Withney test
acidos_graxos <- d %>% left_join(s)
?kruskal.test
k <- acidos_graxos %>% dplyr::select(-c(area, campaignXarea))
row.names(k) <- k$site
k <- k[, -1]

# attempt for "for" loop
for (fa in names(k)[-length(names(k))]) {
  kruskal.test(formula = get(fa) ~ campaign, data = k)
}

# now for apply
res_kruskal <- sapply(
  names(k)[-length(names(k))],
  function(fa) {
    kruskal.test(formula = get(fa) ~ campaign, data = k)
  },
  simplify = F,
  USE.NAMES = T
)

# extract all p-values and check which one are below the risk threshold
pval0.05 <- res_kruskal %>% lapply(pluck, "p.value") < 0.05

# isolate significant fatty acids profile in the data table (k)
k_signif <- k[, which(pval0.05)] %>% cbind(campaign = k$campaign)

# Which are the positive/negative anomalies in between campaigns?
?pairwise.wilcox.test
res_wilcox <- sapply(
  names(k_signif)[-length(names(k_signif))],
  function(fa) {
    pairwise.wilcox.test(
      k_signif[[fa]],
      as.numeric(k_signif$campaign),
      p.adjust.method = "bonf",
      exact = FALSE
    )
  },
  simplify = F,
  USE.NAMES = T
)

boxplot(split(k_signif$X18.1w9, f = k_signif$campaign))
boxplot(split(k_signif$X18.0iso, f = k_signif$campaign))
boxplot(split(k_signif$X20.5w3, f = k_signif$campaign))
