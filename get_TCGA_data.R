library(TCGAbiolinks)
library(dplyr)
library(DT)

# reference: https://rpubs.com/tiagochst/TCGAworkshop

cancer_code = c("TCGA-BRCA")
data_categories = c("DNA methylation")
data_types = list(c(""))


get_indivs <- function(cancer_code,data_cat,i=1,j=Inf){
  q <- GDCquery(cancer_code,data_cat)
  cases <- q$results[[1]]$cases
  return(cases[i:min(j,length(cases))])
}

get_meth_data <- function(cancer_code,data_cat,indivs){
  q <- GDCquery(project = cancer_code,
                data.category = data_cat,
                barcode = indivs)
  GDCdownload(q)
  data <- GDCprepare(q,summarizedExperiment = TRUE)
  return(data %>% rowRanges %>% as.data.frame)
}

tmp_i <- get_indivs("TCGA-BRCA","DNA Methylation",j=200)
meth <- get_meth_data("TCGA-BRCA","DNA Methylation",tmp_i)

save.image()
