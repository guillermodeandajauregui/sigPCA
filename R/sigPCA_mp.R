#' PCA Significance Based on Marchenko–Pastur Distribution
#'
#' Tests which principal components have eigenvalues beyond the theoretical
#' bounds of the Marchenko–Pastur distribution.
#'
#' @param data A numeric matrix or data frame. Observations in rows, variables in columns.
#' @param center Logical. Whether to center the variables. Default: TRUE.
#' @param scale. Logical. Whether to scale variables to unit variance. Default: TRUE.
#'
#' @return A list with:
#' \describe{
#'   \item{eigenvalues}{All eigenvalues of the covariance matrix}
#'   \item{mp_bounds}{A list with `lambda_min` and `lambda_max`}
#'   \item{significant_components}{Indices of eigenvalues > lambda_max}
#' }
#'
#' @export
#'
#' @examples
#' set.seed(123)
#' x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
#' result <- sigPCA_mp(x)
#' result$significant_components
sigPCA_mp <- function(data, center = TRUE, scale. = TRUE) {
  stopifnot(is.matrix(data) || is.data.frame(data))
  data <- as.matrix(data)

  if (center || scale.) {
    data <- scale(data, center = center, scale = scale.)
  }

  n <- nrow(data)
  p <- ncol(data)

  eigvals <- compute_eigenvalues(data)
  bounds <- marchenko_pastur_bounds(p, n)
  sig_components <- which(eigvals > bounds$lambda_max)

  list(
    eigenvalues = eigvals,
    mp_bounds = bounds,
    significant_components = sig_components
  )
}
