#' calcESS
#'
#' For a given sce, choose the cell types, aggregation method, and specificity method.  Return either vector or matrix
#'
#' @param x An sce object
#' @param celltypes A vector of cell type labels
#' @param addmethod The method for aggregating counts
#' @param specmethod The method for specificity (Frac,FracDetailed,Gini,Tau)
#'
#' @return A either a matrix or a vector, depending on the method used
#'
#' @export
calcESS <- function (sce, celltypes, aggmethod, specmethod) 
{
  mysce <- sce[, dittoSeq::meta("label", sce) %in% celltypes]
  mymat <- as.matrix(counts(mysce))
  mymat <- t(mymat)
  aggr_counts <- Matrix.utils::aggregate.Matrix(mymat, groupings = factor(dittoSeq::meta("label", 
                                                                                         mysce)), fun = aggmethod)
  x <- as.matrix(aggr_counts)
  x <- t(x)
  if (specmethod == "Frac") {
    mySums <- rowSums(x)
    essmat <- x/mySums
    return(essmat)
  }
  if (specmethod == "FracDetailed") {
    mySums <- rowSums(x) 
    essmat <- x/mySums
    bigmat <- as.data.frame(cbind(x,essmat))
    bigmat$ESS_one_per_gene <- apply(essmat,1,max)
    bigmat$Max_expr <- apply(x,1,max)
    return(bigmat)
  }
  if (specmethod == "gini") {
    return(edgeR::gini(t(x)))
  }
  if (specmethod == "tau") {
    return(tau(x))
  }
  
}

