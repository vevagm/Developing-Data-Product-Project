# calculate likes according to several inputs
likes <- function(followers, hashtag, mention, location, category, day, time) {
    # average 4% of followers like http://clicknathan.com/web-design/instagram-statistics/
    followers <- followers * 0.04
    predict <- followers
    # single hashtag average 12.6 percent more engagement (http://www.adweek.com/news/technology/14-instagram-data-findings-every-marketer-needs-know-160969)
    if (hashtag == "yes") {predict <- predict + (followers * 0.126)}
    # mentions recieve 56% more (http://sproutsocial.com/insights/5-instagram-stats/)
    if (mention == "yes") {predict <- predict + (followers * 0.56)}
    # locations recieve 79% more (http://sproutsocial.com/insights/5-instagram-stats/)
    if (location == "yes") {predict <- predict + (followers * 0.79)}
    # using proportions of categories from http://rakaposhi.eas.asu.edu/instagram-icwsm.pdf
    if (length(category)>0){
        if (sum(category %in% c("pet","fashion"))>0) {predict <- predict - (followers * 0.07)}
        if (sum(category %in% c("friends","selfie"))>0){predict <- predict + (followers * 0.05)}
        if ("activity" %in% category){predict <- predict + (followers * 0.1)}
    }
    # using NY share times (http://lab.softwarestudies.com/2014/11/when-do-people-share-comparing.html)
    if (day %in% c("Monday","Wednesday")) {predict <- predict - (followers * 0.10)}
    else if (day %in% c("Saturday","Sunday")){predict <- predict + (followers * 0.2)}
    # using NY share times (http://lab.softwarestudies.com/2014/11/when-do-people-share-comparing.html)
    if (time %in% c("Late Night","Morning")) {predict <- predict - (followers * 0.4)}
    round(predict)
}

radioText <- function(value, text) ifelse(value == "yes", text, paste("no", text))
checkBoxText <- function(category){
    if (length(category > 0)) {text <-paste("featuring:[",paste(category, collapse = ', '),"]")}
    else text <- "no features,"
    text
}

shinyServer( function(input, output) {
    output$parameters <- renderPrint({paste(input$followers, "followers,", radioText(input$hashtag, "hashtag,"), radioText(input$mentions, "mentions,"), radioText(input$location, "location,"), checkBoxText(input$category),"posted on a", input$day, input$time)}) 
    output$prediction <- renderPrint({likes(input$followers, input$hashtag, input$mentions, input$location, input$category, input$day, input$time)}) 
} )