# Potpourri: A UW Bathroom Mapper

By Elias Belzberg, Kathryn Koehler, and Fernando Pazaran for CSE 340.

## Description
The University of Washington's Seattle campus sprawls across more than 600 acres, and can be daunting to navigate for newcomers. Many mapping services can help students get from one building to another--but can these apps tell them which of the bathrooms suck? This application allows users to leave reviews of bathrooms in each building to later reference, saving them from the horror of walking into dimly lit, poorly maintained, echoey facilities.

### Features
- Pannable/zoomable map of UW shows locations of commonly accessed buildings with bathrooms
- Move the map as the location of the user changes
- Buildings with bathrooms also listed in sidebar drawer for quick access, organized by average rating
- Each listed bathroom allows users to browse reviews, leave reviews, and see the location isolated on a map
- Reviews are aggregated to display an average star rating
- "I'm Feeling Lucky" random bathroom selection

## Resources Used
- Flutter Rating Bar: https://pub.dev/packages/flutter_rating_bar
- Flutter_Map Package: https://docs.fleaflet.dev/
- WeatherProvider: weatherChecker, and positionProvider based on FoodFinder
- JsonSerilizable: https://docs.flutter.dev/data-and-backend/serialization/json
- Original campus building latitudes and longitudes were from CSE331, but they were not correct so we had to edit the positions, as well as add additional fields as needed.

## Data Design
The main map view uses a `PositionProvider` to get the user's position and display it on the map and get the app's initial latitude and longitude, as well as a `WeatherProvider` to display current weather information at the user's position. The main view also uses a `CampusProvider` to get information about the buildings on campus and manage their state. A Campus is a list of `Buildings`, and each building has information such as `name` (string), `abbreviation` (string), `latitude` (double), `longitude` (double), and average `rating` (double), and a list of `Review`s. Each `Review` has `review` text (string), a `rating` (double), and a boolean `canEdit` flag that determines if the review can be edited.

## Data Flow
The `PositionProvider` and `WeatherProvider` are constantly updating the home view's state with new location and weather data. The `CampusProvider` updates the main view's state whenever a `Building`'s state is changed.

When a `Building`'s state is edited, by someone leaving a review from the `BuildingEntryView`, once the view is popped and the user enters back to the home view, the `CampusProvider` is used to update the current building with a cloned copy and updated list of `Review`s in place, which are set to `canEdit=false`. This updates the states of our buildings and makes it so past reviews cannot be edited by users who did not write them. Because the main view is listening
to changes on the `CampusProvider` the information is updated for all of the buildings in the view.

## Contributing
We are not open to contributions at this time.

## Project status
Current status: development paused.
