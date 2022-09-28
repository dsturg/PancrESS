# PancrESS

Tools for calculation of expression specificity metrics in RNA-Seq data

<!-- GETTING STARTED -->
## Getting Started

The steps below will guide through the steps required to perform the analysis. \

### Prerequisites

This is a list of components needed:
* [R](https://www.r-project.org/) v.4.1.1
* [R-studio](https://www.rstudio.com/) v.2022.02.3 Build 492

R packages required:
* data.table v.1.14.2
Matt Dowle and Arun Srinivasan (2021)
https://CRAN.R-project.org/package=data.table
* dplyr v.1.0.8
Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2022). dplyr: A Grammar of Data Manipulation.
https://CRAN.R-project.org/package=dplyr
* Genomation v1.24.0
Akalin A, Franke V, Vlahovicek K, Mason CE, Schubeler D, (2014) genomation: a toolkit to summarize, annotate and visualize genomic intervals. Bioinformatics. doi: 10.1093/bioinformatics/btu775
https://bioconductor.org/packages/release/bioc/html/genomation.html
* GenomicFeatures v1.44.2
Lawrence M, Huber W, Pages H, Aboyoun P, Carlson M, et al. (2013) Software for Computing and Annotating Genomic Ranges. PLoS Comput Biol 9(8): e1003118. https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html
* rtracklayer v.1.52.1
M. Lawrence, R. Gentleman, V. Carey: "rtracklayer: an {R} package for interfacing with genome browsers". Bioinformatics
  25:1841-1842.
https://bioconductor.org/packages/release/bioc/html/rtracklayer.html
* stringr v.1.4.0
Hadley Wickham (2019). stringr: Simple, Consistent Wrappers for Common String Operations.
https://CRAN.R-project.org/package=stringr


### Installation

Install the latest version of this package by entering the following in R:
devtools::install_github("dsturg/PancrESS",ref="master")
library('PancrESS')
