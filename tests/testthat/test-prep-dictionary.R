test_that("basic dictionary structure works", {
  dict_basic <- tibble::tibble(variable   = c('A', 'A', 'B', 'B', 'C'),
                               value      = c(1,   2,   1,   2,   1),
                               definition = c('cat', 'dog', 'fred', 'george', 'lonely'))

  # first, test it with
  expect_equal(def_prep(dict_basic, variable, value, definition),
               list('A' = c('cat', 'dog'),
                    'B' = c('fred', 'george')))

})

test_that("variables with incomplete values sets are set up correctly", {
  dict_basic <- data.frame(variable   = c('A', 'A'),
                           value      = c(3, 4),
                           definition = c('bird', 'fish'))

  # I'm not really sure this is desirable behavior here tbh
  # it might be better to pass in names explicitly instead of creating them
  expect_equal(def_prep(dict_basic, variable, value, definition),
               list('A' = c(NA, NA, 'bird', 'fish')))
})
