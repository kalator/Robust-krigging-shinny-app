#install.packages("geoR")
#install.packages("rstudioapi")

library(rstudioapi)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(geoR)
data(s100)

cloud1 <- variog(s100, option = "cloud", max.dist=1)
cloud2 <- variog(s100, option = "cloud", estimator.type = "modulus", max.dist=1)
bin1 <- variog(s100, uvec=seq(0,1,l=11))
bin2  <- variog(s100, uvec=seq(0,1,l=11), estimator.type= "modulus")




shinyServer
(
  function(input,output,session)
    {
      output$variogram <- renderPlot({
        choosen <-switch(input$vario_type,
                         'Spherical' = "sph",
                         'Exponential' = "exp",
                         'Gaussian' = "gaussian",
                         'Cubic' = 'cubic'
                       )
        
        plot(bin1)
        lines.variomodel(cov.model = choosen, cov.pars = c(1,0.3), nugget = 0, max.dist = 1,  lwd = 3)
      
      }      )  
    
    
  }
 
) 