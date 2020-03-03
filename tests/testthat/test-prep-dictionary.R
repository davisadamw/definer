test_that("basic dictionary structure works", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                               value      = c(1,   2,   1,   2,   1),
                               definition = c('cat', 'dog', 'fred', 'george', 'lonely'))

  def_basic <- def_prep(dict_basic, variable, value, definition)

  # first, test it with
  expect_equal(def_basic,
               list('A' = c(`1` = 'cat', `2` = 'dog'),
                    'B' = c(`1` = 'fred', `2` = 'george')))

})

test_that("variables with incomplete values sets are set up correctly", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A'),
                               value      = c(3, 4),
                               definition = c('bird', 'fish'))

  expect_equal(def_prep(dict_basic, variable, value, definition),
               list('A' = c(`3` = 'bird', `4` = 'fish')))
})
