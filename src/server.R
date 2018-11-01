#install.packages("geoR")
#install.packages("rstudioapi")

library(rstudioapi)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(geoR)
data(s100)

cloud1 <- variog(s100, option = "cloud", max.dist=1)
cloud2 <- variog(s100, option = "cloud", estimator.type = "modulus", max.dist=1)
bin2  <- variog(s100, uvec=seq(0,1,l=11), estimator.type= "modulus")




shinyServer
(
  function(input,output,session)
    {
    bin1 <- variog(s100, uvec=seq(0,1,l=11))
    
    output$nugetSlider <- renderUI({
      sliderInput("nugget","Nugget",min = 0,max = round(min(bin1$v),2),value = 0)
    })
    
      output$variogram <- renderPlot({
        nuget <- 0
        choosen <-switch(input$vario_type,
                         'Spherical' = "sph",
                         'Exponential' = "exp",
                         'Gaussian' = "gaussian",
                         'Cubic' = 'cubic'
                       )
        nuget <- input$nugget
        plot(bin1)
        lines.variomodel(cov.model = choosen, cov.pars = c(1,0.3), nugget = nuget, max.dist = 1,  lwd = 3)
      
      }      )  
    
    
  }
 
) 