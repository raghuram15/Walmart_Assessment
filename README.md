
I have used **MVVM** design architecture in code with the help of repository design pattern 
Used Core data to save the fetched data from url 

**To match the acceptance criteria:**

-> When the  API is up (working) AND the phone is connected to the internet. The user arrives for the first time today
The user arrives at the APOD page for the first time today then the page will display image of Astronomy 
Picture of the Day along with the title and explanation, for that day

-> The user arrives for the first time today and the phone is not connected to internet 
then the Alert message will display, letting the user know that they are not connected to the network.

-> The user has already seen the APOD page once AND the phone is not connected to
the internet. In this case data is fetched from core data and populated on the screen

"Improvement Areas"

Used hardcoded Api key in code. Which can be encrypted with the help of keychain.
