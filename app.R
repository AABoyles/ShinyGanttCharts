library(tidyverse)
library(shiny)
library(lubridate)
library(scales)

# Custom theme for making a clean Gantt chart
theme_gantt <- function(base_size=11, base_family="Source Sans Pro Light") {
  theme_bw(base_size, base_family) %+replace%
    theme(panel.background = element_rect(fill="#ffffff", colour=NA),
          axis.title.x=element_text(vjust=-0.2), axis.title.y=element_text(vjust=1.5),
          title=element_text(vjust=1.2, family="Source Sans Pro Semibold"),
          panel.border = element_blank(), axis.line=element_blank(),
          panel.grid.minor=element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(size=0.5, colour="grey80"),
          axis.ticks=element_blank(),
          legend.position="bottom", 
          axis.title=element_text(size=rel(0.8), family="Source Sans Pro Semibold"),
          strip.text=element_text(size=rel(1), family="Source Sans Pro Semibold"),
          strip.background=element_rect(fill="#ffffff", colour=NA),
          panel.spacing.y=unit(1.5, "lines"),
          legend.key = element_blank())
}

ui <- fluidPage(
  verticalLayout(
    titlePanel("Gantt Chart-er"),
    fileInput("file1", "Choose CSV File", multiple = FALSE,
      accept = c("text/csv","text/comma-separated-values,text/plain",".csv")
    ),
    plotOutput("gantt")
  )
)

server <- function(input, output){
  output$gantt <- renderPlot({
    req(input$file1)
    
    tasks <- read_csv(input$file1$datapath)

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
}

shinyApp(ui = ui, server = server)
