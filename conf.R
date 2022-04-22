suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(MachineShop))
suppressPackageStartupMessages(library(recipes))
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(arsenal))
### Read Data
dat <- readRDS("./data/hcc_data.RDS")

rec_base <- recipe(
    status ~ .,
    data = dat) %>%
    role_case(stratum = status) %>%
    check_missing(status) %>%
    step_num2factor(status, transform = function(x) x + 1,
                    levels = c("died", "survive")) %>%
    step_num2factor(gender, transform = function(x) x + 1,
                    levels = c("female", "male")) %>%
    step_num2factor(symptom, transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(alc, transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(hepBsurfAnti,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(hepBeAnti,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(hepBcorAnti,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(hepCvirAnti,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(cirr,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(endemicCountries,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(smoke,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(diabetes,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(obese,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(hemochro,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(artHyper,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(chronRenal,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(hiv,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(Nasteato,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(esophVarices,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(spleno,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(portalHyper,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(portalVeinThromb,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(LiverMeta,transform = function(x) x + 1,
                    levels = c("no", 'yes')) %>%
    step_num2factor(RadioHallmark,transform = function(x) x + 1,
                    levels = c("no", 'yes')) 
# %>%
#     step_num2factor(numNodules,transform = function(x) x + 1,
                    # levels = as.character(0:5))

ctrl <- CVControl(seed = 123)

## knn chosen from article related to the dataset
steps_imp <- list("MeanMode" = list(f = list(step_impute_mean, step_impute_mode),
                                    args = list(expr(all_numeric_predictors()), 
                                                expr(all_nominal_predictors()))
                                    ),
                  "knn" = list(f = list(step_impute_knn),
                               args = list(
                                 list(expr(all_predictors()),
                                      id="knn")
                                 )
                               )
                  # "bag" = list(f = list(step_impute_bag),
                  #             args= list(
                  #               list(expr(all_predictors()),
                  #                    seed_val = 123)
                  #               )
                  #         )
                  )

### Not do tuned inputs for now
steps_filter <- list("pca" = list(f = list(step_pca),
                                  args = list(
                                    list(expr(all_numeric_predictors()),
                                              id = 'pca')
                                    )
                                  ),
                     "corr" = list(f = list(step_corr),
                                   args = list(
                                     list(expr(all_numeric_predictors()),
                                          id = 'corr')
                                     )
                                   ),
                     "none" = list()
                     )

### if only expand_steps took a list as an argument see do.call
steps_hyper <- list("knn" = list(neighbors = 1:5),
                    "pca" = list(threshold = c(0.75, 0.8, 0.85, 0.9)),
                    "corr" = list(threshold = c(0.75, 0.8, 0.85, 0.9))
                    )

# steps_grid <- do.call(expand_steps, c(steps_hyper['knn'],steps_hyper['pca']))

models <- list("BARTMachineModel" = TunedModel(BARTMachineModel, control = ctrl),
               "SVMRad" = TunedModel(SVMRadialModel, control = ctrl),
               "NNet" = TunedModel(NNetModel, control = ctrl),
               "XGBTree" = TunedModel(XGBTreeModel,
                                      grid = c('nrounds' = 3,
                                               'eta' = 3,
                                               'max_depth' = 3),
                                      control = ctrl),
               "GLM" = GLMModel)


