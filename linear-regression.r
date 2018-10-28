require(data.table)
Happiness_Data=data.table(read.csv('2016.csv'))
colnames(Happiness_Data)<-gsub('.','',colnames(Happiness_Data),fixed=T)

###Data exploration

require(ggplot2)
require(GGally)
ggplot(dataPlot,aes(y=value,x=variable))+geom_violin()
ggpairs(Happiness_Data[,c(4,7:13),with=F],lower = list(continuous='smooth'))

require('rworldmap')
map.world <- map_data(map="world")
library(reshape2)
dataPlot<- melt(Happiness_Data,id.vars='Country', measure.vars=colnames(Happiness_Data)[c(4,7:13)])
#Add the data you want to map countries by to map.world
#In this example, I add lengths of country names plus some offset
dataPlot[Country=='United States',Country:='USA']
dataPlot[Country=='United Kingdoms',Country:='UK']

dataPlot[,value:=value/max(value),by=variable]
dataMap=data.table(merge(map.world,dataPlot,by.x='region',by.y='Country',all.x=T))
dataMap[is.na(variable),variable=unique(variable)]
dataMap=dataMap[order(order)]
gg <- ggplot()
gg <- gg + geom_map(data=dataMap, map=dataMap, aes(map_id=region,x=long,y=lat, fill=value))+facet_wrap(~variable,scale='free')
gg <- gg + scale_fill_gradient(low = "navy", high = "lightblue")
gg <- gg + coord_equal()
gg

##First model
model1<-lm(HappinessScore~EconomyGDPperCapita+Family+HealthLifeExpectancy+Freedom+TrustGovernmentCorruption,data=Happiness_Data)

##Quick summary
sum1=summary(model1)
sum1
##R²
sum1$r.squared*100
##Coefficients
sum1$coefficients
##p-value
df(sum1$fstatistic[1],sum1$fstatistic[2],sum1$fstatistic[3])
###Visualisation of residuals
ggplot(model1,aes(model1$residuals))+geom_histogram(bins=20,aes(y=..density..))+
  geom_density(color='blue')+
  geom_vline(xintercept = mean(model1$residuals),color='red')+
  stat_function(fun=dnorm,
                  color="red",size=1,
                  args=list(mean=mean(model1$residuals), 
                            sd=sd(model1$residuals)))
ggplot(model1,aes(model1$fitted.values,model1$residuals))+geom_point()+geom_hline(yintercept = 
    c(1.96*sd(model1$residuals),-1.96*sd(model1$residuals)),color='red')
##Fitted vs predicted
data.plot=data.frame('real'=Happiness_Data$HappinessScore,'fitted'=model1$fitted.values)
ggplot(data.plot,aes(x=real,y=fitted))+geom_point()+geom_smooth(method='lm')

##COnfidence interval
confint(model1,level = 0.95)
confint(model1,level = 0.99)
confint(model1,level = 0.90)
sum1$coefficients
##Standardized betas
std_betas=sum1$coefficients[-1,1]*data.table(model1$model)[,lapply(.SD,sd),.SDcols=2:6]/sd(model1$model$HappinessScore)
