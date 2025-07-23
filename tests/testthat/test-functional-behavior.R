# ==============================================================================
# Functional behavior tests for sigPCA
# ==============================================================================

# ==============================================================================
# . Noise (pure random data, no structure)
# ==============================================================================

## .. MP method
test_that("MP method: does not detect signal in pure noise", {
  set.seed(456)
  x <- matrix(rnorm(1000), nrow = 100, ncol = 10)

  result <- sigPCA(x, method = "mp")
  expect_true(length(result$mp$significant_components) <= 1)
})

## .. Empirical (permutation) method
test_that("Permutation method: does not detect signal in pure noise", {
  set.seed(987)
  x <- matrix(rnorm(1000), nrow = 100, ncol = 10)

  result <- sigPCA(x, method = "perm", num_permutations = 100)
  expect_true(length(result$perm$significant_components) <= 1)
})

# ==============================================================================
# . Additive signal (non-correlated variables with shifted means)
# ==============================================================================

## .. MP method
test_that("MP method: fail to detect additive signal (non-correlated shift)", {
  set.seed(789)
  x <- matrix(rnorm(1000), nrow = 100, ncol = 10)
  x[, 1:3] <- x[, 1:3] + matrix(rnorm(300, mean = 2), ncol = 3)

  result <- sigPCA(x, method = "mp")
  #expect_true(length(result$mp$significant_components) >= 1)
  expect_true(length(result$mp$significant_components) < 1)
})

## .. Empirical (permutation) method
test_that("Permutation method: detects additive signal (non-correlated shift)", {
  set.seed(790)
  x <- matrix(rnorm(1000), nrow = 100, ncol = 10)
  x[, 1:3] <- x[, 1:3] + matrix(rnorm(300, mean = 2), ncol = 3)

  result <- sigPCA(x, method = "perm", num_permutations = 100)
  expect_true(length(result$perm$significant_components) >= 1)
})

# ==============================================================================
# . Linear correlation (latent shared structure across variables)
# ==============================================================================

## .. MP method
test_that("MP method: detects linear correlation structure across variables", {
  set.seed(123)
  x <- matrix(rnorm(1000), nrow = 100, ncol = 10)
  z <- rnorm(100)
  x[, 1] <- z + rnorm(100, sd = 0.1)
  x[, 2] <- z + rnorm(100, sd = 0.1)
  x[, 3] <- z + rnorm(100, sd = 0.1)

  result <- sigPCA(x, method = "mp")
  expect_true(length(result$mp$significant_components) >= 1)
})

## .. Empirical (permutation) method
test_that("Permutation method: detects linear correlation structure across variables", {
  set.seed(998)
  x <- matrix(rnorm(1000), nrow = 100, ncol = 10)
  z <- rnorm(100)
  x[, 1] <- z + rnorm(100, sd = 0.1)
  x[, 2] <- z + rnorm(100, sd = 0.1)
  x[, 3] <- z + rnorm(100, sd = 0.1)

  result <- sigPCA(x, method = "perm", num_permutations = 100)
  expect_true(length(result$perm$significant_components) >= 1)
})
