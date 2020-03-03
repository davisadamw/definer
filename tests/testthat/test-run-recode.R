test_that("recode returns original values when run with null definitions", {
  expect_equal(def_recode(1:10, NULL), 1:10)
})

test_that("recode works with definitions produced by def_prep", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                               value      = c(1,   2,   1,   2,   1),
                               definition = c('cat', 'dog', 'fred', 'george', 'lonely'))

  def_basic <- def_prep(dict_basic, variable, value, definition, drop_solos = FALSE)

  vals_basic <- tibble::tibble(A = 1:3,
                               B = c(1, 1, 2),
                               C = c(1, 1, 1))

  # if .x includes values not present in your definitions, it should throw an error, but convert them to NAs if type would change
  expect_warning(recodeA <- def_recode(vals_basic$A, def_basic$A), "Unreplaced values")
  expect_equal(recodeA, c('cat', 'dog', NA))
  expect_equal(def_recode(vals_basic$B, def_basic$B), c('fred', 'fred', 'george'))
  expect_equal(def_recode(vals_basic$C, def_basic$C), rep('lonely', 3))

})

test_that("default and missing values are passed through to recode correctly", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                               value      = c(1,   2,   1,   2,   1),
                               definition = c('cat', 'dog', 'fred', 'george', 'lonely'))

  def_basic <- def_prep(dict_basic, variable, value, definition, drop_solos = FALSE)

  vals_basic <- tibble::tibble(A = 1:3,
                               B = c(1, 2, NA),
                               C = c(1, 2, NA))

  expect_equal(def_recode(vals_basic$A, def_basic$A, .default = 'fish'), c('cat', 'dog', 'fish'))
  expect_equal(def_recode(vals_basic$B, def_basic$B, .missing = 'other'), c('fred', 'george', 'other'))
  expect_equal(def_recode(vals_basic$C, def_basic$C, .default = 'another', .missing = 'other'),
               c('lonely', 'another', 'other'))

})

test_that("arguments are passed through correctly from def_recode_pick to def_recode", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'A'),
                               value      = c(1,   2,   3),
                               definition = c('cat', 'dog', 'fish'))

  def_basic <- def_prep(dict_basic, variable, value, definition)

  expect_equal(def_recode_pick(1:3, 'A', def_basic), c('cat', 'dog', 'fish'))
  expect_equal(def_recode_pick(1:4, 'A', def_basic, .default = 'other'),
               c('cat', 'dog', 'fish', 'other'))
  expect_equal(def_recode_pick(c(1:3, NA), 'A', def_basic, .missing = 'other2'),
               c('cat', 'dog', 'fish', 'other2'))
  expect_equal(def_recode_pick(1:3, 'Z', def_basic), 1:3)
})
