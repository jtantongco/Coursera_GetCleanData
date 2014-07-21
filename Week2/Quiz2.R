# Client ID
clientID <- '***'
#Client Secret
clientSecret <- '***'
url <- 'https://api.github.com/users/jtleek/repos'

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", 
                   key=clientID,
                   secret=clientSecret)

# 3. Get OAuth credentials
#caching oauth -> install.packages('httpuv')
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET(url, gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET(url))
stop_for_status(req)
content(req)

json1 = content(req)
json2= jsonlite::fromJSON(toJSON(json1)) 
names(json2) #yields that col 2 and 45 is of interest
json2$names #yields that row 5 is the row of intereset
json2[5,c(2,45)] #answer


#question 4
#library(XML)
#q4Url <- 'http://biostat.jhsph.edu/~jleek/contact.html'
#doc <- htmlTreeParse(q4Url, useInternal=T)


q4Url <- 'http://biostat.jhsph.edu/~jleek/contact.html'
con = url(q4Url)

htmlCode = readLines(con)
close(con)
htmlCode

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#download the webpage just to check
#download.file(q4Url, destfile="./data/webpage.html")

#question 5
#want sum of Nino3 SST
#file was modified to get rid of the header
q5Data <- read.fwf("./data/getdata-wksst8110.for", 
                   widths=c(1,9,5,
                            4,1,3,5,
                            4,1,3,5,
                            4,1,3,5,
                            4,1,3))
head(q5Data)
sum(q5Data$V8)