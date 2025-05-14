library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(ggstats)
library(countrycode)
library(shinythemes)

# Carregar les dades (es carrega només una vegada)
data <- read.csv("data.csv", stringsAsFactors = TRUE)

# Funció per filtrar dades segons el continent
filter_by_continent <- function(data, continent_selection) {
  if (continent_selection == "World") {
    return(data)
  } else {
    return(data %>% subset(subset = continent == continent_selection))
  }
}

# Definir la UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel(
    div(
      style = "text-align: center;",
      HTML("<strong>Tracking the Origins of Global Tourism</strong>")
    )
  ),
  
  div(
    style = "text-align: center; font-size: 15px; font-style: italic; margin-top: 20px; margin-bottom: 30px;",
    HTML("Ever wondered where tourists come from? This platform lets you dive deep into global tourism data, from bustling cities to hidden gems.")
  ),
  
  
  # Tot el contingut dins de una sola columna ampla
  fluidRow(
    column (
      width = 12,
      
      #Introducció
      div(
        style = "margin-top: 30px; margin-bottom: 30px; display: flex; flex-direction: column; justify-content: center;",
        HTML("This interactive application allows you to explore global tourism trends, from the origins of travelers to key travel patterns. With a series of dynamic charts, we provide a comprehensive view of how tourists move around the world and how their travel habits vary by continent and season. Here’s what you can explore:<br><br>
      
      <strong>Tourist Origins</strong> An interactive map showing the regions with the highest number of outbound tourists. Europe stands out, with Portugal leading the way. This map helps you understand the main regions sending tourists abroad. <br><br>
      
      <strong>Monthly Trends</strong> A timeline chart illustrating tourist arrivals throughout the year. February and June are the peak months for travel, highlighting seasonal patterns. You can compare this data across continents to see global travel trends. <br><br>
      
      <strong>Accommodation Preferences</strong> We also explore where tourists stay. The charts show a clear preference for city hotels over rural ones, likely due to convenience and proximity to attractions. <br><br>

      <strong>Weekly Travel Habits</strong> A set of bar charts analyzing the days of the week when most tourists travel. Interestingly, Mondays are becoming popular for short getaways, as people prefer to extend their weekend or prepare for the workweek ahead. <br><br>

      <strong>Market Segmentation & Accommodation</strong> Analyzing how market segments influence accommodation choices, we see that urban hotels are the top choice for most travelers, offering a variety of amenities and easy access to activities. <br><br>
      
      This interactive platform lets you filter data by continent and compare trends across regions. Dive into the visualizations to gain a deeper understanding of global tourism and its evolving patterns.")
        ),
      ),
    column(
      width = 8,
      
      # Bloc 1: Mapa
      div(
        style = "margin-top: 100px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("mapa", "Select a continent:",
                    choices = c("World", as.character(unique(data$continent))),
                    selected = "World"),
        plotlyOutput("map", height = "400px")
        ),
      
      # Bloc 2: Timeline
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("timeline", "Select a continent:",
                    choices = c("World", as.character(unique(data$continent))),
                    selected = "World"),
        plotOutput("timeline", height = "400px")
        ),
      
      # Bloc 3: Bar1
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("bar1", "Select a continent:",
                    choices = c("World", as.character(unique(data$continent))),
                    selected = "World"),
        plotOutput("bar1", height = "400px")
        ),
      
      # Bloc 4: Bar2
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("bar2", "Select a continent:",
                    choices = c("World", as.character(unique(data$continent))),
                    selected = "World"),
        plotOutput("bar2", height = "400px")
        ),
      
      # Bloc 5: Bar3
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("bar3", "Select a continent:",
                    choices = c("World", as.character(unique(data$continent))),
                    selected = "World"),
        plotOutput("bar3", height = "400px")
        ),
      
      # Bloc 6: stack timeseries
      div(
        style = "margin-top: 150px; display: flex; flex-direction: column; justify-content: center;",
        selectInput("stack", "Select a continent:",
                    choices = c("World", as.character(unique(data$continent))),
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
        p("This map highlights the regions with the highest levels of outbound tourism. As shown, Europe stands out, with Portugal leading the way in sending tourists abroad. This trend reflects the strong travel culture in these regions, with Europeans frequently exploring new destinations. Portugal, in particular, shows a remarkable level of travel activity, surpassing many other countries in outbound tourism.")
        ),
      
      # Bloc 2: Timeline
      div(
        style = "margin-top: 200px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>February and June stand out: the peak months for travel</strong>")),
        p("February and June clearly stand out as the busiest months for travel. These spikes likely match popular holiday periods, like winter breaks and early summer vacations, when people are more likely to take time off and explore. The trend shows how seasonality plays a big role in shaping when tourists choose to travel. For many, these months offer the perfect balance between weather, availability, and the chance to disconnect from routine.")
        ),
      
      # Bloc 3: Bar1
      div(
        style = "margin-top: 230px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Holidays in the city</strong>")),
        p("This bar chart reveals an intriguing trend: instead of using Mondays for work-related travel, more people are opting for quick getaways and relaxation. It suggests that after a busy week, many see Monday as an opportunity to unwind before the full workweek starts. This shift could be driven by the desire to extend the weekend or to mentally prepare for the week ahead, turning what was once a workday into a mini-vacation day. Can you advise more patterns?")
      ),
      
      # Bloc 4: Bar2
      div(
        style = "margin-top: 250px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Monday getaways</strong>")),
        p("When it comes to holidays, most travelers choose cities over rural destinations. That can be because cities often offer better transportation, more entertainment options, and easy access to attractions, all of which make urban areas more appealing. While rural places may offer peace and natural beauty, tourists tend to prioritize convenience, variety, and comfort, which are easier to find in city settings.")
        ),
      
      # Bloc 5: Bar3
      div(
        style = "margin-top: 230px; height: 400px; display: flex; flex-direction: column; justify-content: center;",
        h4(HTML("<strong>Urban preference: cities outshine villages in almost every market segment</strong>")),
        p("The chart highlights a clear preference for city hotels over rural ones across nearly all market segments. Whether for convenience, amenities, or access to cultural attractions, cities offer the experiences that most travelers are seeking. Urban locations provide a variety of options, from business facilities to entertainment, making them the go-to choice for a wide range of tourists.")
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
    
    tit <- ifelse(input$mapa == "World", "Tourist origins - World", paste("Tourist origins -", input$mapa))
    
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
    
    tit <- ifelse(input$timeline == "World", "Monthly Tourist Arrivals - World", paste("Monthly Tourist Arrivals -", input$timeline))
    
    ggplot(df_filt, aes(x = arrival_date_month, y = n_tourists, group = 1)) +
      geom_smooth(method = "loess", se = FALSE, color = "steelblue", linewidth = 1.2, span = 0.2) +
      labs(x = "Month of arrival", y = "Tourists", title = tit) +
      theme_minimal() +
      scale_x_discrete(guide = guide_axis(angle = 45))
    })
  
  # Lògica reactiva per al gràfic 3
  output$bar1 <- renderPlot({
    df_filt <- filter_by_continent(data, input$bar1)
    
    tit <- ifelse(input$bar1 == "World", "Tourist travel type by hotel - World", paste("Tourist travel type by hotel -", input$bar1))
    
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
      mutate(arrival_weekday = factor(arrival_weekday, levels = weekday_levels))
    
    tit <- ifelse(input$bar2 == "World", "Tourist travel type composition by weekday - World", paste("Tourist travel type composition by weekday -", input$bar2))
    
    ggplot(df_filt, aes(x = arrival_weekday, fill = type, by = arrival_weekday)) +
      stat_count(geom = "bar", position = "stack") +
      geom_text(stat = "prop", position = position_stack(vjust = 0.5), color = "white", size = 3) +
      theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) +
      labs(x = "Day of week of arrival", y = element_blank(), title = tit) +
      theme_minimal() +
      scale_fill_brewer(palette = "Set2")
    })
  
  # Lògica reactiva per al gràfic 5
  output$bar3 <- renderPlot({
    df_filt <- filter_by_continent(data, input$bar3)
    
    tit <- ifelse(input$bar3 == "World", "Tourism by market segment - World", paste("Tourism by market segment -", input$bar3))
    
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
    
    tit <- ifelse(input$stack == "World", "Tourism by market segment - World", paste("Tourism by market segment -", input$stack))
    
    ggplot(df_filt, aes(x = arrival_date_month, y = n_tourists, fill = market_segment, group = market_segment)) +
      geom_area() +
      labs(x = "Month of arrival",
           y = "Tourists",
           title = tit) +
      theme_minimal() +
      scale_x_discrete(guide = guide_axis(angle = 45))
  })
}

# Executar l'aplicació
shinyApp(ui = ui, server = server)