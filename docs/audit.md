You should find someone from another team to audit your project.

When they do that, they should not have access to your code.

Instead, they should use your app.



Audited by: Jasper Molinas
Wednesday May 29, 2024
Commit id: 385a6be5

We met up with Jasper at school to do the audit together on one of our laptops (a Mac). While they explored our app, I (Kathryn) noted down their thoughts and wrote up their explanations and recommendations. 

The good:
- Keyboard navigable
- Most of the colors contrast well
- The buttons for navigation are pretty big

## Issue #1 - Size and Contrast

- Name/Brief Description: Color Contrast
- Testing Method: WebAim Contrast Checker
- Evidence: WCAG Contrast Failure (1.4.11)

![Screenshot of the WebAim contrast checker showing all tests failing.](/docs/contrast1.png)

![Screenshot of the interface--the icon indicating a user's location is shown in yellow against a grey map.](/docs/contrast2.png)

- Explanation: The map pin indicating where the user is located on the map is not contrastive enough with the background. Because it is a bright yellow, and the background is mostly grey and white, it's difficult to make out the icon even though it's such a bright color. This violates the WCAG success criterion 1.4.11 Non-Text Contrast minimum score for non-text elements. 
- Severity: 1 - Cosmetic
- Justification: The issue is always visible on the main map view. While the contrast is not great, it's still pretty clear what the icon is meant to represent and you can always tell where it is on the map. It's just not easy on the eyes and might be an issue for users with colorblindness. The issue is partially helped by the size of the icon, which is very large; if it were smaller it would be a bigger issue for any user to see it.
- Possible Solution: consider making the icon a darker color, or outlining the icon in black so it stands out more against he background. Could also try changing the map display settings if possible to increase the contrast.

## Issue #2 - Screen Reader Accessibility



## Issue #3 - Robustness