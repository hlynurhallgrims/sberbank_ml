# Project: sberbank
# Author: Hlynur Hallgrimsson
# Maintainer: <hlynurh@gmail.com>

# Innlesin gögn skipt í svarbreytu og skýribreytur (fyrir train()		)
#Þjálfunarsett
housing_y <- innlesid$price_doc
housing_x <- innlesid[, 1:291]
housing_xcc <- housing_x[complete.cases(housing_x), ]

# Tökum til hliðar þá dálka sem innihalda factora
thattur <- housing_x[, sapply(housing_x, is.factor)]
# Búum til hönnunarfylki fyrir þær factora-skýribreytur sem innihalda fleiri en tvo þætti en færri en skrilljón
product_type_df <- model.matrix( ~ product_type -1, data = thattur) %>% data.frame()
sub_area_df <- model.matrix( ~ sub_area -1, data = thattur) %>% data.frame()
ecology_df <- model.matrix( ~ ecology - 1, data = thattur) %>% data.frame()

#Brjótum dagsetningar niður á módel-lesanlegt form
timestamp_df <- thattur$timestamp %>% as.Date()
timestamp_list <- str_split(timestamp_df, "-")
timestamp_list <- do.call(mapply, c(cbind, timestamp_list)) %>% data.frame()
colnames(timestamp_list) <- c("ar", "man", "dag")
timestamp_0 <- as.numeric(timestamp_df) - as.numeric(timestamp_df)[1]
timestamp_df <- cbind(timestamp = as.numeric(timestamp_df), timestamp_0, timestamp_list)
timestamp_df$ar <- timestamp_df$ar %>% as.character() %>% as.numeric()
timestamp_df$man <- timestamp_df$man %>% as.character() %>% as.numeric() 	#Soldið sloppy 1/3
ar_0 <- timestamp_df$ar - timestamp_df$ar[1]
#Gerum mánaðateljara
man_0 <- timestamp_df$man + ((ar_0 - ar_0[1]) * 12)
timestamp_df$man <- timestamp_df$man %>% as.factor() 											#Soldið sloppy 2/3
man_df <- model.matrix( ~ man -1, data = timestamp_df) %>% data.frame()
timestamp_df$man <- timestamp_df$man %>% as.character() %>% as.numeric() 	#Soldið sloppy 2/3
timestamp_df$dag <- timestamp_df$dag %>% as.character() %>% as.numeric()

#Skellum saman öllum tímabreytum
timestamp_df <- cbind(timestamp_df, ar_0, man_0)
timestamp_df <- timestamp_df %>%
	select(timestamp, timestamp_0, ar, ar_0, man, man_0, dag)

#Förum yfir já/nei breytur
ja_nei <- thattur %>%
	select(4:15)

for (i in 1:ncol(ja_nei)) {
	ja_nei[, i] <- ja_nei[, i] %>% as.numeric - 1
}

#Hreinsum factora úr gamla housing
housing_x <- housing_x %>%
	select(-timestamp, -product_type, -sub_area, -culture_objects_top_25, -thermal_power_plant_raion,
				 -incineration_raion, -oil_chemistry_raion, -radiation_raion, -railroad_terminal_raion,
				 -big_market_raion, -nuclear_reactor_raion, -detention_facility_raion, -water_1line,
				 -big_road1_1line, -railroad_1line, -ecology) %>%
	mutate(product_typeUnknown = 1*0)


#Setjum allt saman nuna
housing_x <- data.frame(housing_x, product_type_df, sub_area_df, ecology_df, timestamp_df, ja_nei)


#Prófunarsett

# Innlesin gögn skipt í svarbreytu og skýribreytur (fyrir train()		)
#Þjálfunarsett
housing_test_x <- profgogn[, 1:291]
# housing_test_xcc <- housing_test_x[complete.cases(housing_test_x), ]

# Tökum til hliðar þá dálka sem innihalda factora
rm(thattur)
thattur <- housing_test_x[, sapply(housing_test_x, is.factor)]
# Búum til hönnunarfylki fyrir þær factora-skýribreytur sem innihalda fleiri en tvo þætti en færri en skrilljón
rm(product_type_df)
levels(thattur$product_type) <- c("Investment", "OwnerOccupier", "Unknown") #Bætum við sérstöku leveli
#fyrir óþekkt gildi (model.matrix hendir út NA dálkum)
thattur$product_type[is.na(thattur$product_type)] <- "Unknown" #Gefum öllum NA gildum nýtt factor gildi "Unknown"
product_type_df <- model.matrix( ~ product_type-1, data = thattur) %>% data.frame()
sub_area_df <- model.matrix( ~ sub_area -1, data = thattur) %>% data.frame()
ecology_df <- model.matrix( ~ ecology - 1, data = thattur) %>% data.frame()

#Brjótum dagsetningar niður á módel-lesanlegt form
timestamp_df <- thattur$timestamp %>% as.Date()
timestamp_list <- str_split(timestamp_df, "-")
timestamp_list <- do.call(mapply, c(cbind, timestamp_list)) %>% data.frame()
colnames(timestamp_list) <- c("ar", "man", "dag")
timestamp_0 <- as.numeric(timestamp_df) - as.numeric(timestamp_df)[1]
timestamp_df <- cbind(timestamp = as.numeric(timestamp_df), timestamp_0, timestamp_list)
timestamp_df$ar <- timestamp_df$ar %>% as.character() %>% as.numeric()
timestamp_df$man <- timestamp_df$man %>% as.character() %>% as.numeric() 	#Soldið sloppy 1/3
ar_0 <- timestamp_df$ar - timestamp_df$ar[1]
#Gerum mánaðateljara
man_0 <- timestamp_df$man + ((ar_0 - ar_0[1]) * 12)
timestamp_df$man <- timestamp_df$man %>% as.factor() 											#Soldið sloppy 2/3
man_df <- model.matrix( ~ man -1, data = timestamp_df) %>% data.frame()
timestamp_df$man <- timestamp_df$man %>% as.character() %>% as.numeric() 	#Soldið sloppy 2/3
timestamp_df$dag <- timestamp_df$dag %>% as.character() %>% as.numeric()

#Skellum saman öllum tímabreytum
timestamp_df <- cbind(timestamp_df, ar_0, man_0)
timestamp_df <- timestamp_df %>%
	select(timestamp, timestamp_0, ar, ar_0, man, man_0, dag)

#Förum yfir já/nei breytur
ja_nei <- thattur %>%
	select(4:15)

for (i in 1:ncol(ja_nei)) {
	ja_nei[, i] <- ja_nei[, i] %>% as.numeric - 1
}

#Hreinsum factora úr gamla housing
housing_test_x <- housing_test_x %>%
	select(-timestamp, -product_type, -sub_area, -culture_objects_top_25, -thermal_power_plant_raion,
				 -incineration_raion, -oil_chemistry_raion, -radiation_raion, -railroad_terminal_raion,
				 -big_market_raion, -nuclear_reactor_raion, -detention_facility_raion, -water_1line,
				 -big_road1_1line, -railroad_1line, -ecology)

#Setjum allt saman nuna
housing_test_x <- data.frame(housing_test_x, product_type_df, sub_area_df, ecology_df, timestamp_df, ja_nei)


#Impute
housing_x_imputed <- imputeMissings::impute(data = housing_x, method = "median/mode")
housing_test_x_imputed <- imputeMissings::impute(data = housing_test_x, method = "median/mode")

#NZV
low_quality <- nearZeroVar(x = housing_x_imputed, freqCut = 2, uniqueCut = 20, names = TRUE)
housing_x_imputed_small <- housing_x_imputed[, setdiff(names(housing_x_imputed), low_quality)]
housing_test_x_imputed_small <- housing_test_x_imputed[, setdiff(names(housing_test_x_imputed), low_quality)]

#Jitter
housing_x_shot <- housing_x_small %>% 
	mutate(max_floor  = jitter(max_floor),
				 build_year = jitter(build_year),
				 num_room   = jitter(num_room),
				 kitch_sq   = jitter(kitch_sq),
				 state      = jitter(state),
				 product_typeInvestment = jitter(product_typeInvestment),
				 product_typeOwnerOccupier = jitter(product_typeOwnerOccupier),
				 ar = jitter(ar),
				 ar_0 = jitter(ar_0))

housing_x_imputed_small <- housing_x_imputed_small %>%
	mutate(product_typeInvestment = jitter(product_typeInvestment),
				 product_typeOwnerOccupier = jitter(product_typeOwnerOccupier),
				 ar = jitter(ar),
				 ar_0 = jitter(ar_0))

housing_test_x_imputed_small <- housing_test_x_imputed_small %>%
	mutate(product_typeInvestment = jitter(product_typeInvestment),
				 product_typeOwnerOccupier = jitter(product_typeOwnerOccupier),
				 ar = jitter(ar),
				 ar_0 = jitter(ar_0))