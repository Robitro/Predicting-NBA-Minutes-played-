tune_rand <- tune_grid(rf_wf, resamples = player_folds, grid = rand_grid)
tune_rand_trad <- tune_grid(rf_wf_trad, resamples = player_folds, grid = rand_grid_trad)
save(tune_rand, file = "tune_rand.rda")
save(tune_rand_trad, file = "tune_rand_trad.rda")
