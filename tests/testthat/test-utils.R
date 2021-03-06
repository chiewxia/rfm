context("test-utils.R")

test_that('output from bins is as expected', {

  actual <- bins(mtcars, mpg, 5)
  expected <- c(16.20, 18.92, 22.00, 25.08)
  expect_equivalent(actual, expected)

})

test_that('output from bins_lower is as expected', {

  actual <- bins_lower(mtcars, mpg, 5)
  expected <- c(10.4, 5.0)
  expect_equivalent(actual, expected)
})

test_that('output from bins_upper is as expected', {

  actual <- bins_upper(mtcars, mpg, 5)
  expected <- c(5.0, 34.9)
  expect_equivalent(actual, expected)
})

test_that('output from heatmap_data is as expected', {

  analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
  actual <- rfm_table(rfm_data, customer_id, order_date, revenue,
                      analysis_date) %>%
    heatmap_data() %>%
    pull(monetary) %>%
    sum %>%
    round
  expected <- 12634
  expect_equal(actual, expected)

})

test_that('output from check_levels is as expected', {

  analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
  actual <- rfm_table(rfm_data, customer_id, order_date, revenue,
                      analysis_date) %>%
    heatmap_data() %>%
    check_levels(column = 2)
  expected <- c(1, 2, 3, 4, 5)
  expect_equivalent(actual, expected)

})

test_that('output from modify_rfm is as expected', {

  analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
  heat <- rfm_table(rfm_data, customer_id, order_date, revenue,
                    analysis_date) %>%
    heatmap_data()

  clevel <- heat %>%
    check_levels(column = 2)

  actual <- modify_rfm(heat, 5, clevel) %>%
    pull(monetary) %>%
    sum %>%
    round

  expected <- 12634
  expect_equal(actual, expected)

})
