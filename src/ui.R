#install.packages("shiny")
# install.packages("shinydashboard")

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd("../texts")

library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Kriging", 
                    titleWidth = 200
                    ),
    
    dashboardSidebar(width = 200,
      sidebarMenu(id = 'sidebarmenu',
                  menuItem('Introduction', 
                           tabName = "Introduction"
                          ),
                  
                  menuItem('Geostatistics',
                           tabName = 'geostatistics'
                           ),
                  
                  menuItem('Kriging',
                           tabName = 'kriging',
                           menuSubItem('Kriging in general',
                                       tabName = 'kriging_in_general'
                                       ),
                           
                           menuSubItem('Non robust kriging',
                                       tabName = 'kriging_non_robust'
                                       ),
                           
                           menuSubItem('Robust kriging',
                                       tabName = 'kriging_robust'
                                       )
                           )
                  
                  )
                    ),
    dashboardBody(
      tabItems(
        tabItem("Introduction", 
                h2("Introduction"),
                hr(),
                includeHTML("introduction.html")
                ),
        
        tabItem("geostatistics", 
                h2("Geostatistics"),
                hr(),
                includeHTML("geostatistics.html")
                ),

        tabItem("kriging_in_general",
                h2("Kriging in general"),
                hr(),
                includeHTML("general_kriging.html")
                ),
        
        tabItem("kriging_non_robust", 
                h2("Non robust kriging"),
                "blahblahblah",
                fluidRow(
                box(width = 4, 
                    selectInput('vario_type', 
                                label = 'Choose theoretical variogram:', 
                                choices = c('Spherical',
                                            'Exponential',
                                            'Gaussian',
                                            'Cubic')
                                          ),
                    hr(),
                    uiOutput("binSlider"),
                    hr(),
                    uiOutput("nugetSlider"),
                    hr(),
                    #checkboxInput('fixnuget', 
                    #              label = 'Fixed nugget', 
                    #              value = FALSE),
                    #hr(),
                    uiOutput("sillSlider"),
                    hr(),
                    uiOutput("rangeSlider")
                    
                    
                   ),
                box(width = 7, 
                    plotOutput("variogram")
                   )
                        )
                ),
        
        tabItem("kriging_robust", 
                h2("Robust kriging")
                )
        
               )
      
                   )
           )
  
      )