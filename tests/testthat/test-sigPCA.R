test_that("sigPCA works with method = 'mp'", {
  set.seed(123)
  x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
  result <- sigPCA(x, method = "mp")

  expect_equal(result$method, "mp")
  expect_true("mp" %in% names(result))
  expect_true("significant_components" %in% names(result))
  expect_true(is.numeric(result$significant_components))
})

test_that("sigPCA works with method = 'perm'", {
  set.seed(123)
  x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
  result <- sigPCA(x, method = "perm", num_permutations = 10)

  expect_equal(result$method, "perm")
  expect_true("perm" %in% names(result))
  expect_true("significant_components" %in% names(result))
  expect_true(is.numeric(result$significant_components))
})

test_that("sigPCA works with method = 'both'", {
  set.seed(123)
  x <- matrix(rnorm(100 * 10), nrow = 100, ncol = 10)
  result <- sigPCA(x, method = "both", num_permutations = 10)

  expect_equal(result$method, "both")
  expect_true("mp" %in% names(result))
  expect_true("perm" %in% names(result))
  expect_true("combined" %in% names(result))
  expect_true("significant_components" %in% names(result$combined))
  expect_true(is.numeric(result$combined$significant_components))
})
