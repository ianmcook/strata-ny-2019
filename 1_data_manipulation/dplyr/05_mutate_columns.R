# Copyright 2019 Cloudera, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# # Creating new columns in an R data frame

# Load packages and read games data
library(readr)
library(dplyr)
games <- read_csv("data/games/games.csv")
games


# Use the dplyr verb `mutate()` to return a data frame
# with a new column added to it.

# The new column can contain a scalar value (repeated in 
# every row) or it can be calculated using an
# expression that uses the values in other columns
games %>% mutate(tax_percent = 0.08875)

games %>% 
  mutate(
    price_with_tax = 
      round(list_price * 1.08875, 2)
  ) %>% 
  as.data.frame()

# You can create multiple columns with one call to the
# `mutate()` function, and you can reference columns that you
# just created in the same `mutate()`
games %>% 
  mutate(
    tax_percent = 0.08875,
    price_with_tax = 
      round(list_price * (1 + tax_percent), 2)
  ) %>% 
  as.data.frame()


# ## Replacing columns

# You can replace existing columns the same way you make
# new columns
games %>% mutate(
  name = toupper(name),
  inventor = tolower(inventor)
)


# ## Changing column data types

# To return a data frame with one or more columns
# converted to different data types, use an `as.`
# function in `mutate()`. For example: `as.character()`,
# `as.numeric()`, or `as.integer()`. Use `as.factor()`
# to encode a column as a factor (a categorical column).
games %>% mutate(
  name = as.factor(name),
  year = as.character(year)
)


# ## Renaming columns

# To return a data frame with one or more columns renamed,
# use the `rename()` function.
games %>% 
  rename(
    game_id = id,
    price = list_price
  )


# ## Removing columns

# To return a data frame with one or more columns removed,
# use the `select()` function with a minus sign before
# the vector of columns to be removed
games %>% 
  select(-c(inventor, min_age))


# ## Replacing missing values

# Load the inventory data (since the games data has no
# missing values)
inventory <- read_tsv('data/inventory/data.txt')
inventory

# Use the `ifelse()` and `is.na()` functions
inventory %>%
  mutate(price = ifelse(is.na(price), 0, price))


# ## Iterating over rows

# You can call vectorized R functions in `mutate()` and
# in other dplyr verbs to iterate over the rows of a 
# data frame
games %>%
  mutate(
    name = ifelse(name == "Clue", "Cluedo", name)
  )
