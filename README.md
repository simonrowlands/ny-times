# ny-times-most-popular
An application that displays the most popular articles from the NY Times API in a table view.

The project uses an MVVM architecture and utilisies structs, extensions and some class inheritance to separate and define the code more clearly.

The application is using storyboards; this was a design decision to reduce the time taken to create the app and to allow for an easy overview of the UI within Xcode.

The UI is using accessibility labels to allow for font size adjustments.

There is no database within the app, the images and data are loaded on demand and stored in memory. Given more time this would be moved over to a caching service.
