#in dev.twitter.com
#email login is jtantongco@gmail.com
#twitter screen name login is jer_tantongco
#API key - in twitter apps under api keys
apiKey <- '**'
# API secret
apiSecret <- '**'

token <- '**'
tokenSecret <- '**'


library(httr)
myapp = oauth_app("twitter",
                  key=apiKey,
                  secret=apiSecret)
sig = sign_oauth1.0(myapp,
                    token = token,
                    token_secret = tokenSecret)
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig) #URL desired, authentication details

library(jsonlite)

json1 = content(homeTL) #parse json into R
json2 = jsonlite::fromJSON(toJSON(json1)) #json lite object that is more useable

#json2[1,1:4] #each row is a tweet in your home timeline
#4 columns: created_at, id, id_str, text contents of tweet

# Go to twitter api for other urls that are appropriate
# https://dev.twitter.com/docs/api/1.1/get/search/tweets
# https://dev.twitter.com/docs/api/1.1/overview
