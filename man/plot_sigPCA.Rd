% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_sigPCA.R
\name{plot_sigPCA}
\alias{plot_sigPCA}
\title{Plot PCA Eigenvalue Spectrum with Marchenko–Pastur Bounds}
\usage{
plot_sigPCA(eigenvalues, mp_bounds, highlight = NULL, add_null = NULL)
}
\arguments{
\item{eigenvalues}{Numeric vector of eigenvalues from the real data.}

\item{mp_bounds}{A list with \code{lambda_min} and \code{lambda_max} (from \code{marchenko_pastur_bounds()}).}

\item{highlight}{Logical vector (same length as eigenvalues). Defaults to eigenvalues > lambda_max.}

\item{add_null}{Optional numeric vector of null eigenvalues (e.g. from permutation). Default: NULL.}
}
\value{
A \code{ggplot2} object.
}
\description{
Visualizes the eigenvalue spectrum of a PCA, highlighting significant components
based on Marchenko–Pastur bounds.
}
\examples{
set.seed(123)
x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
result <- sigPCA_mp(x)
plot_sigPCA(result$eigenvalues, result$mp_bounds)
}
