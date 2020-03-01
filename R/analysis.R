library(tidyverse)
library(readr)



# Access Daily Covid-19 Dataset -------------------------------------------

Confirmed <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv")
Deaths <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv")
Recovered <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv")





# data wrangling ----------------------------------------------------------

Confirmed <- wrangle_covid_raw(Confirmed) %>% 
  rename("acum_confirmed" = acum_value)
Deaths <- wrangle_covid_raw(Deaths) %>% 
  rename("acum_deaths" = acum_value)
Recovered <- wrangle_covid_raw(Recovered) %>% 
  rename("acum_recovered" = acum_value)

covid_all <- Confirmed %>% 
  mutate(acum_deaths = Deaths$acum_deaths) %>% 
  mutate(acum_recovered = Recovered$acum_recovered) %>% 
  select(-value, -Lat, -Long) %>% 
  mutate(state_country = ifelse(`Country/Region` == "Mainland China",
                                `Province/State`,
                                `Country/Region`))

write_csv(covid_all, "data/covid_all.csv")
