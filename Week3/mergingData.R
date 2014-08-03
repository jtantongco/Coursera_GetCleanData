if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"

download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")

reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,4)
head(solutions,4)

names(reviews)
names(solutions)
#solution_id of reviews and id of solutions are important

#merge
#basically mysql joins
#params
#x,y, by.x, by.y, all
#by default matches by same name column

#all=TRUE, in case of dangling FK reference, make an NA row
mergedData = merge(reviews,solutions, by.x="solution_id",by.y="id",all=TRUE)
#solution_id takes place of orignally id
#the id left over is the id of the reviews row
head(mergedData)

#finds the cols that have name collision 
#ie the default merging metrics
intersect(names(solutions),names(reviews))

mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2) #has lots of nas due to output of line 30

#faster but less full featured, defaults to left join
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id) #from plyr package
#joins id,x and id,y -> id,x,y joinging on id
#can only merge on common names

#why plyr?
#multiple data frames are hard with the merge command!
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList) 
#joins (id,x),(id,y),(id,z) -> (id,x,y,z) joinging on id
