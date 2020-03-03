test_that("run_recode_all updates all the variables ", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                               value      = c(1,   2,   1,   2,   1),
                               definition = c('cat', 'dog', 'fred', 'george', 'lonely'))

  def_basic <- def_prep(dict_basic, variable, value, definition, drop_solos = FALSE)

  vals_basic <- tibble::tibble(ID = c('A1', 'A2', 'A3'),
                               A  = 1:3,
                               B  = c(1, 1, 2),
                               C  = c(1, 1, 1))

  vals_recoded <- def_recode_all(vals_basic, def_basic, .default = 'other')

  # just check all the individual columns I guess?
  expect_equal(vals_recoded$ID, c('A1', 'A2', 'A3'))
  expect_equal(vals_recoded$A, c('cat', 'dog', 'other'))
  expect_equal(vals_recoded$B, c('fred', 'fred', 'george'))
  expect_equal(vals_recoded$C, c('lonely', 'lonely', 'lonely'))
})
