
#Raw unformated HTMl
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

#XML revisited
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T) #use internalNodes

xpathSApply(html, "//title", xmlValue) #get the contents of the title tag
xpathSApply(html, "//td[@id='col-citedby']", xmlValue) #get all cited by contents

#Get commands - Useful if website requires authentication
#install.packages("httr")

#copy of XML functionality
library(httr); html2 <- GET(url)
content2 <- content(html2,as="text") #Extract content from html page

parsedHtml <- htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

#password authenticated address
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1 #401 error - not authenticated

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd")) #user and passwd are the authentication keypair
pg2 #status 200 - ok - use content function and do other stuff as above

#handles - save authentication/cookies
#http://cran.r-project.org/web/packages/httr/httr.pdf
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")