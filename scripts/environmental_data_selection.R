# Multicolinearity in environmental variable
# Selection of independant environmental variables using variance inflation
# factors (VIF)

rownames(e) <- e$site
e <- e[, -1]

res_vif <- usdm::vifstep(e)
e_vif <- e[, which(!(names(e) %in% res_vif@excluded))]

# expert selection
names(e_vif)
e_sel <- e_vif %>%
  dplyr::select(
    T...C.,
    Chl.a..ug.m3.,
    RAZÃO.C.N,
    Feo..ug.m3.,
    OD..mg.L.,
    δ13CVPDB....,
    δ15NAir....,
    MPS..mg..L.
  )
