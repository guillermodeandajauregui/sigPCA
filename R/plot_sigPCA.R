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
#' @importFrom ggplot2 .data
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



  p <-
    ggplot2::ggplot(df) +
    ggplot2::aes(
      x = .data$index,
      y = .data$eigenvalue,
      color = .data$significant
    ) +
    ggplot2::geom_point(size = 3) +
    ggplot2::geom_hline(
      yintercept = mp_bounds$lambda_max,
      linetype = "dashed",
      color = "blue"
    ) +
    ggplot2::geom_hline(
      yintercept = mp_bounds$lambda_min,
      linetype = "dashed",
      color = "blue"
    ) +
    ggplot2::scale_color_manual(values = c("black", "red")) +
    ggplot2::labs(
      title = "PCA Eigenvalue Spectrum",
      x = "Principal Component Index",
      y = "Eigenvalue",
      color = "Significant"
    ) +
    ggplot2::theme_minimal()

  if (!is.null(add_null)) {
    p <-
      p +
      ggplot2::geom_density(
        data = data.frame(null = add_null),
        ggplot2::aes(
          x = .data$null,
          y = ggplot2::after_stat(.data$scaled)
        ),
        inherit.aes = FALSE,
        fill = "gray",
        alpha = 0.3,
        bw = "SJ"
      )
  }

  return(p)
}
