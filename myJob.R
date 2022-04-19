# getwd()
suppressPackageStartupMessages(library(rmarkdown))
suppressPackageStartupMessages(library(optparse))

option_list <- list(
  make_option(c("-i", "--impute"), type = "character",
              default = "MeanMode", help = "See steps_imp list names in config",
              metavar="character"),
  make_option(c("-f", '--filter'), type = 'character',
              default = "corr", help = 'See steps_filter list names in config',
              metavar = 'character'),
  make_option(c("-m", "--model"), type = "character",
              default = "BARTModel", help = "See model list names in config",
              metavar="character")
)

opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)
source("conf.R")

if(!(opt$model %in% names(models))){
  stop("\nModel not in model list")
}

if(!(opt$filter %in% names(steps_filter))){
  stop("\nFilter step not in filter list")
}

if(!(opt$impute %in% names(steps_imp))){
  stop("\nImpute step not in impute list")
}

fname_base <- paste0(opt$impute, "_", opt$filter, "_", opt$model)

#### Imputing steps
rec <- purrr::reduce2(steps_imp[[opt$impute]]$f,
               steps_imp[[opt$impute]]$args,
               ~ do.call(..2, c(list(..1), ..3)), 
              .init = rec_base)
rec <- rec %>% 
  step_nzv(all_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors())

#### Filtering Steps

if(opt$impute != "none"){
  rec <- purrr::reduce2(steps_filter[[opt$filter]]$f,
                        steps_filter[[opt$filter]]$args,
                        ~ do.call(..2, c(list(..1), ..3)), 
                        .init = rec)
}

step_params <- intersect(c(opt$impute, opt$filter), names(steps_hyper))

if(length(step_params) > 0){
  steps_grid <- do.call(expand_steps, 
                        steps_hyper[step_params]
                        )
  rec <- TunedInput(rec, grid = steps_grid)
}


mspec <- ModelSpecification(rec, 
                            model = models[[opt$model]],
                            control = ctrl) %>%
  set_optim_bayes(packages = "rBayesianOptimization")

template_list <- list("rec" = rec,
     'mspec' = mspec,
     'fname_base' = fname_base)


render("AnalysisOutput/AnalysisTemplate.Rmd",
       output_file = paste0(fname_base),
       envir = list2env(template_list))
