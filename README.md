# Bitpanda Challenge
For the test I have used some external libraries (only for images) to be able to deal with SVGs and load the images. The architecture chosen has been MVVM, where the View Models act mainly as datasource and data representations, while the ViewControllers just print the ViewModel information. The app has been built in a scalable way, ready to support new features.

There are only tests for the Model layer since the testing part would take me more time than what is scoped for this test. But they could be easily implemented. UI tests where also out of the scope.

Even though SwiftUI is my favorite UI framework, no problem dealing with UIKit, since it was a hard requirement.

The chosen package manager method has been Cocoapods, mainly due to unavailability of some needed libraries in Swift Package Manager.

# Libraries used
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [SVGKit](https://github.com/SVGKit/SVGKit)
