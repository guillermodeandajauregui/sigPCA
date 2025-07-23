#' Compute Eigenvalues of the Covariance Matrix
#'
#' @param data A numeric matrix or data frame. Observations in rows, features in columns.
#'
#' @return A numeric vector of eigenvalues, sorted decreasingly.
#' @export
#'
#' @examples
#' set.seed(123)
#' mat <- matrix(rnorm(50), nrow = 10, ncol = 5)
#' compute_eigenvalues(mat)
compute_eigenvalues <- function(data) {
  stopifnot(is.matrix(data) || is.data.frame(data))
  data <- as.matrix(data)
  cov_matrix <- stats::cov(data)
  eigen(cov_matrix, only.values = TRUE)$values
}


#' Marchenko–Pastur Theoretical Bounds
#'
#' Computes the lower and upper bounds of the Marchenko–Pastur distribution,
#' based on the aspect ratio of the data matrix.
#'
#' @param p Number of features (columns)
#' @param n Number of observations (rows)
#'
#' @return A named list with `lambda_min` and `lambda_max`.
#' @export
#'
#' @examples
#' bounds <- marchenko_pastur_bounds(p = 10, n = 100)
#' print(bounds)
marchenko_pastur_bounds <- function(p, n) {
  stopifnot(p > 0, n > 0)
  q <- p / n
  lambda_min <- (1 - sqrt(q))^2
  lambda_max <- (1 + sqrt(q))^2
  list(lambda_min = lambda_min, lambda_max = lambda_max)
}
