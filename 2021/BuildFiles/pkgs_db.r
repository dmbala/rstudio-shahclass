
pkgs <- c("hgu133plus2.db",
"hgu95av2.db",
"hom.Hs.inp.db",
"org.At.tair.db",
"org.Hs.eg.db",
"org.Mm.eg.db",
"org.Sc.sgd.db",
"rae230a.db",
"reactome.db",
"EnsDb.Hsapiens.v75",
"GO.db",
"KEGG.db",
"TxDb.Athaliana.BioMart.plantsmart22",
"TxDb.Dmelanogaster.UCSC.dm3.ensGene",
"TxDb.Hsapiens.UCSC.hg18.knownGene",
"TxDb.Hsapiens.UCSC.hg19.knownGene",
"TxDb.Mmusculus.UCSC.mm10.knownGene")

ap.db <- installed.packages()
ap <- rownames(ap.db)
'%ni%' <- Negate('%in%')

new_pkgs <- pkgs[pkgs %ni% ap]
install.packages(new_pkgs, dependencies = TRUE, repo = "https://bioconductor.org/packages/release/data/annotation/")
