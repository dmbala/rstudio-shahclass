
pkgs <- c(
    "ExperimentHub",
    "Biobase",
    "BiocParallel",
    "biomaRt",
    "IRanges",
    "DelayedArray",
    "GSEABase",
    "graph",
    "RBGL",
    "Rgraphviz",
    "rmarkdown",
    "httr",
    "knitr",
    "BiocStyle",
    "biocViews",
    "roxygen2",
    "RCul" ,
    "XML",
    "zlibbioc"
    )

ap.db <- available.packages(contrib.url(BiocManager::repositories()))
ap <- rownames(ap.db)
fnd <- pkgs %in% ap
pkgs_to_install <- pkgs[fnd]

ok <- BiocManager::install(pkgs_to_install, update=FALSE, ask=FALSE) %in% rownames(installed.packages())

if (!all(fnd))
    message("Packages not found in a valid repository (skipped):\n  ",
            paste(pkgs[!fnd], collapse="  \n  "))
if (!all(ok))
    stop("Failed to install:\n  ",
         paste(pkgs_to_install[!ok], collapse="  \n  "))

suppressWarnings(BiocManager::install(update=TRUE, ask=FALSE))

