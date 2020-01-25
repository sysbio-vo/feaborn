# Library
library("ggplot2")
library(ggradar)
library(dplyr)
library(scales)
library(tibble)

diffexp <- read.csv("data.csv")

diffexp_sorted <- diffexp[order(diffexp$adj.P.Val),][1:10,]

diffexp_grouping <- c(rep("II to I", 10), rep("III to II", 10))

diffexp_genes <- c(as.character(diffexp_sorted$SYMBOL), as.character(diffexp_sorted$SYMBOL))

diffexp_expression_i <- c(100*as.numeric(gsub(",","\\.",as.character(diffexp_sorted$ii...i))))
diffexp_expression_ii <- c(100*as.numeric(gsub(",","\\.",as.character(diffexp_sorted$iii...ii))))

diffexp_ggplot_dataframe <- data.frame(diffexp_expression_i,diffexp_expression_ii)
colnames(diffexp_ggplot_dataframe) <- c('expression_i','expression_ii')

diffexp_ggplot_dataframe <- cbind(as.data.frame(t(diffexp_ggplot_dataframe)))


rownames(diffexp_ggplot_dataframe) <- c('exp_1', 'exp_2')

diffexp_radar <- diffexp_ggplot_dataframe %>% 
  as_tibble(rownames = "group") %>% 
  mutate_at(vars(-group), rescale) %>% 
  tail(4) %>% 
  select(1:10)

ggradar(diffexp_radar)



