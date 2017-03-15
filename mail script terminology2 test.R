##################################################################
#                                                                #
# Script to send emails to Delphi panel with individual analyses #
#                                                                #
##################################################################

#14-12-2015#

#Required R libraries for mail#
install.packages("mailR")
install.packages("sendmailR")
library(mailR)
library(sendmailR)

################################################################

library(xlsx,psych)
#delphi.data<-read.xlsx(paste(getwd(),"\\delphi data\\delphi_results.xlsx",sep=""),sheetName="Sheet1")

delphiTa.email.data<-read.xlsx("H:/DVMB/OX_delphi/test data/catalise_qualtrics1.xlsx",sheetName="catalise_qualtrics1")

DelphiTa.name<-apply(delphiTa.email.data[,c("firstname","lastname")], 1, paste, collapse=" ")
Delphi.membersTa<-cbind(delphiTa.email.data[,1:5],DelphiTa.name)
for(i in 1:6){Delphi.membersTa[,i]<-as.character(Delphi.membersTa[,i])}

################################################################

#####send result email with report and round 2 items attachments

for(i in 1:1)
  #for(i in c(1:2))
{
  mailControl=list(smtpServer="smtp.ox.ac.uk")
  
  #key part for attachments, put the body and the mime_part in a list for msg
  attachmentObject <- mime_part(x=paste(getwd(),"/Delphi_T_report_ANONYMOUS.pdf",sep=""),name="Delphi_T_report_ANONYMOUS.pdf")
  
  #
  body = paste("Dear ", Delphi.membersTa[i,6],", \n \n Many thanks for participating in CATALISE TWO (terminology) Delphi study.
\n Enclosed is a report showing the summary findings together with an indication of where your responses fell in the distribution. We will be continuing to review the results and intend to have further discussion at the January 8-9th meeting in Oxford.
\n \nBest wishes,\n \nPaul Thompson\n \nOn behalf of\n \n Dorothy Bishop, Professor of Developmental Neuropsychology,
             \nDept of Experimental Psychology, University of Oxford, OX1 3UD.\ntel +44 (0)1865 271369; fax +44 (0)1865 281255;\nWEB: www.psy.ox.ac.uk/oscci\nBlog: http://deevybee.blogspot.com/\nRaising Awareness of Language Learning Impairments! See www.youtube.com/RALLIcampaign",sep="")
  
  bodyWithAttachment <- list(body,attachmentObject)
  
  
  sendmail(from="paul.thompson@psy.ox.ac.uk",bcc="paul.thompson@psy.ox.ac.uk",to=Delphi.membersTa[i,5],subject=paste("CATALISE TWO (Terminology) result: ", Delphi.membersTa[i,6]),msg=bodyWithAttachment,control=mailControl)
}

################################################################


