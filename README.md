# ThoughtBank

Welcome to ThoughtBank, where anonymity meets connection. Ever had a thought you wanted to share but hesitated? ThoughtBank is your canvas for expressing freely, without fear or judgment.

## How it Works
ThoughtBank is a space where you can deposit your musings, reflections, or random ideas anonymously. Each thought is a seed planted in our collective garden of ideas. But here's the twist: for every thought you deposit, you gain access to a wealth of insights from others who've shared their musings. Curious about how we made this happen? Please check out the [Visual Design](https://www.figma.com/file/ySMt1QXYB5kSYs3WcPn0uz/AppDev?type=design&node-id=0%3A1&mode=design&t=NqMa4cAbqaVhDgRO-1)

## Built with

- ⚙️ iOS Development: [Swift](https://developer.apple.com/swift/), [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- 🧠 AI Integration: [OpenAI API](https://beta.openai.com/docs/)
- 🔥 Database: [Firebase](https://firebase.google.com/docs/firestore/)
- 🎨 Design: [Figma](https://www.figma.com/)

## Why did we build it this way?
The data logic for the live app will be contained in the `CentralViewModel`
class (for all views).

We want to avoid live data being incorporated into our previews as it gets 
messy when dealing with external APIs. Because of this, we have a
`PreviewViewModel` class which mirrors `CentralViewModel` but returns dummy
data so that we can test out the UI without worrying about the backend.

Having a `ViewModelProtocol` ensures that both view model implementations
have consistent behavior and that views need not worry about the differences
between them.


## Challenges we ran into
In our app, the coexistence of UI and backend operations on a single thread occasionally resulted in stalls, leading to unresponsiveness during asynchronous functions like fetching. To address this, we opted for a separation of concerns, executing UI code on the main thread and backend calls on a distinct thread. This architectural shift markedly improved app responsiveness and user interaction. For a comprehensive understanding of our solution, please refer to [Solution Details](https://drive.google.com/file/d/1QU0mq72b7LFYCrFwlESDCj9KK4c1H-wz/view?usp=sharing).

## Accomplishments that we're proud of
In our quest to foster a positive and inclusive community within our app, we implemented a robust review moderation system. This system, powered by the OpenAI API, dynamically filters and prevents the display of thoughts that violate community guidelines, such as instances of harassment, hate speech, or inappropriate content. We take pride in achieving a secure and welcoming environment by leveraging cutting-edge technology to ensure that every thought shared contributes to a respectful and enjoyable community experience.

