# ThoughtBank

## Screens

- LandingPage (Soham Shetty)
- SettingsView (Jannah Abuhassan)
- RegistrationView, LoginView (Tuan Cai)
- PersonalThoughtsView (Jordan)
- DepositedThoughtsView (Lakish)
- FeedView (Ethan)
- PostThoughtView (Vamsi)
- BottomNavigationBar, TopNavigationBar (Steven)

## MVVM Setup

Each view already has its VM defined. All views will share a single, monolithic
view model which conforms to `ViewModelProtocol`.

When implementing views, all you really need to look at is the
`ViewModelProtocol` class and the functions it implements.

When implementing the view model, make sure to first define functions in
`ViewModelProtocol` before modifying _both_ `CentralViewModel` and
`PreviewViewModel`.

### Why do it this way?

The data logic for the live app will be contained in the `CentralViewModel`
class (for all views).

We want to avoid live data being incorporated into our previews as it gets 
messy when dealing with external APIs. Because of this, we have a
`PreviewViewModel` class which mirrors `CentralViewModel` but returns dummy
data so that we can test out the UI without worrying about the backend.

Having a `ViewModelProtocol` ensures that both view model implementations
have consistent behavior and that views need not worry about the differences
between them.
