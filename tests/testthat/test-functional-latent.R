# tests/testthat/test-functional-latent.R

test_that("sigPCA_mp returns no significant components for white noise", {
  set.seed(123)
  {
    x <- matrix(rnorm(1000), nrow = 100, ncol = 10)
    result <- sigPCA(x, method = "mp")
  }
  expect_length(result$mp$significant_components, 0)
})

test_that("sigPCA_perm returns no significant components for white noise", {
  set.seed(123)
  {
    x <- matrix(rnorm(1000), nrow = 100, ncol = 10)
    result <- sigPCA(x, method = "perm", num_permutations = 500)
  }
  expect_length(result$perm$significant_components, 0)
})

test_that("sigPCA_mp detects signal in data with strong latent components", {
  set.seed(123)
  {
    n <- 100
    p <- 10
    k <- 2
    latent <- matrix(rnorm(n * k, mean = 3), nrow = n, ncol = k)
    loadings <- matrix(rnorm(p * k), nrow = k, ncol = p)
    noise <- matrix(rnorm(n * p, sd = 0.3), nrow = n, ncol = p)
    x <- latent %*% loadings + noise
    result <- sigPCA(x, method = "mp")
  }
  expect_gt(length(result$mp$significant_components), 0)
})

test_that("sigPCA_perm detects signal in data with strong latent components", {
  set.seed(123)
  {
    n <- 100
    p <- 10
    k <- 2
    latent <- matrix(rnorm(n * k, mean = 3), nrow = n, ncol = k)
    loadings <- matrix(rnorm(p * k), nrow = k, ncol = p)
    noise <- matrix(rnorm(n * p, sd = 0.3), nrow = n, ncol = p)
    x <- latent %*% loadings + noise
    result <- sigPCA(x, method = "perm", num_permutations = 500)
  }
  expect_gt(length(result$perm$significant_components), 0)
})
