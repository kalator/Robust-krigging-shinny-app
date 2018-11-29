#install.packages("shiny")
#install.packages("shinydashboard")

library(rstudioapi)

library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(
    skin = "green",
    dashboardHeader(title = "Learn kriging 0.1", 
                    titleWidth = 200
    ),
    
    dashboardSidebar(width = 200,
                     sidebarMenu(id = 'sidebarmenu',
                                 menuItem('Introduction', 
                                          tabName = "Introduction"
                                 ),
                                 menuItem('Theory of kriging',
                                          menuSubItem('Variogram',
                                                      tabName = 'theory_variograms'
                                          ),
                                          menuSubItem('Kriging',
                                                      tabName = 'theory_kriging'
                                          ),
                                          menuSubItem('Robust variogram',
                                                      tabName = 'theory_rob_variograms'
                                          ),
                                          menuSubItem('Robust kriging',
                                                      tabName = 'theory_rob_kriging'
                                          )
                                 ),
                                 menuItem('Examples',
                                          
                                          menuSubItem('Non robust example',
                                                      tabName = 'kriging_non_robust'
                                          ),
                                          
                                          menuSubItem('Robust example',
                                                      tabName = 'kriging_robust'
                                          ),
                                          menuSubItem('Used data',
                                                      tabName = 'used_data'
                                          ),
                                          menuSubItem('Robust kriging',
                                                      tabName = 'rob_kriging')
                                 )
                                 
                     )
    ),
    dashboardBody(
      withMathJax(),
      tabItems(
        tabItem("Introduction", 
                includeHTML("./texts/introduction.html")
        ),
        
        tabItem("theory_variograms",
                includeHTML("./texts/theory_variograms.html")
        ),
        tabItem("theory_kriging",
                includeHTML("./texts/theory_kriging.html")
        ),
        tabItem("theory_rob_variograms",
                includeHTML("./texts/theory_rob_variograms.html")
        ),
        tabItem("theory_rob_kriging",
                includeHTML("./texts/theory_rob_kriging.html")
        ),
        tabItem("used_data",
                h2("Used data"),
                hr(),
                includeHTML("./texts/introduction_data.html")
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
                h2("Robust kriging"),
                
                fluidRow(
                  box(width = 4, 
                      selectInput('variogram.model', 
                                  label = 'Choose theoretical variogram:', 
                                  choices = c('Spherical',
                                              'Exponential',
                                              'Gaussian',
                                              'Cubic')
                      ),
                      
                      hr(),
                      uiOutput("nugetSlider2"),
                      hr(),
                      uiOutput("sillSlider2"),
                      hr(),
                      uiOutput("rangeSlider2")
                      
                  ),
                  
                  
                  box(width = 7,
                      plotOutput("robustvariogram"))
                )
                
                
                
                
        ),
        
        tabItem("kriging_general",
                h2("Kriging in general"),
                hr(),
                includeHTML("./texts/general_kriging.html")
        ),
        
        tabItem("nonrobust_kriging",
                h2("Non robust kriging"),
                hr(),
                includeHTML("./texts/nonrobust_kriging.html")
        ),
        
        tabItem("robust_kriging",
                h2("Robust kriging"),
                hr(),
                includeHTML("./texts/robust_kriging.html")
        ),
        
        tabItem("rob_kriging",
                h2("Robust kriging"),
                hr(),
                
                fluidRow(
                  box(width = 5,
                  plotOutput("rob_kriging")),
                  
                  box(width = 5,
                    includeHTML("./texts/meuse.html")
                  )
                  
                  
                )
                
                
        )
        
        
      )
      
    )
  )
  
)