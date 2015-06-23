shinyUI(pageWithSidebar( headerPanel("Predicting Instagram Likes"), sidebarPanel(
    numericInput('followers', 'Followers', 0, min = 0, max = 25000000, step = 10), 
    radioButtons('hashtag',"Hashtags", c("Yes" =  "yes", "No" = "no"), selected = "No", inline = TRUE),
    radioButtons('mentions',"Mentions/Tags", c("Yes" =  "yes", "No" = "no"), selected = "No", inline = TRUE),
    radioButtons('location',"Location", c("Yes" =  "yes", "No" = "no"), selected = "No", inline = TRUE),
    checkboxGroupInput("category", "Featuring",c("Friends/Family", "Food/Drink", "Gadgets","Pets", "Activity", "Selfie","Captioned Photo/Meme", "Fashion")),
    selectInput("day", "Day of the Week:", c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday", "Sunday")),
    selectInput("time", "Time:", c("Morning","Afternoon","Evening/Night", "Late Night"))),
    mainPanel(
        h3('Instructions'),
        p('Enter the number of followers you have on Instagram followed by whether you added hashtags (#thisIsAHashtag), mentions or tags (@user or tagging in picture) and locations.'), 
        p('Next select all the categories that apply to your picture. For more information on the categories follow ', a("this link.", href="http://rakaposhi.eas.asu.edu/instagram-icwsm.pdf")),
        p('Finally select the day and time you posted or plan to post the picture.'), 
        br(),
        h3('Results'),
        h4('Given the following parameters you entered'), 
        verbatimTextOutput("parameters"), 
        h4('Your predicted number of likes is'),
        verbatimTextOutput("prediction"), 
        br(),
        img(src = "http://st2.depositphotos.com/4275257/6298/v/450/depositphotos_62983257-Set-of-social-icons-like-instagram.jpg",width="250px",height="250px"),
        p('DISCLAIMER: No regression or formal prediction algorithms done on data, this is a made up prediction solely for creating a shiny application for the Developing Data Products class. See for code and basis of this prediction at https://github.com/vevagm/Developing-Data-Product-Project', style = "color:red")
    ) ))