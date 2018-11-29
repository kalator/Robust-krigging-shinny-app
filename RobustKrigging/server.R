#install.packages("geoR")
#install.packages("rstudioapi")
#install.packages("georob")
#install.packages('rsconnect')

#
#library(rsconnect)
library(rstudioapi)
library(shiny)
library(shinydashboard)

library(geoR)
library(georob)

data(s100)

library(georob)
data(meuse, package="sp")
r.lm <- lm(log(zinc)~sqrt(dist)+ffreq, meuse)
r.sv <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                         lag.dist.def=100, max.lag=2000,
                         estimator="ch")
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
        nuget <- input$nugget
        bins <- input$bins
        sill <- input$sill
        range <- input$range
        
        bin1 <- variog(s100, uvec=seq(0,1,l=bins))
        plot(bin1, col = 'red')
        if(input$def_vario){
          ols.n <- variofit(bin1, ini = c(1,0.5), nugget=0.5, weights="equal")
          lines(ols.n, lty = 2, max.dist = 1)
        }
        vv <- variofit(cov.model = choosen, cov.pars = c(sill, range), nugget = nuget, max.dist = 1)
        lines(vv,   lwd = 3, col='purple')
      }      )
    

    
    
      
      
      
      output$nugetSlider2 <- renderUI({
        sliderInput("nugget2","Nugget",min = 0,max = round(min(r.sv$gamma),2),value = 0.05)
      })
      

      output$sillSlider2 <- renderUI({
        sliderInput("sill2","Sill",min = 0,max = 2*round(max(r.sv$gamma),2),value = 0.1)
      })
      
      output$rangeSlider2 <- renderUI({
        sliderInput("range2","Range",min = 1,max = 2000,value = 1000)
      })
      
      
      
      
      output$robustvariogram <- renderPlot({
        nuget2 <- 0.05
        sill2 <- 0.1
        range2 <- 1000
        
        choosen <- switch(input$variogram.model,
                          'Spherical' = "RMspheric",
                          'Exponential' = "RMexp",
                          'Gaussian' = "RMgauss",
                          'Cubic' = "RMcubic")
        

        nuget2 <- input$nugget2
        sill2 <- input$sill2
        range2 <- input$range2
        
        plot(r.sv)
        lines(r.sv.spher <- fit.variogram.model(r.sv, variogram.mode=choosen,
                                                param=c(variance=(sill2*sill2), nugget=(nuget2*nuget2), scale=range2)))
        
        
      })
        
      

    
  }
 
) 