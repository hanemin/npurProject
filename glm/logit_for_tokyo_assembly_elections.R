library(rvest)
library(dplyr)
library(jsonlite)
library(stringr)
library(magrittr)
library(data.table)

basicUrl = read_html("http://www.tokyo-np.co.jp/senkyo/togisen2017/tod/tod_touha.html")
urlList = basicUrl %>% html_nodes(xpath = "//ul[@class='clearfix']//a") %>% html_attr("href")

numberOfPlace = urlList %>% length

nameInfoList = c()
careerInfoList = c()
partyInfoList = c()
recommendationInfoList = c()
newOrOldInfoList = c()
winCountInfoList = c()

for (i in 1:numberOfPlace){
  Sys.sleep(3)
  tmpHtml = read_html(paste("http://www.tokyo-np.co.jp", urlList[i], sep=""))
  tmpnameInfoList = tmpHtml %>% html_nodes(xpath = "//li[@class='name']") %>% html_text()
  tmpcareerInfoList = tmpHtml %>% html_nodes(xpath = "//li[@class='keireki']")%>% html_text()
  tmppartyInfoList = tmpHtml %>% html_nodes(xpath = "//li[@class='shozoku']")%>% html_text()
  tmprecommendationInfoList = tmpHtml %>% html_nodes(xpath = "//li[@class='suisen']")%>% html_text()
  tmpnewOrOldInfoList = tmpHtml %>% html_nodes(xpath = "//li[@class='sinkyu']")%>% html_text()
  tmpwinCountInfoList = tmpHtml %>% html_nodes(xpath = "//li[@class='kaisu']")%>% html_text()

  nameInfoList = cbind(nameInfoList, tmpnameInfoList)
  careerInfoList = cbind(careerInfoList, tmpcareerInfoList)
  partyInfoList = cbind(partyInfoList, tmppartyInfoList)
  recommendationInfoList = cbind(recommendationInfoList, tmprecommendationInfoList)
  newOrOldInfoList = cbind(newOrOldInfoList, tmpnewOrOldInfoList)
  winCountInfoList = cbind(winCountInfoList, tmpwinCountInfoList)
}

candidateInfo = 
