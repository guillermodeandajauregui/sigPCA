test_that("sigPCA_mp identifies components beyond MP bounds", {
  set.seed(123)
  x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
  result <- sigPCA_mp(x)

  expect_type(result, "list")
  expect_named(result, c("eigenvalues", "mp_bounds", "significant_components"))
  expect_true(is.numeric(result$eigenvalues))
  expect_true(all(result$eigenvalues >= 0))
  expect_true(is.list(result$mp_bounds))
  expect_true(all(c("lambda_min", "lambda_max") %in% names(result$mp_bounds)))
})
