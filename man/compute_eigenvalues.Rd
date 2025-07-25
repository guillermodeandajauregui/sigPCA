% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pca_utils.R
\name{compute_eigenvalues}
\alias{compute_eigenvalues}
\title{Compute Eigenvalues of the Covariance Matrix}
\usage{
compute_eigenvalues(data)
}
\arguments{
\item{data}{A numeric matrix or data frame. Observations in rows, features in columns.}
}
\value{
A numeric vector of eigenvalues, sorted decreasingly.
}
\description{
Compute Eigenvalues of the Covariance Matrix
}
\examples{
set.seed(123)
mat <- matrix(rnorm(50), nrow = 10, ncol = 5)
compute_eigenvalues(mat)
}
