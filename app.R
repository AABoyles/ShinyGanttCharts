library(tidyverse)
library(readxl)
library(shiny)
library(lubridate)
library(scales)
library(rhandsontable)

# Custom theme for making a clean Gantt chart
theme_gantt <- function(base_size=11, base_family="Source Sans Pro Light") {
  theme_bw(base_size, base_family) %+replace%
    theme(panel.background = element_rect(fill="#ffffff", colour=NA),
          axis.title.x=element_text(vjust=-0.2), axis.title.y=element_text(vjust=1.5),
          title=element_text(vjust=1.2, family="Source Sans Pro Semibold"),
          panel.border = element_blank(), axis.line=element_blank(),
          panel.grid.minor = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(size=0.5, colour="grey80"),
          axis.ticks = element_blank(),
          legend.position = "bottom", 
          axis.title = element_text(size=rel(0.8), family="Source Sans Pro Semibold"),
          strip.text = element_text(size=rel(1), family="Source Sans Pro Semibold"),
          strip.background = element_rect(fill="#ffffff", colour=NA),
          panel.spacing.y = unit(1.5, "lines"),
          legend.key = element_blank())
}

ui <- navbarPage("Shiny Gantt Chart",
  tabPanel("App",
    column(3,
      wellPanel(
        fileInput("file1", "Choose Project Schedule Spreadsheet (CSV/XLSX)", multiple = FALSE,
          accept = c(
            "text/csv","text/comma-separated-values","text/plain",".csv",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",".xlsx",
            "application/vnd.ms-excel",".xls"
          )
        ) #,
        # selectInput('start', 'Start', c()),
        # selectInput('end', 'End', c()),
        # selectInput('project', 'Project', c()),
        # selectInput('task', 'Task', c())
      )
    ),
    column(9,
      tabsetPanel(
        tabPanel("Table",
          downloadButton('downloadData', 'Download'),
          rHandsontableOutput("hot"),
          actionButton('addRow', 'Add a Row')
        ),
        tabPanel("Gantt",
          downloadButton('downloadPlot', 'Download'),
          plotOutput("gantt")
        )
      )
    )
  ),
  tabPanel("About",
    column(6, offset = 3,
      wellPanel(includeMarkdown('README.md'))
    )
  )
)

server <- function(input, output, session){
  td <- today()
  tasks <- tibble(
    Start = c(td, td + 14, td),
    End = c(td + 1, td + 28, td + 90),
    Project = c("Management", "Management", "Operations"),
    Task = c("Planning", "Gantt Charting", "Make Coffee")
  )
    
  output$downloadData <- downloadHandler(
    filename = 'ShinyGanttExport.csv',
    content = function(file){
      input$hot %>%
        hot_to_r() %>%
        write_csv(file)
    }
  )
  
  output$hot <- renderRHandsontable({
    if(!is.null(input$file1)){
      if(input$file1$type %in% c("text/csv","text/comma-separated-values","text/plain",".csv")){
        tasks <- read_csv(input$file1$datapath)
      } else {
        tasks <- read_excel(input$file1$datapath)
      }
    }
    
    tasks %>%
      rhandsontable() %>%
      hot_table(highlightCol = TRUE, highlightRow = TRUE)
  })
  
  observeEvent(input$addRow, {
    tasks <- hot_to_r(input$hot)
    tasks[nrow(tasks)+1,] <- NA
    output$hot <- renderRHandsontable({
      tasks %>%
        rhandsontable() %>%
        hot_table(highlightCol = TRUE, highlightRow = TRUE)
    })
  })
  
  output$gantt <- renderPlot({
    req(input$hot)
    
    tasks <- hot_to_r(input$hot)
    
    tasks.long <- tasks %>%
      mutate(Start = ymd(Start), End = ymd(End)) %>%
      gather(date.type, task.date, -c(Project, Task)) %>%
      arrange(date.type, task.date) %>%
      mutate(Task = factor(Task, levels=rev(unique(Task)), ordered=TRUE))

    # Calculate where to put the dotted lines that show up every three entries
    x.breaks <- seq(length(tasks$Task) + 0.5 - 3, 0, by=-3)

    ggplot(tasks.long, aes(x=Task, y=task.date, colour=Project)) +
      geom_line(size=6) +
      geom_vline(xintercept=x.breaks, colour="grey80", linetype="dotted") +
      guides(colour=guide_legend(title=NULL)) +
      labs(x=NULL, y=NULL) + coord_flip() +
      scale_y_date(date_breaks="2 months", labels=date_format("%b ‘%y")) +
      theme_gantt() + theme(axis.text.x=element_text(angle=45, hjust=1))
  })
  
  output$downloadPlot <- downloadHandler(
    filename = "ShinyGanttExport.png",
    content = function(file){
      ggsave(file, width = 7.5, height = 5, units = 'in')
    }
  )
}

shinyApp(ui = ui, server = server)
