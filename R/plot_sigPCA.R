#' Plot PCA Eigenvalue Spectrum with Marchenko–Pastur Bounds
#'
#' Visualizes the eigenvalue spectrum of a PCA, highlighting significant components
#' based on Marchenko–Pastur bounds.
#'
#' @param eigenvalues Numeric vector of eigenvalues from the real data.
#' @param mp_bounds A list with `lambda_min` and `lambda_max` (from `marchenko_pastur_bounds()`).
#' @param highlight Logical vector (same length as eigenvalues). Defaults to eigenvalues > lambda_max.
#' @param add_null Optional numeric vector of null eigenvalues (e.g. from permutation). Default: NULL.
#'
#' @return A `ggplot2` object.
#' @export
#'
#' @examples
#' set.seed(123)
#' x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
#' result <- sigPCA_mp(x)
#' plot_sigPCA(result$eigenvalues, result$mp_bounds)
plot_sigPCA <-
  function(eigenvalues,
           mp_bounds,
           highlight = NULL,
           add_null = NULL) {
  stopifnot(is.numeric(eigenvalues), is.list(mp_bounds))

  if (is.null(highlight)) {
    highlight <- eigenvalues > mp_bounds$lambda_max
  }

  df <-
    data.frame(
    eigenvalue = eigenvalues,
    index = seq_along(eigenvalues),
    significant = highlight
  )

  library(ggplot2)

  p <-
    ggplot(df) +
    aes(x = index,
        y = eigenvalue,
        color = significant) +
    geom_point(size = 3) +
    geom_hline(yintercept = mp_bounds$lambda_max,
               linetype = "dashed",
               color = "blue") +
    geom_hline(yintercept = mp_bounds$lambda_min,
               linetype = "dashed",
               color = "blue") +
    scale_color_manual(values = c("black", "red")) +
    labs(
      title = "PCA Eigenvalue Spectrum",
      x = "Principal Component Index",
      y = "Eigenvalue",
      color = "Significant"
    ) +
    theme_minimal()

  if (!is.null(add_null)) {
    p <-
      p +
      geom_density(data = data.frame(null = add_null),
                   aes(x = null, y = ..scaled..),
                   inherit.aes = FALSE,
                   fill = "gray",
                   alpha = 0.3,
                   bw = "SJ")
  }

  return(p)
}
