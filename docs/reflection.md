Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them.

- Properties of people: vision. We applied this by appropriately handling screen reader access and color contrast on all views and elements.
- Properties of people: Motor Control (Fitt's Law). Made all buttons large, and when possible, close to the user's likely point of contact.
- Stateless & stateful widgets. Held information about reviews, review aggregations, map locations, and weather data.
- Accessing sensors (GPS). Found user location to put onto map via location sensors in device.
- Querying Web services (Weather). Queries NWS for weather data at user's location.
- Undo and Redo. Allowed users to undo and redo their writing in reviews as well as the ratings they left through the star bar interface.


Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?

We were originally planning on actually routing users to their destination, but realized this would be hugely difficult in the limited time we had. We later thought we might allow a user to pop out the directions to the building by opening a Maps window from the application and just taking them out of the view, but decided that our app wasn't really meant to get users to their destinations, but instead merely show them options of bathrooms to go to.


Discuss how doing this project challenged and/or deepened your understanding of these topics.

This project allowed us to dig deeper on Undo and Redo, since we had to implement it in a somewhat more complex environment than we were dealing with in the Journal assignment. The bulk of the work was really in dealing with stateless and stateful widgets, however. We had a fairly interconnected application to build, and at times increased or decreased the number of providers and controllers we implemented as our understanding of the scope of the project changed. It took a lot of deliberation to get to the final architecture of our completed application.


Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app.

We would like to implement secure data persistence for users so their reviews are saved within the app. This would improve the usability tremendously, because then users could keep a sort of log of their own experiences. It would also be really neat to set up our own web service such that all user data and reviews could be saved and accessed by any device, and thus achieve real usability as an application independent of this course. We could also work on creating alternative interfaces for users with motion impairments of vision differences, so the app is easy to use for anyone of any ability (like introducing different color settings for colorblind users, etc). 


Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

We used the documentation of the previously cited packages to complete this project (see README). We also made use of our own work from prior assignments (Journal, Food Finder, Drawing), and with permission made use of a dataset of UW buildings (edited greatly) that was provided to us in another class at the Allen School (CSE 331).



Finally: thinking about CSE 340 as a whole:

What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?
If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?)

The most valuable thing we learned was the Model-View-Controller pattern, implemented on a larger and more complicated scale than we had seen before. In other courses, this pattern was mentioned or made minor use of, but in this course we really got to dig into it ourselves, particularly in this final assignment where we needed to come up with the entirety of the application's structure and architecture ourselves.

Advice:
- Be open about difficulties: post on Ed, which will also encourage other students to do the same
- Read the spec very thoroughly before starting an assignment, and treat it like a true checklist: don't jump around too much or you may miss things