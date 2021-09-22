library(dplyr)
library(tidytext)
library(igraph)
install.packages("ggraph")
library(ggraph)

all_words <- #data frame with the text that we need to analyze

a <- all_words %>% unnest_tokens(word, Recensione)

a_count <- count(a, word) #conteggio numero di parole singole


  
a_bigrams <- all_words %>% unnest_tokens(bigram, Recensione, token = "ngrams", n = 2)

a_bigrams_count <- a_bigrams %>% count(bigram, sort = TRUE) 



a_trigrams <- all_words %>% unnest_tokens(trigram, Recensione, token = "ngrams", n = 3)

a_trigrams_count <- a_trigrams %>% count(trigram, sort = TRUE) 


a_quadrigrams <- all_words %>% unnest_tokens(quadrigram, Recensione, token = "ngrams", n =4)

a_quadrigrams_count <- a_quadrigrams %>% count(quadrigram, sort = TRUE) 

bigram_graph <- a_bigrams_count %>% filter(n > 20) %>% graph_from_data_frame()



set.seed(2017)

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)


set.seed(2020)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(, show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()
