#' PCA Significance via Permutation Test
#'
#' Assesses the statistical significance of PCA components using column-wise
#' permutation of the input data to create a null distribution of eigenvalues.
#'
#' @param data A numeric matrix or data frame.
#' @param num_permutations Number of permutations to generate. Default: 1000.
#' @param center Logical. Whether to center variables before analysis. Default: TRUE.
#' @param scale. Logical. Whether to scale variables before analysis. Default: TRUE.
#'
#' @return A list with:
#' \describe{
#'   \item{eigenvalues}{Observed eigenvalues}
#'   \item{null_eigenvalues}{Matrix of eigenvalues from permutations}
#'   \item{pvalues}{Empirical p-values per component}
#'   \item{significant_components}{Indices where p < 0.05}
#' }
#' @export
#'
#' @examples
#' set.seed(123)
#' x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
#' result <- sigPCA_perm(x, num_permutations = 100)
#' result$significant_components
sigPCA_perm <-
  function(data,
           num_permutations = 1000,
           center = TRUE,
           scale. = TRUE) {
  stopifnot(is.matrix(data) || is.data.frame(data))
  data <- as.matrix(data)

  if (center || scale.) {
    data <- scale(data, center = center, scale = scale.)
  }

  n <- nrow(data)
  p <- ncol(data)

  # Eigenvalues from actual data
  observed_eig <- compute_eigenvalues(data)

  # Null distribution: each col permuted independently
  null_eigs <- replicate(num_permutations, {
    permuted <- apply(data, 2, sample)
    compute_eigenvalues(permuted)
  })

  # Compute empirical p-values (one-tailed)
  pvals <-
    vapply(
    seq_along(observed_eig),
    function(i) mean(null_eigs[i, ] >= observed_eig[i]),
    FUN.VALUE = numeric(1)
  )

  list(
    eigenvalues = observed_eig,
    null_eigenvalues = null_eigs,
    pvalues = pvals,
    significant_components = which(pvals < 0.05)
  )
}
