test_that("compute_eigenvalues returns expected eigenvalues", {
  x <- matrix(rnorm(100), nrow = 10, ncol = 10)
  eig <- compute_eigenvalues(x)
  expect_length(eig, 10)
  expect_true(is.numeric(eig))
  expect_true(all(Im(eig) == 0))  # Eigenvalores reales
})


test_that("marchenko_pastur_bounds are computed correctly", {
  bounds <- marchenko_pastur_bounds(p = 10, n = 100)
  expect_named(bounds, c("lambda_min", "lambda_max"))
  expect_lt(bounds$lambda_min, bounds$lambda_max)
  expect_true(all(unlist(bounds) > 0))
})
