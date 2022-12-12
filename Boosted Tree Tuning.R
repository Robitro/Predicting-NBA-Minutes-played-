tune_boost <- tune_grid(bt_wf, resamples = player_folds, grid = tree_grid)
tune_boost_trad <- tune_grid(bt_wf_trad, resamples = player_folds, grid = tree_grid)
save(tune_boost, file = "tune_boost.rda")
save(tune_boost_trad, file = "tune_boost_trad.rda")
