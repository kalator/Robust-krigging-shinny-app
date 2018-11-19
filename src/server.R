#install.packages("geoR")
#install.packages("rstudioapi")
#install.packages("georob")

library(rstudioapi)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(geoR)
data(s100)

cloud1 <- variog(s100, option = "cloud", max.dist=1)
cloud2 <- variog(s100, option = "cloud", estimator.type = "modulus", max.dist=1)
bin2  <- variog(s100, uvec=seq(0,1,l=11), estimator.type= "modulus")

library(georob)
data(meuse, package="sp")
r.lm <- lm(log(zinc)~sqrt(dist)+ffreq, meuse)
r.sv <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                         lag.dist.def=100, max.lag=2000,
                         estimator="matheron")
#plot(r.sv)




shinyServer
(
  function(input,output,session)
    {
    
    bin1 <- variog(s100, uvec=seq(0,1,l=11))
    
    output$nugetSlider <- renderUI({
      sliderInput("nugget","Nugget",min = 0,max = round(min(bin1$v),2),value = 0)
    })
    
    output$binSlider <- renderUI({
      sliderInput("bins","Bins",min = 0,max = 100,value = 11)
    })
    
    output$sillSlider <- renderUI({
      sliderInput("sill","Sill",min = 0,max = 2*round(max(bin1$v),2),value = 1)
    })
    
    output$rangeSlider <- renderUI({
      sliderInput("range","Range",min = 0,max = 1,value = 0.3)
    })
    
    
      output$variogram <- renderPlot({
        nuget <- 0
        choosen <-switch(input$vario_type,
                         'Spherical' = "sph",
                         'Exponential' = "exp",
                         'Gaussian' = "gaussian",
                         'Cubic' = 'cubic'
                       )
        #fixedNuget <-switch(input$fixnuget,
        #                    TRUE,
        #                    FALSE)
        nuget <- input$nugget
        bins <- input$bins
        sill <- input$sill
        range <- input$range
        
        bin1 <- variog(s100, uvec=seq(0,1,l=bins))
        plot(bin1)
        lines.variomodel(cov.model = choosen, cov.pars = c(sill, range), nugget = nuget, max.dist = 1,  lwd = 3)
      
      }      )
      
      
      output$robust_variogram <- renderPlot({
        nuget <- 0
        choosen <- switch(input$variogram.model,
                          'Spherical' = "RMspheric",
                          'Exponential' = "RMexp",
                          'Gaussian' = "RMgauss",
                          'Cubic' = "RMcubic")
        
        plot(r.sv)
        
        
        lines(r.sv.spher <- fit.variogram.model(r.sv, variogram.mode=choosen,
                                                param=c(variance=0.1, nugget=0.05, scale=1000)))
        
        
      })
    
    
  }
 
) 