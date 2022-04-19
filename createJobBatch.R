source("conf.R")

g <- expand.grid(list("imp" = names(steps_imp), 
                      "f" = names(steps_filter),
                      "m" = names(models)))

if(file.exists("jobBatch.sh")){
  file.remove("jobBatch.sh")
}
cat("", file = "jobBatch.sh")
for(i in 1:nrow(g)){
  cat(paste0("Rscript myJob.R --impute=",
             g$imp[i], 
             " --filter=",
             g$f[i],
             " --model=", 
             g$m[i], "\n"),
      file = "jobBatch.sh",
      append=TRUE)
}

