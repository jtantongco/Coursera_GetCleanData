#hierarchical data format
#installation stuff
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5") #installs

library(rhdf5)
created = h5createFile("example.h5") #create a hdf5 file
#created #should return to true

#Groups within the file
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")

#like ls but for hdf5 file
h5ls("example.h5")

A = matrix(1:10, nr=5, nc=2)
h5write(A,"example.h5","foo/A") #Object to write, file to write to, group

B = array(seq(0.1,2.0,by=0.1), dim=c(5,2,2)) #multi dimensional array
attr(B,"scale") <- "liter" #add units
h5write(B,"example.h5","foo/foobaa/B")

h5ls("example.h5")


df = data.frame(1L:5L, 
                seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"),
                stringAsFactors=FALSE)
h5write(df,"example.h5","df")

h5ls("example.h5")

#reading:
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")

#readA

#modifying the file
h5write(c(12,13,14), "example.h5","foo/A", index=list(1:3,1)) 
#what to write, what file to write to, what group, what indicies
h5read("example.h5","foo/A") #should be different from readA contents
#simliarly the read command has the index for selective reads as well
