library(shiny)

shinyUI(fluidPage(
  headerPanel(title = h2('Univariable EDA', align="center")),
  sidebarLayout(
    sidebarPanel(
      selectInput("var", "1. Select the Variable from the Iris Dataset", choices=c("Attrition_Flag"=1, 
                                                                                   "Customer_Age"=2, 
                                                                                   "Gender"=3,
                                                                                   Education_Level=4,
                                                                                   Marital_Status=5,
                                                                                   Credit_Limit=6,
                                                                                   Total_Revolving_Bal=7,
                                                                                   Avg_Open_To_Buy=8)),
      br(),
      sliderInput("bins", "2. Select the number of BINs for Histogram", min=5, max=200, value=50),
      br(),
      radioButtons("color", "3. Select the color of Histogram", choices=c("Green", "Red", "Yellow", selected="Green")),
      ),
    
    mainPanel(
      plotOutput("myhist")
      
    )
    )
  
  
))