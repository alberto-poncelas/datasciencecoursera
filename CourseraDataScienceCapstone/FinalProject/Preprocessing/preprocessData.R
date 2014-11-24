
######### LOAD DATA ##########

tbl=list()
tbl[[2]]<-read.table("grams2Count")
tbl[[3]]<-read.table("grams3Count")


#####  PREPROCESSING ########

#Filter ngrams so we have only one (the most probable) prediction for each word/two words

tbl2F<-tbl[[2]]
tbl2F <- tbl2F[order(tbl2F$V2, -tbl2F$V1 ), ] 	#order by 1st word of 2-gram and then by the number of ocurrences (descending)
tbl2F<-tbl2F[ !duplicated(tbl2F$V2), ]		#Remove duplicates and just keep the first occurrence


tbl3F<-tbl[[3]]
tbl3F <- tbl3F[order(tbl3F$V2, tbl3F$V3, -tbl3F$V1 ), ]
tbl3F<-tbl3F[ !duplicated(c(tbl3F$V2,tbl3F$V3)), ]


#####  WRITE NEW n-GRAMS ########

write.table(tbl2F,"2grams");
write.table(tbl3F,"3grams");


