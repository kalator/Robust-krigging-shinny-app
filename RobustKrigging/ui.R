#install.packages("shiny")
#install.packages("shinydashboard")

library(rstudioapi)

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
                  
                  menuItem('Variograms',
                           tabName = 'variograms',
                           menuSubItem('Used data',
                                       tabName = 'used_data'
                                       ),
                           
                           menuSubItem('Non robust variogram',
                                       tabName = 'theory_nonrobust'
                                       ),
                           
                           menuSubItem('Non robust example',
                                       tabName = 'kriging_non_robust'
                           ),
                           
                           menuSubItem('Robust variogram',
                                       tabName = 'theory_robust'
                                       ),
                           
                           menuSubItem('Robust example',
                                       tabName = 'kriging_robust'
                                       )
                           ),
                  menuItem('Kriging',
                           tabName = 'kriging',
                           
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
      tabItems(
        tabItem("Introduction", 
                h2("Introduction"),
                hr(),
                includeHTML("./texts/introduction.html")
                ),
        
        tabItem("geostatistics", 
                h2("Geostatistics"),
                hr(),
                includeHTML("./texts/geostatistics.html")
                ),

        tabItem("theory_nonrobust",
                h2("Non robust variogram"),
                hr(),
                includeHTML("./texts/nonrobust.html")
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
                      
                  )
                ),
                
                box(width = 7,
                    plotOutput("robustvariogram"))
                
                
                
                
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