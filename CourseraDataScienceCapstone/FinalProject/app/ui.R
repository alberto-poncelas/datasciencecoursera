

library(shiny);

# Define UI for dataset viewer application
shinyUI(fluidPage(
  

  includeCSS("styles.css"),

  #Never display this panel, it is only used to load data
  conditionalPanel(
    condition="1==0", 
    h3(textOutput("hidden",container = span))
  ),


  # Application title
  titlePanel("Word predictor"),
  

  verticalLayout(

    #The instructions
    div(class="instructions",
      
      mainPanel("Write your sentence in the box below."),
      mainPanel("While you type, the app will try to predict the word you are typing (write <underscore> to autocomplete)"),
      mainPanel("As soon as you press <space> the app will try to predict the next word")
    ),
    

    #A panel displaying while the app loads
    div(class="loading_class",
      conditionalPanel(
        #Display a Loading message while loading
        condition="output.hidden!=''", #this is output$hidden (here with . in server with $)
        h3(mainPanel("Loading..."))
      )
    ),



    #The input box
    div(class="input_panel",
      conditionalPanel(
        condition="output.hidden==''", 
        sidebarPanel(
          width = 15,
          textInput("caption", "Write your sentence here:", "")
        )
      )
    ),

    #The output box where the predicted word will be displayed
    div(class="results_panel",
      mainPanel(
        h3(textOutput("predicted_sentence", container = span))
      )
    )



  )
))

