# Import libraries
library(dplyr)
library(tidytext)
library(ggplot2)
library(wordcloud)
library(knitr)
#check articles

data <- readLines("C:/Thematic/slr3.txt")
#n is the total number of lines in the text file of abstracts 
head(data, n = 871)
data1 <- tibble(Text = data)
#convert
head(data1, n = 871)
words <- data1 %>% unnest_tokens(output = word, input = Text)
words <- words %>% anti_join(stop_words)
wordcounts <- words %>% count(word, sort = TRUE)
head(wordcounts)
#n is minimum frequency here
wordcounts %>%
  filter(n >= 75) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  coord_flip() +
  labs(x = "Themes \n", y = "\n Count ") +
  geom_text(aes(label = n), hjust = 1.2, color = "white", fontface = "bold") +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.title.x = element_text(face = "bold", colour = "red", size = 10),
    axis.title.y = element_text(face = "bold", colour = "red", size = 10)
  )
wordcloud(wordcounts$word, freq = wordcounts$n, min.freq = 15)


table_data <- wordcounts %>%
  filter(n >= 100) %>%
  arrange(desc(n))

# Print the table using kable
kable(table_data, caption = "Words and Their Number of Occurrences")

