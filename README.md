# NavigatorPatternPOC


This POC is based on the ideas proposed in [this article](https://jobandtalent.engineering/the-navigator-420b24fc57da)

In this POC: 

* Instead of passing around the `Navigator` instance, I have made it live inside the `Environment` so that it fits better our current project.
* There's one more case for `Navigation`: `root` so that we are able to drop all the navigation stack and start from `UIWindow.rootViewController` if we need to (for instance, when logging out)
* I have created an `OnboardingFlow` to present the case of a complex navigation logic. In the real scenario, we would get them from the BE. I have modeled this `OnboardingFlow` as a protocol witness to be able to easily switch between a `live` and a `development` implementation of it.
* I have used async/await for the asynchronous tasks of getting the steps and building the view controllers
* I have annotated with `@MainActor` the `handle` method on the `Navigator` and also the `viewController()` closure on `Screen` to ensure that they are executed on the main thread.
* I have added the snapshot testing framework from PointFree in order to give a try to snapshot test the navigation. In the tests target there is a test case for that.
* The extensions on `ViewContext` provides us with the ability of asking for: `topMostViewController`, `tabBarController` and `currentNavigationController`