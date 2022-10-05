#' Tau
#'
#' Returns a vector of specificity scores using the Tau metric.
#' The main ESS function provides a wrapper for this to select
#' cell types and aggregation method
#'
#' @param x A matrix of data
#'
#' @return A vector
#'
#' @export
tau <- function (x) 
{
  x <- as.matrix(x)
  myMaxes <- apply(x,1,max)
  xhat <- 1-(x/myMaxes)
  tissues <- ncol(x)
  rowSums(xhat) / (tissues - 1)
}

