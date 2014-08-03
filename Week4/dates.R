#get the runtime current date time
d1 = date()
d1
class(d1) #character type

#get the runtime current date
d2 = Sys.Date()
d2
class(d2) #date type

#format datetimes
#see help file for codes
format(d2,"%a %b %d")

#turn strings into dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
z

#can be added or subtracted based on time unit difference from epoch
z[1] - z[2]

#turn it into a number
as.numeric(z[1]-z[2])

#find out calendar info
weekdays(d2)
months(d2)

julian(d2) #days since epoch

#install.packages('lubridate')
library(lubridate); #convert common date string formats into  R standard
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")

ymd_hms("2011-08-03 10:15:03") #datetimes too!
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
?Sys.timezone #for figuring out your timezones

#syntax technicalities
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1]) # equivalent of weekdays for lubridate, default as # day of the week [% 7]
wday(x[1],label=TRUE) # get the 3 letter abreviation