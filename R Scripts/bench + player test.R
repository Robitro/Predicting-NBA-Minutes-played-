
set.seed(6688)
player1 <- select(player, -c(groupStartPosition))
player_split <- initial_split(player, prop=.7, strata = minExact) 

player_train <- training(player_split)
player_test <- testing(player_split)

player_folds <- vfold_cv(player_train, v = 5, stata = minExact)

min_re1 <- recipe(minExact ~ pts+oreb+dreb+ast+fg3a+fg3m+blk+pf+tov+fg2a+fg2m+fta+ftm+pctUSG+ortg+drtg+plusminus+pace+tov+pctTOVTeam, data = player_train) %>% step_dummy(all_nominal_predictors()) %>% step_normalize(all_numeric_predictors())

bt <- boost_tree() %>% set_engine("xgboost") %>% set_mode("regression")

bt_wf1 <- workflow() %>% add_model(bt %>% set_args(trees = tune())) %>% add_recipe(min_re1)

tree_grid <- grid_regular(trees(range= c(2,1000)),levels = 10)



tune_boost1 <- tune_grid(bt_wf1, resamples = player_folds, grid = tree_grid)

autoplot(tune_boost1)

metrics_boost1 <- collect_metrics(tune_boost1) %>% arrange(desc(mean))
metrics_boost1
best_bt1 <- select_best(tune_boost1)

bt_wf_f1 <- finalize_workflow(bt_wf,best_bt1)

bt_final_fit1 <- fit(bt_wf_f1,player_test)

rsq <- metric_set(rsq)

min_pred1 <- predict(bt_final_fit1,player_test) %>%  bind_cols(player_test %>% select(minExact))

rsq(min_pred1, truth = minExact, estimate = .pred)
