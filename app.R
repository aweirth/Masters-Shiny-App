# Packages
library(shiny)
library(DT)
library(tidyverse)
library(plotly)

##############################
# Data Wrangling & Definitions
##############################

masters <- read_csv("data/masters2021_cleaned111.csv")

# Main leader board table will be leader board with place, Name, each round score, final score to par, and winnings
masters_lb <- read_csv("data/masters2021_lb.csv") %>%
  arrange(score_to_par)

# Data wrangling to get averages for entire field
masters2 <- masters %>%
  pivot_longer(cols = c(sg_app, sg_arg, sg_ott, sg_putt, sg_t2g), 
               names_to = "stat", values_to = "strokes_gained") %>%
  mutate(stat = forcats::fct_recode(stat,
                                    "Tee to Green" = "sg_t2g",
                                    "Putting" = "sg_putt",
                                    "Off the Tee" = "sg_ott",
                                    "Around the Green" = "sg_arg",
                                    "Approach" = "sg_app"
  ))

# Custom CSS
css <- HTML(
  "
  .navbar {
    background-color: #e6efea !important;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
    margin-bottom: -45px;
    z-index: 1;
  }
  .navbar-default .navbar-nav>li>a {
    background-color: #e6efea !important;
    color: black !important;
  }
  .navbar-default .navbar-nav>li:hover>a {
    background-color: #006747 !important;
    color: white !important;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
  }
  .navbar-default .navbar-nav>.active>a,
  .navbar-default .navbar-nav>.active>a:focus,
  .navbar-default .navbar-nav>.active>a:hover {
    background-color: #006747 !important;
    color: white !important;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
  }
  .custom-title {
    background-color: #006747;
    color: white;
    font-weight: bold;
    padding: 10px;
    text-align: center;
    font-size: 24px;
  }

  .custom-data-table thead th {
    background-color: #006747 !important;
    color: white !important;
    border: 1px solid white !important;
    font-size: 14px !important;
  }

  .custom-data-table tr {
    background-color: #e6efea !important;
  }

  .custom-player-header {
    text-align: center;
    font-size: 100px;
    font-weight: bold;
    color: #046d53;
    margin-bottom: 200px;
  }

  .small-image {
    width: 150px;
  }
  "
)


################################################################################


################
# USER INTERFACE
################

ui <- fluidPage(
  tags$head(
    tags$style(
      css
      )
    ),
  div(class = "custom-title", "2021 Masters Tournament Data Dashboard"),
  navbarPage(
    "",
    tabPanel("Leaderboard/Analysis", icon = icon("list-ol"), {
      fluidRow(
        #column(4, imageOutput("mastersSymbol"), style = "height: 40px; z-index: 1;"),
        column(12, h3("Leaderboard"), style = "height: 20px;"),
        column(12, DT::dataTableOutput("mastersLeaderboard")),
        column(12, 
               HTML("<div style='text-align: center; color: #046d53;'>
               <h>View player statistics by selecting a row in the leaderboard.</h6><br><br><br><br><br>
                    </div>")),
        conditionalPanel(
          "input.mastersLeaderboard_rows_selected > 0",
          column(12, h3(textOutput("selectedPlayerText")), style = "text-align: center; font-size: 100px; font-weight: bold; color: #046d53; margin-bottom: 50px;"),
          column(4, offset = 1, imageOutput("selectedPlayerImage")),
          column(5, offset = 1, plotOutput("sgRadar")),
          column(12, plotOutput("sgBoxplot"), style = "margin-top: 50px; margin-bottom: 100px")
        )
      )
    }),
    tabPanel("About", icon = icon("info-circle"), {
      fluidRow(
        column(12, 
               HTML("<div style='text-align: center; color: #046d53;'>
          <h2>Welcome to the 2022 Masters Dashboard!</h2>
        </div>")
        ),
        column(12, 
               HTML("<div style='text-align: center;'>
          <h4>This is an interactive dashboard attempting to better visualize PGA Tour Data using 2021 Masters Data. This Dashboard 
          investgates strokes gained statstics to provide insight on what makes a Masters champion while also investigating common player traits & trends.
          Below is information to help get you started.</h4>
        </div>")
        ),
        column(12, 
               HTML("<div style='text-align: center; color: #046d53;'>
          <h3>How to use the Dashboard?</h3>
        </div>")
        ),
        column(12, 
               HTML("<ul style=font-weight: normal;>
                 <li><h4>Scroll through the leaderboard to see results round by round, final scores, and total payouts.</h4></li>
                 <li><h4>Click on a player you want to see specific results for.</h4></li>
                 <li><h4>Player visualizations are for strokes gained statistics which in the first plot are averaged for the whole tournament, and for the boxplot chart, are differentiated by round.</h4></li>
                 <li><h4>The faceted boxplot chart contains boxplots that show field statistics for the corresponding round and have the selected players' strokes gained overlayed on top as a red dot.</h4></li>
                 <li><h4>Strokes gained is a statistical measure in golf that compares a player's performance on a specific shot or series of shots to the average performance of other golfers. It helps 
                 quantify how well a player is doing relative to the field.</h4></li>
                 <br>
             </ul>")
        ),
        column(12, 
               HTML("<div style='text-align: center; color: #046d53;'>
          <h3>What are some things to look for?</h3>
        </div>")
        ),
        column(12, 
               HTML("<ul>
                 <br>
                 <li><h4>The tournament ended with Hideki Matsuyama barely edging out Will Zalatoris for the win. What do they have in common that made them competitive above the field? What day
                 did Hideki break away from the field and how did he do it?</h4></li>
                 <br>")
        ),
        column(12, 
               HTML("<div style='text-align: center; color: #046d53;'>
          <h4>Common player traits among players become evident</h3>
        </div>")
        ),
        column(12, 
               HTML("<ul>
                 <li><h4>Will Zalatoris proved himself as an elite ball-striker, we can see this in his well rounded game in all strokes gained categories.</h4></li>
                 <li><h4>Scottie Scheffeler has been struggling to putt well for a long time now.</h4></li>
                 <li><h4>For the 2021 Masters, Bryson Dechambeau focused specifically on driving the golf ball well... he did, but maybe should have cared about other parts of his game.</h4></li>
                 <br>
                 <br>
                 <br>")
        ),
        column(12, h4("Author")),
        column(12, 
               HTML("<p>Alex Weirth</p><br>")
               ),
        column(12, HTML("<h4>Data Citations</h4>")),
        column(12, 
               HTML("<p>Data acquired from <a href='https://www.datagolf.com/' target='_blank'>Data Golf's Free PGA Archive</a></p>")
        ),
        column(4, imageOutput("datagolf"), style = "margin-bottom: 50px; height: 20px;")
      )
    })
  )
)

################################################################################

##################
# SERVER FUNCTIONS
##################

server <- function(input, output) {
  
  ##### EVENT LISTENER FOR MOUSE CLICK ON DT #####
  
  # Reactive object to store selected player name
  selectedPlayerName <- reactiveVal("")  # Default player name
  
  # Create a variable to keep track of the selected row
  selectedRow <- reactiveVal()
  
  # Create a reactive expression that tracks the number of selected rows
  selectedRowCount <- reactive({
    length(input$mastersLeaderboard_rows_selected)
  })
  
  # Updating the reactive value for a click on the data table
  observeEvent(input$mastersLeaderboard_rows_selected, {
    if (selectedRowCount() > 0) {
      # Store only the first selected row to ensure a single selection
      selectedRow(input$mastersLeaderboard_rows_selected[1])
    }
  })
  
  ##### OUTPUT FOR PLAYER TEXT (Title for Analysis) #####
  
  output$selectedPlayerText <- renderText({
    if (!is.null(selectedRow())) {
      selectedPlayerName(masters_lb[selectedRow(), "player"])
      paste(selectedPlayerName())
    }
  })
  
  ##### OUTPUT FOR DATA TABLE #####
  
  output$mastersLeaderboard = DT::renderDataTable({
    datatable(
      masters_lb,
      options = list(
        columnDefs = list(
          list(targets = c(0, 1, 8), orderable = FALSE),  # Remove ordering buttons from specific columns
          list(targets = 0, visible = FALSE)  # Hide the ID column at index 0
        ),
        scrollY = "400px",  # Enable vertical scrolling with a height of 400 pixels
        paging = FALSE,
        info = FALSE
      ),
      colnames = c("Position", "Player Name", "Round 1", "Round 2", "Round 3", "Round 4", "Score to Par", "Winnings"),
      selection = 'single',
      class = 'custom-data-table'
    )
  })
  
  ##### OUTPUT FOR MASTERS LOGO IMAGE #####
  output$mastersSymbol <- renderImage({
    list(
      src = "Masters-Symbol.png",
      class = "small-image"
    )
  }, deleteFile = FALSE)
  
  ##### OUTPUT FOR DATAGOLF #####
  output$datagolf <- renderImage({
    list(
      src = "datagolf.png",
      class = "small-image"
    )
  }, deleteFile = FALSE)
  
  
  ##### OUTPUT FOR SELECTED PLAYER IMAGE #####
  
  output$selectedPlayerImage <- renderImage({
    list(
      src = paste0("masters_headshots/", selectedPlayerName(), ".jpg"),
      alt = paste(selectedPlayerName())
    )
  }, deleteFile = FALSE)
  
  ##### OUTPUT FOR SELECTED PLAYER RADAR PLOT #####
  
  output$sgRadar <- renderPlot({
    
    player_name <- paste(selectedPlayerName())
    
    radarData <- masters2 %>%
      select(player, stat, strokes_gained) %>%
      filter(player == player_name) %>%
      group_by(player, stat)%>%
      summarize(sg = mean(strokes_gained))
    
    stat_order <- c("Off the Tee", "Tee to Green", "Approach", "Around the Green", "Putting")
    
    ggplot(data=radarData, aes(x = factor(stat, levels = stat_order), y = sg))+
      geom_col(aes(fill = sg < 0), color = "#003525", show.legend = FALSE)+
      scale_fill_manual(values = c("TRUE" = "#ffb3b3", "FALSE" = "#fef200"))+
      geom_text(aes(label = round(sg, 2), vjust = ifelse(sg < 0, 1.5, -0.5)), color = "#046d53", face = "bold", size = 4)+
      geom_hline(yintercept = 0, color = "#046d53", linetype = "solid", size = 1, alpha = 0.5)+
      theme_minimal()+
      ggtitle("Aggregate Tournament Strokes Gained Statistics")+
      labs(x = "", y = "Strokes Gained")+
      theme(
        plot.title = element_text(size = 15, color = "#046d53", face = "bold", hjust = 0.5, vjust = 2),
        axis.line.y = element_blank(),
        axis.line.x = element_blank(),
        axis.text.x = element_text(color = "#046d53", size = 14),
        axis.text.y = element_text(color = "#046d53", size = 14),
        axis.title.y = element_text(color = "#046d53", size = 14),
        panel.grid.major.x = element_blank()
      )
  })
  
  ##### OUTPUT FOR SELECTED PLAYER BOXPLOTS #####
  
  output$sgBoxplot <- renderPlot({
    
    #player_name <- paste(selectedPlayerName())
    player_name2<-paste(selectedPlayerName())
    
    # Create a data set for the selected player
    selected_player_data <- masters2 %>% filter(player == player_name2)
    
    # Forcing order to make legend line up with order of boxplots
    legend_order <- c("Off the Tee", "Tee to Green", "Approach", "Around the Green", "Putting")
    
    # Convert stat to a factor with desired levels
    masters2$stat <- factor(masters2$stat, levels = rev(legend_order))
    
    # Defining the laballer function for boxplot chart once here
    labeller <- function(variable, value) {
      stat_titles <- c(
        "1" = "Round 1",
        "2" = "Round 2",
        "3" = "Round 3",
        "4" = "Round 4"
      )
      return(stat_titles[value])
    }
    
    p <- ggplot() +
      geom_boxplot(data = masters2, aes(fill = stat, x = strokes_gained, y = stat), alpha = 0.5)+
      geom_point(data = selected_player_data, aes(x = strokes_gained, y = stat), color = "red", size = 3.5, show.legend = FALSE)+
      geom_vline(xintercept = 0, color = "#046d53", linetype = "solid", alpha = 0.8)+
      facet_wrap(. ~ round_num, labeller = labeller)+
      scale_fill_discrete(limits = legend_order)+
      scale_x_continuous(breaks = seq(-7, 7, by = 1), minor_breaks = seq(-6.5, 6.5, by = 1), limits = c(-6, 6))+
      ggtitle(paste(selectedPlayerName(), "Strokes Gained Statistics by Round vs. Field Averages\n"))+
      labs(subtitle = "Selected Player Data Annotated by Red Points", x = "Strokes Gained", fill = "Strokes Gained Type")+
      theme(
        axis.title.y = element_blank(),
        plot.title = element_text(size = 18, hjust = 0.5, face = "bold", color = "#005e2c"),
        plot.subtitle = element_text(size = 14, hjust = 0.5, color = "#005e2c"),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size = 14, color = "#005e2c"),
        axis.title.x = element_text(size = 16, color = "#005e2c"),
        strip.background = element_rect(fill = "#005e2c"),
        strip.text = element_text(size = 18, face = "bold", color = "white"),
        panel.grid.major.y = element_blank(),
        panel.background = element_rect(fill = "#e6efea"),
        legend.position = "top",
        legend.background = element_rect(fill = "#e6efea"),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14)
      )
    
    print(p)
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)