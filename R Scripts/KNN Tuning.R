tune_knn <- tune_grid(knn_wflow, resamples = player_folds, grid = knn_grid)
tune_knn_trad <- tune_grid(knn_wflow_trad, resamples = player_folds, grid = knn_grid)
save(tune_knn_trad,  file = "tune_knn_trad.rda")
save(tune_knn,  file = "tune_knn.rda")
