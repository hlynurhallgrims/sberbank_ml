nothaeft <- setdiff(names(housing_test_x), lika_drasl)
housing_test_x_small <- housing_test_x[, nothaeft]
pred_ss <- predict(mod_glmnet_ss, housing_test_x_small)
pred_rf_2 <- predict(mod_rf_full, housing_test_x_imputed_small)
pred_rf_full <- predict(mod_rf_full, housing_test_x)
pred_pca <- predict(mod_glmnet_pca, housing_test_x_imputed_small)
pred_pca_2 <- predict(mod_glmnet_pca_2, housing_test_x_imputed_small)
pred_svm <- predict(mod_svm, housing_test_x_imputed_small)

pred_ble <- predict(mod_rf, housing_x)


prent <- cbind(housing_test_x_small$id, pred_ss)
rownames(prent) <- NULL
names(prent) <- NULL
colnames(prent) <- c("id", "price_doc")
# prent$price_doc[prent$price_doc < 0] <- 0
write.csv(x = prent, file = "hh_submission.csv", row.names = FALSE)
#RMSLE: 0.37154
#Position: 2850


prent_rf_1 <- cbind(housing_test_x_small$id, pred_rf)
rownames(prent_rf_1) <- NULL
names(prent_rf_1) <- NULL
colnames(prent_rf_1) <- c("id", "price_doc")
# prent_rf_1$price_doc[prent_rf_1$price_doc < 0] <- 0
write.csv(x = prent_rf_1, file = "hh_submission_rf_1.csv", row.names = FALSE)
#RMSLE: 0.32423
#Position: 1932

prent_rf_2_full <- cbind(housing_test_x_small$id, pred_rf_full)
rownames(prent_rf_2_full) <- NULL
names(prent_rf_2_full) <- NULL
colnames(prent_rf_2_full) <- c("id", "price_doc")
# prent_rf_2_full$price_doc[prent_rf_2_full$price_doc < 0] <- 0
write.csv(x = prent_rf_2_full, file = "hh_submission_rf_2_full.csv", row.names = FALSE)

prent_rf_2_part <- cbind(housing_test_x_small$id, pred_rf_2)
rownames(prent_rf_2_part) <- NULL
names(prent_rf_2_part) <- NULL
colnames(prent_rf_2_part) <- c("id", "price_doc")
# prent_rf_2_part$price_doc[prent_rf_2_part$price_doc < 0] <- 0
write.csv(x = prent_rf_2_part, file = "hh_submission_rf_2_part.csv", row.names = FALSE)

prent_prent_pca_1 <- cbind(housing_test_x_small$id, pred_pca)
rownames(prent_prent_pca_1) <- NULL
names(prent_prent_pca_1) <- NULL
colnames(prent_prent_pca_1) <- c("id", "price_doc")
# prent_prent_pca_1$price_doc[prent_prent_pca_1$price_doc < 0] <- 0
write.csv(x = prent_prent_pca_1, file = "hh_submission_prent_pca_1.csv", row.names = FALSE)

prent_prent_pca_2 <- cbind(housing_test_x_small$id, pred_pca_2)
rownames(prent_prent_pca_2) <- NULL
names(prent_prent_pca_2) <- NULL
colnames(prent_prent_pca_2) <- c("id", "price_doc")
# prent_prent_pca_2$price_doc[prent_prent_pca_2$price_doc < 0] <- 0
write.csv(x = prent_prent_pca_2, file = "hh_submission_prent_pca_2.csv", row.names = FALSE)

prent_prent_pca_2 <- cbind(housing_test_x_small$id, pred_pca_2)
rownames(prent_prent_pca_2) <- NULL
names(prent_prent_pca_2) <- NULL
colnames(prent_prent_pca_2) <- c("id", "price_doc")
# prent_prent_pca_2$price_doc[prent_prent_pca_2$price_doc < 0] <- 0
write.csv(x = prent_prent_pca_2, file = "hh_submission_prent_pca_2.csv", row.names = FALSE)

prent_svm_1 <- cbind(housing_test_x_small$id, pred_svm)
rownames(prent_svm_1) <- NULL
names(prent_svm_1) <- NULL
colnames(prent_svm_1) <- c("id", "price_doc")
# prent_svm_1$price_doc[prent_svm_1$price_doc < 0] <- 0
write.csv(x = prent_svm_1, file = "hh_submission_svm_1.csv", row.names = FALSE)

plot(x = pred_ble, y = housing_y,
		 xlab = "predicted", ylab = "actual")
abline(0, 1)
