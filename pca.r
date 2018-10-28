#Data set Business Industry categories and their Progress 
#The database is attached to the R search path. This means that #the database is searched by R when evaluating a variable, so #objects in the database can be accessed by simply giving their #names. 
mydata<-read.csv("C:/Users/Oni/Desktop/mla/pca_gsp.csv") 
attach(mydata)

# list the variables in mydata 
names(mydata) 
X <- cbind(Ag, Mining, Constr, Manuf, Manuf_nd, Transp, Comm, Energy, TradeW, TradeR, RE, Services, Govt) 

# mean,median,25th and 75th quartiles, min, max 
summary(X) 

# You can use the cor( ) function to produce correlations 
cor(X) 

# princomp performs a principal components analysis on the given numeric data matrix and #returns the results as an object of class princomp. 
pcal<-princomp(X, scores=TRUE, cor=TRUE) 

#Summary. A very useful multipurpose function in R issummary(X), where X can be one of #any number of objects, including datasets, variables, and linear models, just to name a few. #When used, the command provides summary data related to the individual object that was fed #into it 
summary(pcal) 

# Extract or print loadings in factor analysis 
loadings(pcal) 

#Visualize the Principal Components 
plot(pcal) 
screeplot(pcal,type="line",main="Screen Plot") 
biplot(pcal) 
pcal$scores[1:10,] 