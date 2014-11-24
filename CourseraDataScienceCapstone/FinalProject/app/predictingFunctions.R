######### LOAD DATA ##########

#Loads the files "2grams" and "3grams" in a folder called "data" and returns a list
loadData <- function() {
  print("Loading data...");
  tbl=list()
  tbl[[1]]<-read.table("data/uniqueWords");
  tbl[[2]]<-read.table("data/2grams");
  tbl[[3]]<-read.table("data/3grams");
  print("Data is loaded");
  return(tbl);
}



######### PREDICTING FUNCTIONS ##########
## There are two functions:
## predictSingleWord:  Tries to predict the word given the first letters
## predict: Tries to predict the next word in a sentence

#Given a sentence obtains last n words
getLastNWords<-function(sentence,n){
	sentenceV<-strsplit(sentence, split=" ")[[1]];
	return(sentenceV[(length(sentenceV)+1-n):length(sentenceV)]);
}





#Given sentence with the last word incompleted, tries to complet the last word of the sentence
predictEndingWord<-function(sentence,tables=tbl){
	table=tables[[1]];
	
	###check length of the sentence 
	if ( sentence=="" || length(tables)==0){
		return("");
	}
	sentenceLength<-length(strsplit(sentence, split=" ")[[1]])
	if (sentenceLength==0){
		return ("");
	}

	#Obtain first letters of the last word in a sentence
	startChars<-getLastNWords(sentence,1);
	lenStartChars<-nchar(startChars);

	regex<-paste("^",startChars,sep="")
	gram1Filt<-table[grep(regex, table[,2]), ]
	if (dim(gram1Filt)[1]==0){
		return("");
	}else{
		#get predicted word
		predWord<-as.vector(gram1Filt[1,2])[1];
		#complete the sentence with the predicted word
		predSentence<-substr(sentence,0,nchar(sentence)-lenStartChars);
		predSentence<-paste (c(predSentence,predWord), collapse = ""); 
		return(predSentence);
	}
}



#Given a sentence and a table of ngrams (2grams and 3grams) returns the predicted words
#(the number of predicted words can be adjusted using "numPredictedWords" parameter)

predict<-function(sentence,tables=tbl,numPredictedWords=1){
	###check length of the sentence 
	if (sentence=="" || length(tables)==0){
		return("");
	}
	sentenceLength<-length(strsplit(sentence, split=" ")[[1]])
	if (sentenceLength==0){
		return ("");
	}


	###Search in 3-grams table
	if (sentenceLength>=2){
		prevWords<-getLastNWords(sentence,2);
		ngramsSize<-3;
		table<-tables[[ngramsSize]];
		#search in the table
		sol<-table[table[,2]==prevWords[1] & table[,3]==prevWords[2],]
	
		#if we have found something we return it
		if (dim(sol)[1]>0){
			prediction<-as.vector(sol[1,4])[1];
			return (prediction)
		}
	}


	
	###Search in 2-grams table
	prevWords<-getLastNWords(sentence,1);
	ngramsSize<-2;
	table<-tables[[ngramsSize]];
	sol<-table[table[,2]==prevWords[1],]
	#if we have found something we return it
	if (dim(sol)[1]>0){
		prediction<-as.vector(sol[1,3])[1];
		return (prediction)
	}

	
	###if we have not found anything we return empty string
	return ("")
}



