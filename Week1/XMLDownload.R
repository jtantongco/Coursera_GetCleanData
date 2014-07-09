library(XML)

fileUrl <-  "http://www.w3schools.com/xml/simple.xml"

doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode) #master enclosing? --- menu
names(rootNode) #enclosing children tags --- food

#Working the object:
#rootNode[1] --- xml object data + R details
#rootNode[[1]] --- xml object data only
#rootNode[[1]][[1]] --- first child data of xml object data

# programatically extract details
# params - parsed XML obj, function to apply
xmlSapply(rootNode, xmlValue)

#getting the values enclosed within the xml file
# xml obj, thing to find in xml obj, fcn
xpathSapply(rootNode,"//name",xmlValue)
xpathSapply(rootNode,"//price",xmlValue)