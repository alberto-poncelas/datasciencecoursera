

library(shiny)
library(stringr)


#load the functions for predicting
source('predictingFunctions.R')

#Variables
lastPressedKey<-"";
predictWord<-""; 
tbl<-list();
 
# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output,session) {
	



	
	#Write a message of "Loading data" while the data loads (use a hidden variable)
	output$hidden  <- renderText({

		# Create a Progress object
		progress <- shiny::Progress$new()
		progress$set(message = "Please, wait until the app is loaded", value = 0)

		#Load the n-grams (we do a global asignation using "<<-")
		tbl<<-loadData();

		# Close the progress when this reactive exits 
		on.exit(progress$close())


	})



	#Do when a key is pressed
	observe({


		#Get the input word
		theInput<-input$caption
		lastPressedKey<-substring(theInput,nchar(theInput));

		if (lastPressedKey==" "){
			predictWord<-predict(theInput,tbl);
			theOutput<-paste (c(input$caption,predictWord), sep = " ");
		}else if (lastPressedKey=="_"){
			#If the last pressed key is "_" then autocomplete the input
			
			#Remove last char "_"
			theInput<-substr(theInput,0,nchar(theInput)-1);
			theOutput<-predictEndingWord(theInput,tbl); 
			updateTextInput(session, "caption",  value = theOutput);

		}else{
			theOutput<-predictEndingWord(theInput,tbl); 
		}




		#Create the output
		isolate({
			output$predicted_sentence <- renderText({theOutput;})
		})



	})



})

