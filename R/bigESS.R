#' Big ESS function
#'
#' For a given sce, choose the cell types, aggregation method, and specificity method.  Return either vector or matrix
#'
#' @param x An sce object
#' @param celltypes A vector of cell type labels
#' @param addmethod The method for aggregating counts
#' @param specmethod The method for specificity
#'
#' @return A either a matrix or a vector, depending on the method used
#'
#' @export
bigESS <- function(sce,celltypes,aggmethod,specmethod) {

  # Reduce sce object to cell types of interest
  mysce <- sce[,dittoSeq::meta("label",sce) %in% celltypes]
  # Aggregate counts by celltype
  mymat <- as.matrix(counts(mysce))
  mymat <- t(mymat)
  aggr_counts <- Matrix.utils::aggregate.Matrix(mymat, groupings = factor(dittoSeq::meta("label",mysce)), fun = aggmethod)
  x <- as.matrix(aggr_counts)
  x <- t(x)

  # Now do the specificity
  if (specmethod == "Arda") {
    mySums <- rowSums(x)
    essmat <- x/mySums
    return(essmat)
  }
  if (specmethod == "gini") {
    return(edgeR::gini(t(x)))
  }


}
