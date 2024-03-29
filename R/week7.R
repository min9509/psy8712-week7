# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
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
week7_tbl[,5:13] %>%
  ggpairs() %>%
  ggsave(filename = "./figs/Fig0.png")
(week7_tbl %>%
  ggplot(aes(x = timeStart, y = q1)) +
  geom_point() +
  labs(x = "Date of Experiment", y = "Q1 Score"))  %>%
  ggsave(filename = "./figs/Fig1.png")

(week7_tbl %>%
  ggplot(aes(x = q1, y = q2, color = gender)) +
  geom_point (position = "jitter") +
  labs(color = "Participant Gender")) %>%
  ggsave(filename = "./figs/Fig2.png")
(week7_tbl %>% 
  ggplot(aes (x = q1, y = q2)) +
  geom_point (position = "jitter") +
  facet_grid(.~gender) + 
  labs(x = "Score on Q1", y = "Score on Q2"))  %>%
  ggsave(filename = "./figs/Fig3.png")

(week7_tbl %>% 
  ggplot(aes(x = gender, y = timeSpent)) +
  geom_boxplot () +
  labs(x = "Gender", y = "Time Elapsed (mins)")) %>% 
  ggsave(filename = "./figs/Fig4.png")

(week7_tbl %>%
  ggplot(aes(x = q5, y = q7, color = condition, fill = condition)) +
  geom_point (position = "jitter") +
  geom_smooth (method = "lm", se = FALSE) +
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition", fill = "Experimental Condition") +
  theme(legend.position = "bottom", legend.background = element_rect("#E0E0E0"))) %>%
  ggsave(filename = "./figs/Fig5.png")