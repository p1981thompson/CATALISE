#Load data from Qualtrics catalise two (terminology) #

#19-11-2015#


library(xlsx)
library(psych)
library(tools)

qualtrics.Terminology.data2<-read.xlsx("H:/DVMB/CATALISE/Terminology2/test data/CATALISE_terminology2.xlsx",sheetName="CATALISE_T")

Delphi.T2.members<-qualtrics.Terminology.data2$ExternalDataReference
Delphi.T2.members <- factor(Delphi.T2.members, levels=levels(droplevels(Delphi.T2.members)))

processInput_T2_Anon <- function(panel.member) { 
  temp <<- environment()
  require(tools)
  Sweave(paste(getwd(),'/Terminology2/reports/delphi_T2_template_anonymous.Rnw',sep=""), output = paste(getwd(),'/Terminology2/reports/Delphi_T2_report_anonymous.tex', sep = ''))
  texi2dvi(paste(getwd(),'/Terminology2/reports/Delphi_T2_report_anonymous.tex', sep = ''), pdf = TRUE, clean = TRUE,texinputs=paste(getwd(),'/Terminology2/reports/Delphi_T2_report_anonymous.tex', sep = ''), texi2dvi="pdflatex")
  file.copy(from=paste(getwd(),'/Delphi_T2_report_ANONYMOUS.pdf', sep = ''), to=paste(getwd(),'/Terminology2/reports final/Delphi_T2_report_ANONYMOUS.pdf', sep = ''),overwrite = TRUE)
}

processInput_T2 <- function(panel.member) { 
  temp <<- environment()
  Sweave(paste(getwd(),'/Terminology2/reports/delphi_T2_report_template.Rnw',sep=""), output = paste(getwd(),'/Terminology2/reports/Delphi_T2_report_', panel.member, '.tex', sep = ''))
  texi2dvi(paste(getwd(),'/Terminology2/reports/Delphi_T2_report_', panel.member, '.tex', sep = ''), pdf = TRUE, clean = TRUE,texinputs=paste(getwd(),'/Terminology2/reports/Delphi_T2_report_', panel.member, '.tex', sep = ''), texi2dvi="pdflatex")

}


for(panel.member in Delphi.T2.members){
  Sweave(paste(getwd(),'/Terminology2/reports/delphi_T2_report_template.Rnw',sep=""), output = paste(getwd(),'/Terminology2/reports/Delphi_T2_report_', panel.member, '.tex', sep = ''))
  texi2dvi(paste(getwd(),'/Terminology2/reports/Delphi_T2_report_', panel.member, '.tex', sep = ''), clean = TRUE, pdf = TRUE,texinputs=paste(getwd(),'/Terminology2/reports/Delphi_T2_report_', panel.member, '.tex', sep = ''), texi2dvi="pdflatex")
   file.copy(from=paste(getwd(),'/Delphi_T2_report_', panel.member, '.pdf', sep = ''), to=paste(getwd(),'#/Terminology2/reports final/Delphi_T2_report_', panel.member, '.pdf', sep = ''),overwrite = TRUE)
}


