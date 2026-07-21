#' Plot PCA Eigenvalue Histogram with Marchenko-Pastur Bounds
#'
#' PCA eigenvalue histogram, showing the empirical
#' eigenvalue distribution together with the Marchenko-Pastur theoretical bounds.
#' Original design by Enrique Hernandez Lemus
#'
#' @param x A result from `sigPCA_mp()`, `sigPCA(method = "mp")`, or a numeric
#'   vector of eigenvalues.
#' @param mp_bounds Optional list with `lambda_min` and `lambda_max`. Required
#'   if `x` is a numeric vector.
#' @param bins Number of histogram bins. Default: 30.
#'
#' @return A `ggplot2` object.
#' @importFrom ggplot2 .data
#' @export
#'
#' @examples
#' set.seed(123)
#' x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
#' result <- sigPCA_mp(x)
#' plot_sigPCA_histogram(result)
plot_sigPCA_histogram <-
  function(x,
           mp_bounds = NULL,
           bins = 30) {

    if (is.numeric(x)) {
      eigenvalues <- x

      if (is.null(mp_bounds)) {
        stop("`mp_bounds` must be provided when `x` is a numeric vector.",
             call. = FALSE)
      }
    } else if (is.list(x) && !is.null(x$eigenvalues)) {
      eigenvalues <- x$eigenvalues
      mp_bounds <- x$mp_bounds
    } else if (is.list(x) && !is.null(x$mp) && !is.null(x$mp$eigenvalues)) {
      eigenvalues <- x$mp$eigenvalues
      mp_bounds <- x$mp$mp_bounds
    } else {
      stop(
        "`x` must be a numeric vector, a `sigPCA_mp()` result, or a `sigPCA()` result with method = 'mp' or 'both'.",
        call. = FALSE
      )
    }

    if (is.null(mp_bounds$lambda_min) || is.null(mp_bounds$lambda_max)) {
      stop("`mp_bounds` must contain `lambda_min` and `lambda_max`.",
           call. = FALSE)
    }

    df <-
      data.frame(
        eigenvalue = eigenvalues,
        significant = eigenvalues > mp_bounds$lambda_max
      )

    ggplot2::ggplot(df, ggplot2::aes(x = .data$eigenvalue)) +
      ggplot2::geom_histogram(
        ggplot2::aes(y = ggplot2::after_stat(.data$density)),
        bins = bins,
        color = "white",
        fill = "gray70"
      ) +
      ggplot2::geom_density(linewidth = 0.8) +
      ggplot2::geom_vline(
        xintercept = mp_bounds$lambda_min,
        linetype = "dashed",
        linewidth = 0.7
      ) +
      ggplot2::geom_vline(
        xintercept = mp_bounds$lambda_max,
        linetype = "dashed",
        linewidth = 0.7
      ) +
      ggplot2::geom_rug(
        data = df[df$significant, , drop = FALSE],
        ggplot2::aes(x = .data$eigenvalue),
        sides = "b",
        linewidth = 0.8
      ) +
      ggplot2::labs(
        title = "PCA Eigenvalue Histogram",
        subtitle = "Dashed lines indicate Marchenko-Pastur theoretical bounds",
        x = "Eigenvalue",
        y = "Density"
      ) +
      ggplot2::theme_minimal()
  }
