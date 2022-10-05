# PancrESS

Tools for calculation of expression specificity metrics in RNA-Seq data

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
* scRNAseq (>= 2.2.0)
https://bioconductor.org/packages/release/data/experiment/html/scRNAseq.html
* dittoSeq (>= 1.0.2)
https://bioconductor.org/packages/release/bioc/html/dittoSeq.html


# Installation

Install the latest version of this package by entering the following in R:

```r
devtools::install_github("dsturg/PancrESS",ref="master")
library('PancrESS')
```

# Overview

To see the full list of exported functions:

```{r}
library("PancrESS")
ls("package:PancrESS")
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
# using 'median' as the aggregation method

foo <- calcESS(sce,c("alpha", "beta","acinar","ductal"),"median","FracDetailed")


```
