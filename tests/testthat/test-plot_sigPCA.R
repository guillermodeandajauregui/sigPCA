test_that("plot_sigPCA returns a ggplot object", {
  set.seed(123)
  x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
  result <- sigPCA_mp(x)
  p <- plot_sigPCA(result$eigenvalues, result$mp_bounds)
  expect_s3_class(p, "ggplot")
})
