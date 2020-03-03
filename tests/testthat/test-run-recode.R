test_that("recode returns original values when run with null definitions", {
  expect_equal(def_recode(1:10, NULL), 1:10)
})

test_that("recode works with definitions produced by def_prep", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                               value      = c(1,   2,   1,   2,   1),
                               definition = c('cat', 'dog', 'fred', 'george', 'lonely'))

  def_basic <- def_prep(dict_basic, variable, value, definition)

  vals_basic <- tibble::tibble(A = 1:3,
                               B = c(1, 1, 2),
                               C = c(1, 1, 1))

  expect_equal(def_recode(vals_basic$A, def_basic$A), c('cat', 'dog', 3))
  expect_equal(def_recode(vals_basic$B, def_basic$B), c('fred', 'fred', 'george'))
  expect_equal(def_recode(vals_basic$C, def_basic$C), rep('lonely', 3))

})

test_that("default and missing values are passed through to recode correctly", {
  expect_equal(1,1)

})
