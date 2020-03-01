
wrangle_covid_raw <- function(data){
  
  data %>% 
    pivot_longer(5:43, names_to = "Date") %>% 
    mutate(Date = str_c(Date, "20")) %>% 
    mutate(Date = as.Date(Date, format = "%m/%d/%y")) %>% 
    group_by(`Country/Region`, `Province/State`) %>% 
    mutate(acum_value = value + lag(value)) %>% 
    mutate(acum_value = if_else(is.na(acum_value), value, acum_value)) %>% 
    ungroup()

}
