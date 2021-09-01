library(TCGAbiolinks)
library(dpylr)
library(DT)

# reference: https://rpubs.com/tiagochst/TCGAworkshop

cancer_code = c("TCGA-BRCA")
data_categories = c("DNA methylation")
data_types = list(c(""))


query <- GDCquery(project = cancer_code,
                  data.category = "DNA methylation")

get_indivs <- function(cancer_code,data_cat,i=1,j=Inf){
  q <- GDCquery(cancer_code,data_cat)
  cases <- q$results[[1]]$cases
  return(cases[i:min(j,length(cases))])
}
