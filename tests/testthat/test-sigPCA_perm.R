test_that("sigPCA_perm returns expected structure", {
  set.seed(123)
  x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
  result <- sigPCA_perm(x, num_permutations = 50)

  expect_type(result, "list")
  expect_named(result, c("eigenvalues", "null_eigenvalues", "pvalues", "significant_components"))
  expect_equal(length(result$eigenvalues), 10)
  expect_equal(length(result$pvalues), 10)
  expect_true(is.matrix(result$null_eigenvalues))
})
