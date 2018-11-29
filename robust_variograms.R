r.lm <- lm(log(zinc)~sqrt(dist)+ffreq, meuse)
r.sv <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                        lag.dist.def=100, max.lag=2000,
                        estimator="ch")


mr.sv.spher <- fit.variogram.model(r.sv, 
                                   variogram.mode="RMspheric",
                                   param=c(variance=0.1, nugget=0.05, scale=1000)
)
mr.sv.exp <- fit.variogram.model(r.sv, variogram.mode="RMexp",
                                 param=c(variance=0.1, nugget=0.05, scale=1000)
)
mr.sv.gauss <- fit.variogram.model(r.sv, 
                                   variogram.mode="RMgauss",
                                   param=c(variance=0.1, nugget=0.05, scale=1000)
)

plot(r.sv)
lines(mr.sv.spher, lwd=3, col="purple")
lines(mr.sv.exp,lwd=3, col="blue")
lines(mr.sv.gauss, lwd=3, col="green")


legend("topleft", legend=c("Spherical", "Exponential", "Gaussian"),
       col=c("purple", "blue", "green"), lty=c(1,1,1), cex=0.8, lwd=c(2,2,2))                             




# ----------------------- variogramy dohromady ---------------------------------
r.sv1 <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                          lag.dist.def=100, max.lag=2000,
                          estimator="ch")

r.sv2 <- sample.variogram(residuals(r.lm), locations=meuse[, c("x","y")],
                          lag.dist.def=100, max.lag=2000,
                          estimator="matheron")

r.sv.spher1 <- fit.variogram.model(r.sv1, variogram.mode="RMspheric",
                                   param=c(variance=0.1, nugget=0.05, scale=1000))
plot(r.sv1)




lines(r.sv.spher1,   lwd = 10, col='purple')

r.sv.spher2 <- fit.variogram.model(r.sv2, variogram.mode="RMspheric",
                                   param=c(variance=0.1, nugget=0.05, scale=1000))

lines(r.sv.spher2,   lwd = 10, col='green')

legend("topleft", legend=c("Robust", "Non-robust"),
       col=c("purple", "green"), lty=1:1, cex=0.8)   


# ohodnotila bych to blby data - lisi se ale minimalne... ta nerobustni metoda se vyuziva
# u toho estimator