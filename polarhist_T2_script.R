
# Polar histogram


library(likert)
library(reshape)
library(reshape2)
library(phenotypicForest)

consensusT2<-likert(delphi.Term2.combine[,1:21])

consensusT2$results$Item<-1:21
consensusT2$results$Group<-rep("Item",21) 

consensusnewT2<-melt(consensusT2$results,c("Group","Item"),variable_name="score") # from wide to long  
names(consensusnewT2)<-c("item","family","score","value")
consensusnewT2<-consensusnewT2[,c(2,1,3,4)]  
polhistT2<-polarHistogram(consensusnewT2,familyLabel=TRUE)

windows()
print(polhistT2 + scale_fill_brewer(name="Response", palette="RdYlBu") + theme(legend.position="top")) 

##########################################################################################

#stacked barchart by discpline and country

stacked.dat.T2<-read.xlsx("H:/DVMB/CATALISE/Terminology2/test data/crosstabsTerm2.xlsx",sheetName="Sheet1")


library(plyr)
stacked.dat.T2<-stacked.dat.T2[-c(61:66)]
stacked.dat.T2 <- ddply(stacked.dat.T2, .(Discipline), transform, pos = cumsum(Count) - (0.5 * Count))
stacked.dat.T2<-stacked.dat.T2[-c(61:66)]
# plot bars and add text
library(car)
write.xlsx(stacked.dat.T2,"H:/DVMB/CATALISE/Terminology2/test data/crosstabsTerm2.xlsx",sheetName="Sheet2",append=T)
#
stacked.dat.T2<-read.xlsx("H:/DVMB/CATALISE/Terminology2/test data/crosstabsTerm2.xlsx",sheetName="Sheet2")
stacked.dat.T2<-stacked.dat.T2[-c(61:66)]
windows()
ggplot(data=stacked.dat.T2, aes(x=Discipline, y=Count, fill=Country)) +
  geom_bar(stat="identity")+ theme_minimal()+ theme(axis.text.x = element_text(angle = 90, hjust = 1)) + geom_text(aes(label = Count, y = pos), size = 3) +
  coord_flip()

