tune_elas <- tune_grid(en_wflow, resamples = player_folds, grid = en_grid)
tune_elas_trad <- tune_grid(en_wflow_trad, resamples = player_folds, grid = en_grid)
save(tune_elas, file = "tune_elas.rda")
save(tune_elas_trad, file = "tune_elas_trad.rda")
