# Instructions 

use "start": to say where to start

ex: "start": "name of page"

the top is "the page name"

"startText" is text that will be shown with the buttons

"action" is the name on the button

"text" is the text that will show after hitting the button (if left black it will just go to the next page)

"goTo" is the page to go to

you can instead us "chapterGoTo" to go to a new json chapter just put the name of the json file like this:
ex: "chapterGoTo": "next chapter"



to use the inputted player name us "(player_name)"

to use the inputted player gender us "(gender_sir_mam)" or "(gender_he_she)" or "(gender_him_her)"

# example story

{

   "name of page1": {
      "startText": "You are now in jail and need to escape what shall you doooo?",
      "options": {
         "1": {
            "action": "Kick the door",
            "text": "You kick the door and it falls with ease",
            "goTo": "name of page2"
         },
         "2": {
            "action": "Wait",
            "text": "You begin waiting",
            "goTo": "name of page1"
         },
         "3": {
            "action": "Scream",
            "text": "You scream at the top of your lungs \"Heeeelllppppp!\" guard runs up and says \"You idiot (player_name) (gender_sir_mam) you made me run all the way here!\"",
            "goTo": "name of page1"
         }
      }
   },

 "name of page2": {
      "startText": "text",
      "options": {
         "1": {
            "action": "text",
            "text": "text",
            "goTo": "name of page3"
         },
         "2": {
            "action": "text",
            "text": "text",
            "goTo": "name of page2"
         },
         "3": {
            "action": "text",
            "text": "text",
            "goTo": "name of page1"
         }
      }
   }

}