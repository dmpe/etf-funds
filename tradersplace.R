library(tidyverse)
library(rvest)
# https://stackoverflow.com/a/63786716

# Extract "free" ETFs from tradersplace.de website (Feb 2024)

url <- "https://tradersplace.de/angebot/angebot/sparplaene"
DWS_xtrackers_xpath <- "/html/body/main/div[2]/div[4]/div/div/div/div/div[2]/div/div/div/div/div"
ishares_xpath       <- "/html/body/main/div[2]/div[5]/div/div/div/div/div[2]/div/div[2]/div/div/div"
amundi_xpath        <- "/html/body/main/div[2]/div[3]/div/div/div/div/div[2]/div/div/div/div/div"
resp <- rvest::read_html(url)

ishares <- resp %>%
  html_elements(xpath=ishares_xpath) %>% 
  html_table() %>% 
  first() %>% 
  slice(-1:-2) %>% 
  `colnames<-`(.[1, ]) %>%
  .[-1, ]
  
amundi <- resp %>%
  html_elements(xpath=amundi_xpath) %>% 
  html_table() %>% 
  first() %>% 
  slice(-1:-2) %>% 
  `colnames<-`(.[1, ]) %>%
  .[-1, ]

dws <- resp %>%
  html_elements(xpath=DWS_xtrackers_xpath) %>% 
  html_table() %>% 
  first() %>% 
  slice(-1:-2) %>% 
  `colnames<-`(.[1, ]) %>%
  .[-1, ] %>% 
  select(Bezeichnung, ISIN)


free_etfs_tradersplace <- bind_rows(amundi,dws,ishares)








