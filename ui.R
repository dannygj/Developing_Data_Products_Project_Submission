library(markdown)

includeRmd <- function(path){
        if (!require(knitr))
                stop("knitr package is not installed")
        if (!require(markdown))
                stop("Markdown package is not installed")
        shiny:::dependsOnFile(path)
        contents = paste(readLines(path, warn = FALSE), collapse = '\n')
        html <- knitr::knit2html(text = contents, fragment.only = TRUE)
        Encoding(html) <- 'UTF-8'
        return(HTML(html))
}

shinyUI(navbarPage("Developing Data Products Project Submission",
                   tabPanel("MPG Prediction Model",
                            pageWithSidebar(
                                    headerPanel("Developing Data Products Project Submission-Predicting MPG"),
                                    
                                    sidebarPanel(
                                            sliderInput('cyl', 'Number of Cylinders', 6, min = 4, max = 8, step = 2),
                                            numericInput('disp', 'Displacement in cu.in.', median(mtcars$disp), min = 70, max = 500),
                                            numericInput('wt', 'Weight in 1000s of lbs', median(mtcars$wt), min = min(mtcars$wt), max = max(mtcars$wt)),
                                            
                                            submitButton('Submit')
                                    ),
                                    mainPanel(
                                            h3('Results of prediction'),
                                            h4('You entered this many cylinders,'),
                                            verbatimTextOutput("inputValue"),
                                            h4('and this much displacement in cu. in.,'),
                                            verbatimTextOutput("inputValue2"),
                                            h4('and this much weight in 1000s of lbs,'),
                                            verbatimTextOutput("inputValue3"),
                                            h4('Which resulted in a prediction of '),
                                            verbatimTextOutput("prediction"),
                                            h4('MPG')
                                    )
                            )
                   ),
                              tabPanel("Documentation",
                                       fluidRow(
                                               column(6,
                                                      includeRmd("about.Rmd")
                                               )
                                       )
                              )
))