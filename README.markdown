# My Implementation

This implementation of the challenge was made with Rails.  The code consists of a web app and a background daemon which processes the uploads.
Foreman is used to manage both processes.

To get it running:

    $ bundle install
    $ rake db:migrate
    $ foreman start

The web application creates an `Upload` record for each uploaded file.  The `UploadDaemon` processes each new `Upload` in the background.
Any validation errors that are encountered are stored in the database and can be reviewd via the web interface.  The app calculates the
gross revenue of each uploaded file separately.

----------
# Challenge for Software Engineer - Big Data 
To better assess a candidates development skills, we would like to provide the following challenge.  You have as much time as you'd like (though we ask that you not spend more than a few hours) and may use any programming language or framework you'd like.  Feel free to email [data.challenge@livingsocial.com](mailto:data.challenge@livingsocial.com) if you have any questions.

## Submission Instructions
1. First, fork this project on github.  You will need to create an account if you don't already have one.
1. Next, complete the project as described below within your fork.
1. Finally, push all of your changes to your fork on github and submit a pull request.  You should also email [data.challenge@livingsocial.com](mailto:data.challenge@livingsocial.com) and your recruiter to let them know you have submitted a solution.  Make sure to include your github username in your email (so we can match people with pull requests).

## Alternate Submission Instructions (if you don't want to publicize completing the challenge)
1. Clone the repository
1. Next, complete your project as described below within your local repository
1. Email a patch file to [data.challenge@livingsocial.com](mailto:data.challenge@livingsocial.com).

## Project Description
Imagine that LivingSocial has just acquired a new company.  Unfortunately, the company has never stored their data in a database and instead uses a plain text file.  We need to create a way for the new subsidiary to import their data into a database.  Your task is to create a web interface that accepts file uploads, normalizes the data, and then stores it in a relational database.

Here's what your web-based application must do:

1. Your app must accept (via a form) a tab delimited file with the following columns: purchaser name, item description, item price, purchase count, merchant address, and merchant name.  You can assume the columns will always be in that order, that there will always be data in each column, and that there will always be a header line.  An example input file named example_input.tab is included in this repo.
1. Your app must parse the given file, normalize the data, and store the information in a relational database.
1. After upload, your application should display the total amount gross revenue represented by the uploaded file.

Your application does not need to:

1. handle authentication or authorization (bonus points if it does, extra bonus points if authentication is via OpenID)
1. be written with any particular language or framework
1. be aesthetically pleasing

Your application should be easy to set up and should run on either Linux or Mac OS X.  It should not require any for-pay software.

## Evaluation
Evaluation of your submission will be based on the following criteria:

1. Did your application fulfill the basic requirements?
1. Did you document the method for setting up and running your application?
1. Did you follow the instructions for submission?
