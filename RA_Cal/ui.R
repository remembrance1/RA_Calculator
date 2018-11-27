library(shiny)
library(flexdashboard)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("flatly"),
                  headerPanel("Breast Cancer Risk Assessment"),
                  fluidRow(
                    sidebarPanel(
                      fluidRow(column(10, h2('Questionaire')),
                               column(2, tags$br(), 
                                      imageOutput("image", height = 25, width = 25,
                                                  click = clickOpts(id = "image_click")),
                                      tags$br(), tags$br())),
                      
                      numericInput('age',"What is the patient's age? (Between ages 35 and 85).", 35, min=35, max=85, step = 1),
                      
                      selectInput('menstruation',"What was the woman’s age at the time of her first menstrual period?",
                                  choices = list("< 12 years old" = 11,
                                                 "12 to 13 years old" = 12,
                                                 "> 13 years old" = 14,
                                                 "Not Sure" = 99), selected = 12),
                      
                      selectInput('first_birth',"What was the woman’s age when she gave birth to her first child? ?",
                                  choices = list("No births" = 98,
                                                 "< 20 years old"= 19,
                                                 "20 to 24 years old" = 20,
                                                 "25 to 29 years old" = 25,
                                                 "> 30 years old"= 30,
                                                 "Not Sure" = 99), selected = 98),
                      
                      selectInput('relatives',"How many of the woman’s first-degree relatives (mother, sisters, daughters) have had breast cancer?",
                                  choices = list("Not Sure" = 99,
                                                 "0 Relatives" = 0,
                                                 "1 Relatives" = 1,
                                                 "2 or more" = 2), selected = 0),
                      
                      selectInput('biopsies', "How many breast biopsies (positive or negative) has the woman had?",
                                  choices = list("Not Sure" = 99,
                                                 "No Biopsies" = 0,
                                                 "1 Biopsy" = 1,
                                                 "2 or more" = 2), selected = 99),
                      
                      conditionalPanel(
                        condition = "input.biopsies == 1 || input.biopsies == 2",
                        selectInput("hyperplasia", "Did the biopsy display hyperplasia?",
                                    choices = list("No" = 0,
                                                   "Yes" = 1,
                                                   "Unknown" = 99), selected = 99)),
                      
                      selectInput('race',"Race/Ethnicity?",
                                  choices = list("White" = 1,
                                                 "African-American" = 2,
                                                 "Hispanic-American" = 3,
                                                 "Other (Native American and unknown race)" = 4,
                                                 "Chinese" = 6,
                                                 "Japanese" = 7,
                                                 "Filipino" = 8,
                                                 "Hawaiian" = 9,
                                                 "Other Pacific Islander" = 10,
                                                 "Other Asian" = 11), selected = 6),
                      
                      actionButton("do","Calculate Risk", class = "btn-primary")
                      
                    ),
                    
                    mainPanel(
                      h3('Your Results'),
                      tags$hr(),
                      span(textOutput("five_yr_title"), style="font-size: 20px"),
                      textOutput("five_yr_text"),
                      tags$br(),
                      span(textOutput("lifetime_title"), style="font-size: 20px"),
                      textOutput("lifetime_text"),
                      tags$hr(),
                      fluidRow(
                        column(7
                               , fluidRow(
                                 column(12, span(textOutput("advice_title"), style="font-size: 20px"),
                                        tags$hr(width = "50%", align = "left"))
                               )
                               , fluidRow(
                                 column(12, textOutput("advice_text1"), tags$br(),
                                        textOutput("advice_text2"))
                               )
                        )
                        , column(5, tags$br(), htmlOutput("short_five"), htmlOutput("short_life"), tags$br(), gaugeOutput("plt1"))
                      )
                    )),
                  
                  fluidRow(
                    tags$hr(),
                    tags$div(class = "footer",("© 2018 - "), style = "bottom:0",
                             tags$a(
                               href="https://www.linkedin.com/in/javierngkh",
                               target="_blank",
                               "Ng Kok How Javier"),
                             align = "center")
                    
                  )
                  
)

)