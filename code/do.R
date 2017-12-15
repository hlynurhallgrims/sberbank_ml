# The actual work
myFolds <- createFolds(housing_x_imputed_small, k = 5)
saveRDS(object = myFolds, file = "./cache/myFolds.rds")

myGrid <- expand.grid(
	alpha = seq(0, 1, length = 5),
	lambda = seq(0.0001, 100000, length = 20)
)

myGrid3 <- expand.grid(
	alpha = seq(0, 1, length = 5),
	lambda = seq(0.0001, maxlam, length = 20)
)

myControl <- trainControl(
	verboseIter = TRUE,
	savePredictions = TRUE,
	index = myFolds
)


#Spatial sign
mod_glmnet_ss <- train(
	x = housing_x_imputed_small, y = housing_y,
	method = "glmnet",
	metric = "RMSE",
	preProcess = c("medianImpute", "center", "scale", "spatialSign"),
	trControl = myControl
)

#Principal component analysis
mod_glmnet_pca <- train(
	x = housing_x_imputed_small, y = housing_y,
	method = "glmnet",
	preProcess = c("center", "scale", "pca"),
	tuneGrid = myGrid,
	trControl = myControl
)


#Principal component analysis
mod_glmnet_pca_2 <- train(
	x = housing_x_imputed_small, y = housing_y,
	method = "glmnet",
	preProcess = c("center", "scale", "pca"),
	tuneGrid = myGrid2,
	trControl = myControl
)

mod_rf_shot <- train(
	x = housing_x_shot, y = housing_y,
	method = "ranger",
	preProcess = "knnImpute",
	trControl = myControl,
	tuneLength = 10
)
saveRDS(object = mod_rf, file = "./cache/mod_rf.rds")

mod_svm <- train(
	x = housing_x_imputed_small, y = housing_y,
	method = "svmLinear2",
	preProcess = c("center", "scale"),
	trControl = myControl
)
saveRDS(object = mod_svm, file = "./cache/mod_svm.rds")
# saveRDS(object = mod_rf_full, file = "./cache/mod_rf_full.rds")
# saveRDS(object = mod_rf_full, file = "./cache/mod_rf_part.rds")

min(mod_glmnet_ss$results$RMSE)
