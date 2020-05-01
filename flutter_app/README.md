# Growth Decks Flutter

## Architecture
While experimenting with different approaches to the provider architecture by using various combinations of [get_it](https://pub.dev/packages/get_it), [provider_architecture](https://pub.dev/packages/provider_architecture) and of course [provider](https://pub.dev/packages/provider). The approach I eventually pretty much the same as presented in the three part medium article series ([Part 1](https://medium.com/flutter-community/understanding-provider-in-diagrams-part-1-providing-values-4379aa1e7fd5), [Part 2](https://medium.com/flutter-community/understanding-provider-in-diagrams-part-2-basic-providers-1a80fb74d4e7) and [Part 3](https://medium.com/flutter-community/understanding-provider-in-diagrams-part-3-architecture-a145e4fbbde1)) shown in the diagram below: 

[<img src="https://github.com/lunaticcoding/MilleSandersApp/blob/developer/images/provider_architecture.png" width="600"/>](provider_architecture.png)

What I was looking for was for a central way to keep track of the state, while also being able to keep the business logic separated from the User Interface. This lead to the creation of ViewModels for the Views which needed additional functionality that I did not want to keep in the State. 

To reduce the length/complexity of the widget tree inside my views, I decided to factor out quite some Widgets. The ones I ended up using in several places are stored in a separate widgets directory while I kept some as private widgets inside the same dart file as the views.

## Tests
I added unit tests for the models/viewmodels and widget tests for widgets with additional functionality. I did forego adding integration tests, because it seemed very excessive for such a simple app. Furthermore I did not test the services because they mostly plugin wrappers which would have been covered by integration tests. 
