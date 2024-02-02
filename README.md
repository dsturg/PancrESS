
![PancrESS](img/PancrESS_logo.png?raw=true "PancrESS")
## PancrESS: A database for expression specificity visualization and tools for calculation of expression specificity scores in RNA-Seq data
<br>


<!-- GETTING STARTED -->
# Getting Started

The steps below will guide through the steps required to perform the analysis.

# Prerequisites

This is a list of components needed:
* [R](https://www.r-project.org/) v.4.1.1
* [R-studio](https://www.rstudio.com/) v.2022.02.3 Build 492

R packages required:
* Matrix.utils (>= 0.9.8)
https://cran.r-project.org/web/packages/Matrix.utils/index.html
* scRNAseq (>= 2.12.0)
https://bioconductor.org/packages/release/data/experiment/html/scRNAseq.html
* dittoSeq (>= 1.0.2)
https://bioconductor.org/packages/release/bioc/html/dittoSeq.html
* edgeR (>= 3.40.2)
https://bioconductor.org/packages/release/bioc/html/edgeR.html


# Installation

Install the latest version of this package by entering the following in R:

```{r}
devtools::install_github("dsturg/PancrESS",ref="master")
library('PancrESS')
```

# Overview

To see the full list of exported functions:

```{r}
library("PancrESS")
ls("package:PancrESS")
```

# Data preparation

Prior to calculating expression specificity, you need to compile the relevant count data. PancrESS will accept count data packaged in SingleCellExperiment objects, Seurat objects, or tables

```{r}
print(load("data/metapancreas_cellXstudy_DESeq.Rdata"))
```

# Usage

The core function of this package is to return a set of expression specificity metrics from a matrix of gene expression measurements.
Here is an example using a dataset in the scRNAseq package

```{r}


# Make a single-cell experiment object
# This has 16k genes, 7k samples
sce <- BaronPancreasData('human')

# The data are now in a 'SingleCellExperiment' object
sce

# Filter for low counts
geneSums <- rowSums(counts(sce))
sce <- sce[geneSums >= 2,]

# See the cell types that are pre-labelled in this object
table(meta("label",sce))

# Calculate ESS scores for selected cell types
# using 'sum' as the aggregation method
# Supported methods are 'mean','sum',and 'count'

myESS <- calcESS(sce,c("alpha", "beta","acinar","ductal"),"sum","ESSDetailed")

# You can filter to include only genes at
# some maximum expression level, for example:

myESS <- subset(myESS, Max_expr >= 100)
head(myESS)

       acinar alpha beta ductal   acinar.1     alpha.1     beta.1    ductal.1 ESS_one_per_gene Max_expr
A1CF      132  1017  370     77 0.08270677 0.637218045 0.23182957 0.048245614        0.6372180     1017
A4GALT     10    17    5    265 0.03367003 0.057239057 0.01683502 0.892255892        0.8922559      265
AAAS      200   433  491    196 0.15151515 0.328030303 0.37196970 0.148484848        0.3719697      491
AACS       93   551  790    164 0.05819775 0.344806008 0.49436796 0.102628285        0.4943680      790
AADAC    1415    11   19     13 0.97050754 0.007544582 0.01303155 0.008916324        0.9705075     1415
AAED1      89   446  407     85 0.08666018 0.434274586 0.39629990 0.082765336        0.4342746      446

# This is an example of using the gini coefficient
# Note this returns a vector
myGini <- calcESS(sce,c("alpha", "beta","acinar","ductal"),"median","gini")
myGini[1:3]

     A1BG      A1CF       A2M 
0.5178571 0.4790100 0.2222222 

# This is an example of using tau
# This also returns a vector
myTau <- calcESS(sce,c("alpha", "beta","acinar","ductal"),"median","tau")
myTau[1:3]

     A1BG      A1CF       A2M 
0.8148148 0.8102262 0.3333333 

```


# Shiny app

To query pancreatic ESS scores along with UMAPs, please see:
https://transcriptomics.shinyapps.io/PancrESSdb/

# Citation

Sturgill D, Wang L, Arda HE. PancrESS - a meta-analysis resource for understanding cell-type specific expression in the human pancreas. BMC Genomics. 2024 Jan 18;25(1):76. doi: 10.1186/s12864-024-09964-y. PMID: 38238687; PMCID: PMC10797729.

