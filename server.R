library(shiny)
library(RMySQL)
library(dplyr)
library(ggplot2)

shinyServer(
  
  function(input, output){
    endpoint <- 'db-instance-1.cyhrwzei8zkv.ap-south-1.rds.amazonaws.com'
    username <-'admin'
    password <- '12345678'
    database <- 'jobs_applicants'
    con <- dbConnect(MySQL(), user = username, password = password, dbname = database, host = endpoint)
    result <- dbGetQuery(con, "SELECT * FROM bankChurn")
    
    output$myhist <- renderPlot({
      colm <- as.numeric(input$var)
      if (class(result[,colm]) == "integer"){
        hist(result[,colm], breaks=seq(0, max(result[,colm]), l=input$bins+1), main="Histogram of Dataset Column", col=input$color, xlab=names(result[colm]))
      }
      else if (class(result[,colm]) == "character"){
        name <- names(result[colm])
        dist_counts <- result %>% group_by(!!sym(name)) %>% summarize(count = n())
        Y <- c(dist_counts$count)
        X <- as.character(distinct(result, !!sym(name))[,name])
        xy_df <- data.frame('X'=X, 'Y'=Y)
        ggplot(xy_df, aes(x = X, y = Y, fill=X)) +
          geom_bar(stat = "identity")
      }
    })
    
  }
  
  
)