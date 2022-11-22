install.packages("cepR")

library(cepR)
token <- "2d849b70931302adc6a1f303d64b7156" # seu token

relacao <- c('22220040','22753330')

resp1 <- busca_cidades(estado = c("SP"), token=token)
resp2 <- busca_cep('22220040',token=token) 
resp3 <- busca_multi(lista_ceps = relacao, token = token)

head(resp1)
head(resp2)
head(resp3)

my_df <- c(resp3$cidade, resp3$latitude, resp3$longitude, resp3$bairro)

library(sf)
library(ggplot2)

my_sf <- st_as_sf(my_df, coords = c('longitude', 'latitude'))
                  
my_sf <- st_set_crs(my_sf, crs = 4326)
                  
#Plot it:
                  
ggplot(my_sf) + 
geom_sf(aes(color = bairro))