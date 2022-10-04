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

  # REduce sce object to cell types of interest
  mysce <- sce[,dittoSeq::meta("label",sce) %in% celltypes]
  # Aggregate counts by celltype
  aggr_counts <- t(Matrix.utils::aggregate.Matrix(t(counts(mysce)), groupings = factor(dittoSeq::meta("label",mysce)), fun = aggmethod) )
  x <- as.matrix(aggr_counts)

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
