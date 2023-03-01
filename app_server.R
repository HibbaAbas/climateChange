library(tidyverse)
#install.packages("rsconnect")
#install.packages("remotes")
#remotes::install_github("davidsjoberg/ggstream")
# devtools::install_github("hrbrmstr/streamgraph")
library(streamgraph)

library(rsconnect)


# code for introduction page goes here



# load in data


co2_data <- read.csv("owid-co2-data.csv")
co2_data <- co2_data %>%
  select(country, year, coal_co2)



# remove zones from data
remove_place <- c("World", "Asia", "Africa", "Africa (GCP)", "Asia (GCP)", 
                  "Asia (excl. China and India)", 	
                  "Central America (GCP)", "Europe",
                  "Europe (GCP)", "Europe (excl. EU-27)",
                  "Europe (excl. EU-28)", "European Union (27)",
                  "European Union (27) (GCP)", "European Union (28)",
                  "High-income countries", "Lower-middle-income countries",
                  "Middle East (GCP)", "North America", 
                  "North America (GCP", "North America (excl. USA)", 
                  "South America", "Upper-middle-income countries")


server <- function(input, output) {
  
  #Introduction
  
  #country with most coal use in 2021
  output$max_country <- renderText({
    max_country <- co2_data %>%
      filter(year == 2021, is.element(country, remove_place) == FALSE) %>%
      filter(coal_co2 == max(coal_co2, na.rm = TRUE)) %>%
      select(country)
    
    paste("", max_country)
  }) 
  
  #amount of coal used by max country in 2021
  output$max_2021 <- renderText({
    max_2021 <- co2_data %>%
      filter(year == 2021, is.element(country, remove_place) == FALSE) %>%
      filter(coal_co2 == max(coal_co2, na.rm = TRUE)) %>%
      select(coal_co2)
    
    paste("", max_2021)
  })
  
  # how much coal used by max country in begining
  output$china <- renderText({
    china_1850 <- co2_data %>%
      filter(country == "China") %>%
      filter(coal_co2 == min(coal_co2, na.rm = TRUE)) %>%
      select(coal_co2)

    # year was seen in data frame
    paste("", china_1850, " in 1912")
  })
  
  # countries with the least amount of coal usage
  output$min_country <- renderText({
    min_country <- co2_data %>%
      filter(year == 2021, is.element(country, remove_place) == FALSE) %>%
      filter(coal_co2 == min(coal_co2, na.rm = TRUE)) 
    
    con <- paste(min_country$country, collapse = ", ")
    
    con
  })
  
  # Interactive Visualization
  output$test_graph <- renderStreamgraph({
    #read user input
    test_coun <- input$countries
    time_frame <- input$date
    
    time_1 <- time_frame[1]
    time_2 <- time_frame[2]
    
    #make data frame with chosen countries and dates
    test_data <- co2_data %>%
      filter(is.element(country, test_coun)) %>%
      filter(year >= time_1, year <= time_2)
    
    #colors for graph
    #cols <- c("#de69e5", "#b1cdcc", "#f3d18e", "#fbcf18", "#e6a819", "#f2d0ad", "#5c4645", "#b69a90", "#653e2f")
    
    #make a streamgraph 
    testy <- streamgraph(test_data, date = "year", value = "coal_co2", key = "country", offset="expand",
                         width="400px", height="300px") 
    
    testy
  })
}
