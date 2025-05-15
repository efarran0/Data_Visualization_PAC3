if (!require('shiny')) install.packages('shiny'); library(shiny)
if (!require('dplyr')) install.packages('dplyr'); library(dplyr)
if (!require('ggplot2')) install.packages('ggplot2'); library(ggplot2)
if (!require('plotly')) install.packages('plotly'); library(plotly)
if (!require('ggstats')) install.packages('ggstats'); library(ggstats)
if (!require('countrycode')) install.packages('countrycode'); library(countrycode)
if (!require('shinythemes')) install.packages('shinythemes'); library(shinythemes)

# Carregar les dades (es carrega només una vegada)
data <- read.csv("data/data.csv", stringsAsFactors = TRUE)

# Funció per filtrar dades segons el continent
filter_by_continent <- function(data, continent_selection) {
  if (continent_selection == "World") {
    return(data)
  } else {
    return(data %>% subset(subset = continent == continent_selection))
  }
}

continent_choices <- c("World", as.character(unique(data$continent)))

# Definir la UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel(
    div(
      style = "text-align: center;",
      HTML("<strong>Tracking the origins of Portgual tourism</strong>")
    )
  ),
  
  div(
    style = "text-align: center; font-size: 15px; font-style: italic; margin-top: 20px; margin-bottom: 30px;",
    HTML("Ever wondered where Portgual tourists come from? This platform lets you dive deep into Portgual tourism data, from bustling cities to hidden gems.")
  ),
  
  
  # Tot el contingut dins de una sola columna ampla
  fluidRow(
    column (
      width = 12,
      
      #Introducció
      div(
        style = "margin-top: 30px; margin-bottom: 30px; display: flex; flex-direction: column; justify-content: center;",
        HTML("This interactive application allows you to explore global tourism trends, from the origins of travelers to key travel patterns. With a series of dynamic charts, we provide a comprehensive view of how tourists move around the world and how their travel habits vary by continent and season. Here’s what you can explore:<br><br>
      
      <strong>Tourist Origins</strong> An interactive map showing the regions with the highest number of Portugal tourists. Europe stands out, with Portugal leading the way. This map helps you understand the main regions sending tourists abroad. <br><br>
      
      <strong>Monthly Trends</strong> A timeline chart illustrating tourist arrivals throughout the year. February and June are the peak months for travel, highlighting seasonal patterns. You can compare this data across continents to see global travel trends. <br><br>
      
      <strong>Accommodation Preferences</strong> We also explore where tourists stay. The charts show a clear preference for city hotel over rural one, likely due to convenience and proximity to attractions. <br><br>

      <strong>Weekly Travel Habits</strong> A set of bar charts analyzing the days of the week when most tourists travel. Interestingly, Mondays are becoming popular for short getaways, as people prefer to extend their weekend or prepare for the workweek ahead. <br><br>

      <strong>Market Segmentation & Accommodation</strong> Analyzing how market segments influence accommodation choices, we see that urban hotel is the top choice for most travelers, offering a variety of amenities and easy access to activities. <br><br>
      
      This interactive platform lets you filter data by continent and compare trends across regions. Dive into the visualizations to gain a deeper understanding of global tourism and its evolving patterns.")
      ),
    ),
    column(
      width = 8,
      
      # Bloc 1: Mapa
      div(
        style = "margin-top: 100px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("mapa", "Select a continent:",
                    choices = continent_choices,
                    selected = "World"),
        plotlyOutput("map", height = "400px")
      ),
      
      # Bloc 2: Timeline
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("timeline", "Select a continent:",
                    choices = continent_choices,
                    selected = "World"),
        plotOutput("timeline", height = "400px")
      ),
      
      # Bloc 3: Bar1
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("bar1", "Select a continent:",
                    choices = continent_choices,
                    selected = "World"),
        plotOutput("bar1", height = "400px")
      ),
      
      # Bloc 4: Bar2
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("bar2", "Select a continent:",
                    choices = continent_choices,
                    selected = "World"),
        plotOutput("bar2", height = "400px")
      ),
      
      # Bloc 5: Bar3
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("bar3", "Select a continent:",
                    choices = continent_choices,
                    selected = "World"),
        plotOutput("bar3", height = "400px")
      ),
      
      # Bloc 6: stack timeseries
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("stack", "Select a continent:",
                    choices = continent_choices,
                    selected = "World"),
        plotOutput("stack", height = "400px")
      )
    ),
    
    column(
      width = 4,  # Text explicatiu
      
      # Bloc 1: Mapa
      div(
        style = "margin-top:120px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Portugal and Europe tourism outflow: leaders in outbound tourism</strong>")),
        p("This map highlights the regions with the highest levels of Portugal tourism. As shown, Europe stands out, with Portugal leading the way. This trend reflects the strong travel culture in these regions, with Europeans frequently exploring new destinations. Portugal, shows a remarkable level of national travel activity.")
      ),
      
      # Bloc 2: Timeline
      div(
        style = "margin-top: 200px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>February, June and September stand out: the peak months for travel</strong>")),
        p("February, June and September clearly stand out as the busiest months for travel. These spikes likely match popular holiday periods in the country, like winter breaks and early summer vacations, when people are more likely to take time off and explore. The trend shows how seasonality plays a big role in shaping when tourists choose to travel. For many, these months offer the perfect balance between weather, availability, and the chance to disconnect from routine.")
      ),
      
      # Bloc 3: Bar1
      div(
        style = "margin-top: 230px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Holidays in the city</strong>")),
        p("When it comes to holidays, most travelers choose city over rural destination. That can be because city often offer better transportation, more entertainment options, and easy access to attractions, all of which make urban area more appealing. While rural place may offer peace and natural beauty, tourists tend to prioritize convenience, variety, and comfort, which are easier to find in city settings.")
      ),
      
      # Bloc 4: Bar2
      div(
        style = "margin-top: 250px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Monday getaways</strong>")),
        p("This bar chart reveals an intriguing trend: instead of using Mondays for work-related travel, more people are opting for quick getaways and relaxation. It suggests that after a busy week, many see Monday as an opportunity to unwind before the full workweek starts. This shift could be driven by the desire to extend the weekend or to mentally prepare for the week ahead, turning what was once a workday into a mini-vacation day. Can you advise more patterns?")
      ),
      
      # Bloc 5: Bar3
      div(
        style = "margin-top: 230px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Urban preference: cities outshine villages in almost every market segment</strong>")),
        p("The chart highlights a clear preference for city hotel over rural one across nearly all market segments. Whether for convenience, amenities, or access to cultural attractions, city offer the experiences that most travelers are seeking. Urban location provide a variety of options, from business facilities to entertainment, making them the go-to choice for a wide range of tourists.")
      ),
      
      # Bloc 6: stack
      div(
        style = "margin-top: 230px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Online travel agencies as the primary source driving hotel booking</strong>")),
        p("Online travel agencies (OTAs) have become the primary source for hotel bookings, offering a wide range of options and competitive pricing. They provide features like user reviews and personalized recommendations, making it easier for travelers to find accommodations. Hotels have adapted by strengthening their digital presence to stay competitive. OTAs have reshaped the hospitality industry, offering convenience for travelers and broader reach for hotels. They play a crucial role in the global travel ecosystem.")
      )
    )
  )
)

# Definir la lògica del servidor
server <- function(input, output) {
  
  # Lògica reactiva per al grafic 1
  df_map <- reactive({
    filter_by_continent(data, input$mapa)
  })
  
  output$map <- renderPlotly({
    df_filt <- df_map() %>%
      group_by(country) %>%
      summarise(n_tourists = sum(n_total), .groups = "drop") %>%
      mutate(iso3 = countrycode(country, "country.name", "iso3c"))
    
    tit <- paste("Portugal tourist origins -", input$mapa)
    
    plot_ly(data = df_filt,
            locations = ~iso3,
            z = ~n_tourists,
            text = ~paste(country, "<br>", "Tourists:", n_tourists),
            type = 'choropleth',
            hoverinfo = 'text',
            colors = 'Reds',
            marker = list(line = list(color = "black", width = 0.5)),  # 👈 Canvia la frontera dels països acolorits
            showscale = FALSE) %>%
      layout(geo = list(projection = list(type = "natural earth"),
                        showland = TRUE,
                        landcolor = "lightgray",
                        subunitwidth = 1,
                        fitbounds = "locations"),
             title = tit)
  })
  
  # Lògica reactiva per al gràfic 2
  month_levels <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
  df_timeline <- reactive({
    filter_by_continent(data, input$timeline)
  })
  
  output$timeline <- renderPlot({
    df_filt <- df_timeline() %>%
      mutate(arrival_date_month = factor(arrival_date_month, levels = month_levels)) %>%
      group_by(arrival_date_month) %>%
      summarise(n_tourists = sum(n_total), .groups = "drop")
    
    tit <- paste("Monthly Portgual tourist arrivals -", input$mapa)
    
    ggplot(df_filt, aes(x = arrival_date_month, y = n_tourists, group = 1)) +
      geom_smooth(method = "loess", se = FALSE, color = "steelblue", linewidth = 1.2, span = 0.2) +
      labs(x = "Month of arrival", y = "Tourists", title = tit) +
      theme_minimal() +
      scale_x_discrete(guide = guide_axis(angle = 45))
  })
  
  # Lògica reactiva per al gràfic 3
  output$bar1 <- renderPlot({
    df_filt <- filter_by_continent(data, input$bar1)
    
    tit <- paste("Portugal tourist travel type by hotel -", input$bar1)
    
    ggplot(df_filt, aes(x = type, fill = hotel, by = type)) +
      stat_count(geom = "bar", position = "fill") +
      geom_text(stat = "prop", position = position_fill(vjust = 0.5), color = "white", size = 3) +
      theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) +
      labs(x = "Day of week of arrival", y = element_blank(), title = tit) +
      theme_minimal() +
      scale_fill_brewer(palette = "Set2")
  })
  
  # Lògica reactiva per al gràfic 4
  weekday_levels <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
  df_bar2 <- reactive({
    filter_by_continent(data, input$bar2)
  })
  
  output$bar2 <- renderPlot({
    df_filt <- df_bar2() %>%
      mutate(arrival_weekday = factor(arrival_weekday, levels = weekday_levels)) %>%
      group_by(arrival_weekday, type) %>%
      summarise(n_tourists = sum(n_total), .groups = "drop") %>%
      group_by(arrival_weekday) %>%
      mutate(prop = n_tourists / sum(n_tourists))
    
    tit <- paste("Portugal tourist travel type composition by weekday -", input$bar2)
    
    ggplot(df_filt, aes(x = arrival_weekday, y = n_tourists, fill = type)) +
      geom_bar(stat = "identity", position = "stack") +
      geom_text(aes(label = scales::percent(prop, accuracy = 0.1)),
                position = position_stack(vjust = 0.5),
                color = "white", size = 3) +
      theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) +
      labs(x = "Day of week of arrival", y = "Tourists", title = tit) +
      theme_minimal() +
      scale_fill_brewer(palette = "Set2")
  })
  
  # Lògica reactiva per al gràfic 5
  output$bar3 <- renderPlot({
    df_filt <- filter_by_continent(data, input$bar3)
    
    tit <- paste("Portugal tourism market segment by hotel -", input$bar3)
    
    ggplot(df_filt, aes(x = market_segment, fill = hotel, by = market_segment)) +
      stat_count(geom = "bar", position = "fill") +
      geom_text(stat = "prop", position = position_fill(vjust = 0.5), color = "white", size = 3) +
      theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) +
      labs(x = "Tourists market segment", y = element_blank(), title = tit) +
      theme_minimal() +
      scale_fill_brewer(palette = "Set2")
  })
  
  # Lògica reactiva per al gràfic 6
  df_stack <- reactive({
    filter_by_continent(data, input$stack)
  })
  
  output$stack <- renderPlot({
    df_filt <- df_stack() %>%
      mutate(arrival_date_month = factor(arrival_date_month, levels = month_levels)) %>%
      group_by(arrival_date_month, market_segment) %>%
      summarise(n_tourists = sum(n_total), .groups = "drop")
    
    tit <- paste("Portugal tourism by market segment -", input$stack)
    
    ggplot(df_filt, aes(x = arrival_date_month, y = n_tourists, fill = market_segment, group = market_segment)) +
      geom_area() +
      labs(x = "Month of arrival", y = "Tourists", title = tit) +
      theme_minimal() +
      scale_x_discrete(guide = guide_axis(angle = 45))
  })
}

# Executar l'aplicació
shinyApp(ui = ui, server = server)