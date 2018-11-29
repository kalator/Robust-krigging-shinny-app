plot(r.sv)
lines((mr.sv.spher <- fit.variogram.model(r.sv, variogram.mode="RMspheric",
                                        param=c(variance=0.1, nugget=0.05, scale=1000))), 
      lwd=2, col="purple")
lines((lmr.sv.spher <- fit.variogram.model(r.sv, variogram.mode="RMexp",
                                          param=c(variance=0.1, nugget=0.05, scale=1000))),
      lwd=2, col="blue")

lines((lmr.sv.spher <- fit.variogram.model(r.sv, variogram.mode="RMgauss",
                                           param=c(variance=0.1, nugget=0.05, scale=1000))),
      lwd=2, col="green")

  
legend("topleft", legend=c("Spherical", "Exponential", "Gaussian"),
       col=c("purple", "blue", "green"), lty=1:2, cex=0.8)                                     




# ----------------------- variogramy dohromady ---------------------------------

plot(r.sv1)

r.sv1 <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                         lag.dist.def=100, max.lag=2000,
                         estimator="ch")

r.sv2 <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                          lag.dist.def=100, max.lag=2000,
                          estimator="matheron")

r.sv.spher1 <- fit.variogram.model(r.sv1, variogram.mode="RMspheric",
             param=c(variance=0.1, nugget=0.05, scale=1000))

lines(r.sv.spher1,   lwd = 10, col='purple')

r.sv.spher2 <- fit.variogram.model(r.sv2, variogram.mode="RMspheric",
                                   param=c(variance=0.1, nugget=0.05, scale=1000))

lines(r.sv.spher2,   lwd = 10, col='green')

legend("topleft", legend=c("Robust", "Non-robust"),
       col=c("purple", "green"), lty=1:2, cex=0.8)   


# ohodnotila bych to blby data - lisi se ale minimalne... ta nerobustni metoda se vyuziva
# u toho estimator