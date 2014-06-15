
shinyUI(
 pageWithSidebar(
 	# Application title
	 headerPanel("Mean calculator"),
 	sidebarPanel(
 	textInput('numbers', 'Insert numbers separated by commas'),
	submitButton('Submit')
 ),
 mainPanel(
	 h3('Mean and s.d. of the numbers'),
 	h4('Mean:'),
 	verbatimTextOutput("themean"),
 	h4('Standard deviation:'),
 	verbatimTextOutput("thesd")
 )
 )
)