Audited by: Group 13
Wednesday May 29, 2024
Commit id: 383a6be5

We met up with Team 13 at school to do the audit together on one of our laptops (a Mac). While they explored our app, we noted down their thoughts and wrote up their explanations and recommendations. 

The good:
- Keyboard navigable
- Most of the colors contrast well
- The buttons for navigation are pretty big, and thus easy to hit
- Many elements give some level of explanation when a screen reader is used

## Issue #1 - Size and Contrast

- Name/Brief Description: Color Contrast
- Testing Method: WebAim Contrast Checker
- Evidence: WCAG Contrast Failure (1.4.11)

![Screenshot of the WebAim contrast checker showing all tests failing.](/docs/contrast1.png)

![Screenshot of the interface--the icon indicating a user's location is shown in yellow against a grey map.](/docs/contrast2.png)

- Explanation: The map pin indicating where the user is located on the map is not contrastive enough with the background. Because it is a bright yellow, and the background is mostly grey and white, it's difficult to make out the icon even though it's such a bright color. This violates the WCAG success criterion 1.4.11 Non-Text Contrast minimum score for non-text elements. 
- Severity: 1 - Cosmetic
- Justification: The issue is always visible on the main map view. While the contrast is not great, it's still pretty clear what the icon is meant to represent and you can always tell where it is on the map. It's just not easy on the eyes and might be an issue for users with colorblindness. The issue is partially helped by the size of the icon, which is very large; if it were smaller it would be a bigger issue for any user to see it.
- Possible Solution: Consider making the icon a darker color, or outlining the icon in black so it stands out more against he background. Could also try changing the map display settings if possible to increase the contrast.


## Issue #2 - Screen Reader Accessibility

- Name/Brief Description: Screen Reader failure
- Testing Method: Using application
- Evidence: MacOS VoiceOver utility

- Explanation: The list elements in the drawer don't read off the rating average. Titles for each building inside the building view repeat themselves. When using the main map view, the screen reader utility repeats the word "toilet" over and over for each icon shown on the map.
- Severity: 2 - Mild
- Justification: The issue is fairly infrequent--most of the elements on the page appropriately explain their purpose and describe themselves accurately. There are a few elements on the page that either don't do this, or do it in a way that is unhelpful. Someone using a screenreader would probably not have much difficulty figuring out what's going on on the screen, but it would add a little annoyance as they tried to navigate through the interface.
- Possible Solution: Consider adding more semantic tags, and/or getting more granular with where and how they're applied to avoid repeats. 


## Issue #3 - Robustness

- Name/Brief Description: Infinite Load
- Testing Method: Using application

![Screenshot of the loading page of the application.](/docs/robustness.png)

- Explanation: If a user does not allow the app to access their location data, the app just loads endlessly. There is not an option provided to let the user choose to give the app access again, so they just have to restart the app. This is essentially a crash.
- Severity: 2 - Mild
- Justification: The issue is always possible to run into for any user. If someone accidentally clicks the wrong button, or just wants to browse the app without being able to see the distance to each building, they have no option but to close and restart the application entirely. This is very tedious and locks users into a single binary choice early on in the decision tree.
- Possible Solution: Consider prompting the user multiple times for their location data if they do not allow it initially. Also, users could potentially still browse the data on the app or leave reviews without having their location shared, it would just be a slightly different user experience.
