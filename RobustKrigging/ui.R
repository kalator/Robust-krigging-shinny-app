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
                           
                           menuSubItem('Non robust example',
                                       tabName = 'kriging_non_robust'
                           ),
                           
                           menuSubItem('Robust variogram',
                                       tabName = 'theory_robust'
                                       ),
                           
                           menuSubItem('Robust example',
                                       tabName = 'kriging_robust'
                                       ),
                           menuSubItem('Used data',
                                       tabName = 'used_data'
                           )
                           ),
                  menuItem('Examples',
                           menuSubItem('Kriging in general',
                                       tabName = 'kriging_general'),
                           
                           menuSubItem('Non robust kriging',
                                       tabName = 'nonrobust_kriging'),
                           
                           menuSubItem('Robust kriging',
                                       tabName = 'robust_kriging')
                           
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
        
        tabItem("theory_robust",
                h2("Robust variogram"),
                hr(),
                includeHTML("./texts/robust.html")
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
        )
        
        
               )
      
                   )
           )
  
      )