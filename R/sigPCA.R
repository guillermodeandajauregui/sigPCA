#' Unified PCA Significance Wrapper
#'
#' Runs significance testing on PCA eigenvalues using either Marchenko–Pastur
#' bounds, permutation tests, or both. Results are returned as a structured list.
#'
#' @param data A numeric matrix or data frame.
#' @param method One of `"mp"`, `"perm"`, or `"both"`. Default: `"mp"`.
#' @param num_permutations Integer. Used only if `method` is `"perm"` or `"both"`.
#' @param center,scale. Logical. Passed to `scale()`. Default: TRUE.
#'
#' @return A structured list containing method results.
#' @export
#'
#' @examples
#' set.seed(123)
#' x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
#' sigPCA(x, method = "mp")
#' sigPCA(x, method = "perm", num_permutations = 100)
#' sigPCA(x, method = "both", num_permutations = 100)
sigPCA <- function(data,
                   method = c("mp", "perm", "both"),
                   num_permutations = 1000,
                   center = TRUE,
                   scale. = TRUE) {

  method <- match.arg(method)
  out_mp <- out_perm <- NULL

  if (method %in% c("mp", "both")) {
    out_mp <- sigPCA_mp(data, center = center, scale. = scale.)
  }

  if (method %in% c("perm", "both")) {
    out_perm <- sigPCA_perm(data, num_permutations = num_permutations,
                            center = center, scale = scale.)
  }

  result <- list(
    method = method,
    call = match.call()
  )

  if (!is.null(out_mp)) {
    result$mp <- out_mp
  }

  if (!is.null(out_perm)) {
    result$perm <- out_perm
  }

  if (method == "both") {
    result$combined <- list(
      significant_components = union(out_mp$significant_components,
                                     out_perm$significant_components),
      consensus = intersect(out_mp$significant_components,
                            out_perm$significant_components)
    )
  } else {
    result$significant_components <- switch(method,
                                            "mp" = out_mp$significant_components,
                                            "perm" = out_perm$significant_components
    )
  }

  return(result)
}
