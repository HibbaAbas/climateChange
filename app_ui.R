library(shiny)
library(shinyWidgets)
#install.packages("shinyWidgets")

# application display settings go here

page_one <- tabPanel(
  "Introduction",
  titlePanel("Coal CO2 Emmissons"),
  sidebarLayout(
    mainPanel(
      h2("Coal Use "),
      p("Over 300 million years ago, huge pre-historic plants died out. Over the course of hundreds of
      millions of years, those dead plants were buried under water and dirt. The combination fo heat, pressure,
      and time turned those dead plants into what we call coal. Coal has been used by humans for centuries, they 
      would use it for heating and cooking, and prefered it over wood as it would last longer. Around the 1800's
      people began to use coal to run the majority of their world. It was used for heating, fueling ships and trains, 
      running factories, etc. It is one of the oldest modes of fossil fuels. It is also the fossil fuel that produces 
      the most CO2 emissions out of all other forms."),
      p("The purpose of this site is to provide the public with knowledge of different countries' coal usage. All data
        is drawn from ", em("Our World in Data's"), "CO2 and Greenhouse Gas Emissions dataset. While this dataset
        tracks many different emissions, I will be focusing only on their annual production-based coal emissions.
        All emissions are measured in million tonnes. Emissions created from traded goods are not counted. "),
      p("Looking at the dataset, the country with the greatest coal emissions in 2021 was", textOutput(outputId = "max_country", inline = TRUE),
        "with", textOutput(outputId = "max_2021", inline = TRUE), ". In 1850, when the coal emissons had began to be tracked,
        China had no recorded coal emissions. Their earliest recording was", textOutput(outputId = "china", inline = TRUE))
    ),
    sidebarPanel(
      h3("Countries with lowest coal emissions (2021):"),
      strong("All 93 of these countires contribute 0% of the world's coal emissions"),
      textOutput(outputId = "min_country", inline = TRUE)
      
    )
  )
  
)

countries <- c("Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua & Deps", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Rep", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Congo {Democratic Rep}", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland {Republic}", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea North", "Korea South", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar, {Burma}", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russian Federation", "Rwanda", "St Kitts & Nevis", "St Lucia", "Saint Vincent & the Grenadines", "Samoa", "San Marino", "Sao Tome & Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Tonga", "Trinidad & Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe")

page_two <- tabPanel(
  "Visualization",
  titlePanel("Interactive Visualization"),
  h3("Choose Plot Settings:"),
  strong("Only a max of nine countries may be selected"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "countries",
        label = "countries",
        choices = countries,
        selected = c("United States", "Canada", "Russia", "China"),
        multiple = TRUE
      ),
      sliderInput(inputId = "date",
                  label = "Time Frame",
                  min = as.Date("1850", "%Y"), 
                  max = as.Date("2021", "%Y"),
                  value = c(as.Date("1950", "%Y"), as.Date("2020", "%Y"))
                  )
    ),
    mainPanel(
      h2("Proportion of Coal Usage Between Countries"),
      streamgraphOutput(outputId = "test_graph"),
      p(""),
      p(""),
      p("This streamgraph shows the proportion of coal usage between different countires. In these times, 
        everything is interconnencted. Most decisions made by a country will somehow effect the countries around it.
        This is especially true when it comes to things like coal usage. Often countries that expel the most CO2
        emissions, do not face enviromental repercussions, other countries who are not expelling as much do. So it
        is important to track all countries emissions and compare who is putting out the most and least amount of 
        emissions."),
      p("Something I noticed by playing around with the visualization was, with European countries, the UK seemed to 
        be expelling the most coal CO2 emissions up until the 1950's. After the 1950's the proportion of coal emissions
        became more even between the countries. It seems that after 1950, Germany has the majority of coal emissions.
        Countires like Ukraine and Spain had quite a bit of an upward tick in coal emissions after 1970. It was quite
        jarring to add the United States to the plot, as the graph shifts extremly to favor the US after 1900, and most European
        countries becomes small slivers. It seems like the 1900's was a turning point for most countires. Either their
        coal emissions began a decrease or an increase.")
    )
  )
 
)



ui_pages <- navbarPage(
  "Coal + CO2",
  setBackgroundColor("#A9DFBF"),
  page_one,
  page_two,
  
)
