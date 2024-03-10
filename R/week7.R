# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
install.packages("GGally")
library(GGally)
library(ggplot2)

# Data Import and Cleaning
week7_tbl <- read.csv("data/week3.csv", header = TRUE) %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(timeEnd = ymd_hms(timeEnd)) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units =c("mins"))) 




# Visualization
week7_tbl %>%
  select(q1:q10) %>%
  ggpairs


