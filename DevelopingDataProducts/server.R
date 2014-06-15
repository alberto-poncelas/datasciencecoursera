library(shiny)

meanCalculator<-function(nums){
	t<-as.numeric(strsplit(nums, ",")[[1]])
	m<-mean(t)
	return (m);
}

sdCalculator<-function(nums){
	t<-as.numeric(strsplit(nums, ",")[[1]])
	s<-sd(t)
	return (s);
}


shinyServer(
 function(input, output) {
	output$themean<-renderPrint({meanCalculator(input$numbers)})
	output$thesd<-renderPrint({sdCalculator(input$numbers)})


 }
)