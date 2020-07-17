# ACS UPB Mobile - Flutter workshop

This workshop is meant to help you get started with Flutter and contributing to the **ACS UPB Mobile** app. We will be using the app as reference throughout the workshop, so please make sure you follow the steps described [here](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/README.md#building-from-source-with-android-studio) to build and run it.

## Getting started with Flutter

### What **is** Flutter?

First of all, let's talk a bit about Flutter. It is a cross-platform framework developed by Google, meaning it allows us to use the same codebase for an application that can run on multiple operating systems (iOS, Android, Fuchsia, MacOS etc.) and the web. Flutter uses **Dart** as its main programming language. The Dart syntax is clean and looks similar to Java, while sharing certain useful features with languages like JavaScript and C# (for example, the `async`/`await` combo, with `Future`s in Dart being similar to `Promise`s and `Task`s in JavaScript and C# respectively).

In order to familiarize yourself with Dart, please go through this simple, 20-minute [codelab](https://codelabs.developers.google.com/codelabs/from-java-to-dart/) before proceeding with this workshop.

### Create a new Flutter application

Open Android Studio and create a new Flutter application. The sample app is very well explained through comments and it will help you understand the absolute basics of using Flutter. Analyze the folder structure and carefully read the following files:
- `lib/main.dart`, which is the application itself
- `pubspec.yaml`, which contains metadata necessary for building the application (similar to `build.gradle` in Android or `Info.plist` in iOS)
- `test/widget_test.dart`, a simple test for the sample application

Run the test to make sure it works by right-clicking `widget_test.dart` and selecting `Run`. Run the application and play around with the code in `main.dart`, while taking advantage of the Hot Reload feature, which allows you to load changes in the code quickly into an already running app, without you needing to restart/reinstall it. For example, change the text and colours, reposition the widgets, make the counter count backwards (make sure you fix the test accordingly for that last one) etc.

---
**Optimizing your workspace**

On the left-hand Project panel in Android Studio, make sure you have the *Project* view open in the drop-down (not *Android*).

You can make the emulator window display on top of the IDE by going to Extended controls (...) in the emulator and enabling 'Emulator always on top' in Settings. This is especially useful when playing around with the UI in Flutter, as you will see the application update every time you save, thanks to the Hot Reload feature.

<img src=screenshots/android_studio.png>

---

### Change it up

Now that we have the basics covered, it's time to code. We'll start by butchering the sample app - first, let's change the colours. Remove the `primarySwatch` attribute from `ThemeData` and set `primaryColor` and `accentColor` to the ones in **ACS UPB Mobile** (*hint*: you can find them [here](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/main.dart)). Note what changes in the app with each attribute.

Next, remove `MyHomePage` and `MyHomePageState` entirely. Create a new widget class called `MainPage` to replace it. In Flutter, widgets can be *stateless* or *stateful*. If it can change - for example, when a user interacts with it - it's stateful. Let's make ours a `StatelessWidget` for now, which returns a simple `Scaffold`. Congratulations, you now have an empty Flutter app!

---
**IntelliSense tip #1: missing overrides**

Take advantage of useful Android Studio features. For example, you can press *Alt*+*Enter* and *Create missing overrides* to easily define the `build` method of a new widget.

<img src=screenshots/overrides.png>

---

A Flutter app is essentially a *widget tree*. Most widgets don't need to be leaves in the tree, therefore they have a `child` or `children` attribute which allows us to nest other widgets within them. This is somehow similar to *nested tags* in HTML, in that parent widgets can control the appearance and properties of child widgets.

<img src=screenshots/flutter_html.png>

The most important method in a Widget is the `build` method, which describes the part of the UI represented by that widget. This method takes a `BuildContext` parameter, which has information about the location in the tree where the widget builds.

#### Create the layout

We will now attempt to create a layout similar to the grading view in **ACS UPB Mobile**:

<img src=screenshots/grading_view.png height=500>

##### AppBar

The coloured strip at the top is called an `AppBar`. Let's give our `Scaffold` an `AppBar` with a meaningful `title`.

```dart
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A meaningful title'),
      ),
    );
  }
}
```

Note the comma at the end, where the `title` attribute is defined - since Flutter widgets have a nested appearance, this optional comma after the last attribute in a widget helps with formatting (*Ctrl*+*Alt*+*L* in Android Studio to reformat the code).

Keep in mind that **ACS UPB Mobile** uses a [custom scaffold](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/widgets/scaffold.dart) for consistency throughout pages in the app, meaning you will never need to define the `AppBar` yourself. Whenever you need to create a new page, you will start with an `AppScaffold` instead of a standard `Scaffold`.

##### Card

The styled, elevated container that holds the pie chart in the screenshot above is called a `Card`. Let's try to create an empty card which takes up a third of the available space.

First, for the `Card` to actually be visible in the app, it needs to hold *something*. We won't add the pie chart just yet, but we can use a placeholder for now. The standard way of defining an 'empty' widget is through a `Container` with no attributes set, like this:

```dart
Scaffold(
  appBar: AppBar(
    title: Text('A meaningful title'),
  ),
  body: Card(
    child: Container(),
  ),
)
```

If you save and look closely at the app, you can see the elevated margins of the card which now takes up the whole available space of the scaffold. Now, how do we make it only take up a third of the space? The naïve way would be to directly give it a specific size - the `Container` widget takes a `height` attribute, which we can set like this:

```dart
Card(
  child: Container(
    height: MediaQuery.of(context).size.height / 3,
  ),
)
```

Wait, what? What did we just do there? It's simple, let's take it step by step. You already know that the context defines the current location in the widget tree. The `.of(context)` call, by design, is meant to return an instance of the widget it's used on by going up the tree of the context that is passed. In our case, it returns an instance of `MediaQuery`, which holds information about the size of the current window.

It is important to observe that this call returns the height of the screen itself (taking orientation into account). In other words, the card now takes up a third of the *entire screen*, not the available space in the scaffold. If we want the latter behaviour, we need to substract the height of the AppBar as follows:

```dart
Widget build(BuildContext context) {
  var appBar = AppBar(
    title: Text('A meaningful title'),
  );

  return Scaffold(
    appBar: appBar,
    body: Card(
      child: Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height) / 3,
      ),
    ),
  );
}
```

If this seems complicated, that's because it is. There is a better way to obtain this behaviour, by using a `Column` flex widget.

The two basic layout widgets in Flutter are `Row`s and `Columns`, which take  a list of widgets and position them accordingly. Orientation and alignment are defined by the *main axis* and the *cross axis*, as such:

<img src=https://flutter.dev/assets/ui/layout/row-diagram-ad51795e19e3e1d412815b287c9caa694ad357892e3ab8b3ef1da0c4c6e011db.png> <img src=https://flutter.dev/assets/ui/layout/column-diagram-4e2ce8e33c32a09d090280fb7b2925baaf58f6de7876a551c207ab904e2fafc6.png>

If we see our desired layout as a column, we want a card that takes up 1/3 of the available space, followed by an empty container that takes up the remaining 2/3. We can achieve this by using the `Expanded` widget's `flex` property like this:

```dart
Scaffold(
  appBar: AppBar(
    title: Text('A meaningful title'),
  ),
  body: Column(
    children: [
      Expanded(
        flex: 1,
        child: Card(child: Container()),
      ),
      Expanded(
        flex: 2,
        child: Container(),
      )
    ],
  ),
)
```

The flex factor is `1` by default, so specifying it for the card is optional. `Expanded` widgets take up all of the available space, and the `flex` attribute dictates how the space is distributed between the siblings.

---

**IntelliSense tip #2: wrapping widgets**

We had to wrap the `Card` in an `Expanded` widget, which in turn was wrapped by a `Column` widget. This happens frequently with Flutter development, and the larger the widget tree becomes, the harder it is sometimes to find the right place to add the appropriate brackets. Android Studio makes it easy - just *Alt*+*Enter* on the name of the widget you'd like to wrap, and select *Wrap with widget*!

<img src=screenshots/wrap.png>

---

If we look at the app, the layout is now similar to the grading view's background, except for one detail - there should be some spacing between the card and the edges of the screen. Spacing around a widget is called `Padding`. Let's use *IntelliSense* to quickly wrap the entire `Column` in a `Padding` of 8 pixels!

It should've automatically set the `padding` property to `EdgeInsets.all(8.0)`. This means that we want a padding of 8 pixels on each side of the wrapped widget. We can use `EdgeInsets` to define exactly what kind of padding we want, for example `EdgeInsets.only(left: 8.0, right: 4.0)` to specify a value for each side and omit sides we don't need a padding on, `EdgeInsets.symmetric(vertical: 2.0)` if we want the same padding on corresponding sides, or `EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0)` to specify the padding for each side without needing named parameters (the order is left-top-right-bottom, LTRB).

You should now have an app that looks like this:

<img src=screenshots/layout.png height=500>

#### Add the content

We're ready to add the actual content!

##### Import a package

Even though Flutter is a fairly new technology, the community is very active, and because it is open source there are countless available resources online that you can use. A good rule of thumb is, *don't try to reinvent the wheel*. Before starting to work on something, check if someone has done it before. You might find a useful package that you can add to the app, or maybe even a sample app that you can copy and modify for your needs.

One such example is, in our case, displaying some data in the form of a pie chart in Flutter. The [pie_chart](https://pub.dev/packages/pie_chart) package is just a mere Google Search away. Get used to the resources offered by pub.dev - any package published will have documentation, statistics, instructions and an example usage. And the best part of open source? If the API doesn't quite suit your requirements but you'd like to use parts of a package, you can pretty much always just copy and modify the parts of their code you're interested in. To be safe, you can check the LICENSE file of the project, but generally all Dart packages have either an MIT or BSD license.

---

***Life pro tip:*** If you do fiddle with someone's package, for instance to add functionality or expose some fields, it might be a good idea to even contribute to that package itself. E-mail the owner to tell them what you'd like to do, and if they say it's okay, submit a PR! Open source points on your résumé are always useful.

---

Back to our app - all we need to do to use this package is to add it to our `pubspec.yaml` file under `dependencies`:

```
dependencies:
  pie_chart: <latest version>
```

You can see the latest version in the package's name. Specifying it is not mandatory, but it is recommended. You will often see a caret next to the version specified in pubspec files (e.g. `pie_chart: ^3.1.1`), symbolising "version 3.1.1 or the newest compatible version", or ">=3.1.1 <4.0.0", since a new major version usually implies breaking changes.

Android Studio will prompt you to run `flutter pub get` to update the dependencies of your project. Do so.

##### Use the package

Read the documentation of `pie_chart` and use the simple example to place a pie chart in our `Card`.

<details>
  <summary>Spoiler - solution</summary>

  ```dart
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Flutter", () => 5);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);

    return Scaffold(
      appBar: AppBar(
        title: Text('A meaningful title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(child: PieChart(dataMap: dataMap,)),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
  ```

</details><br>

Normally, we shouldn't do complex operations like populating a dataset in the build method, because *it is called every time the page is reloaded or something changes*. This is particularly important for stateful widgets, which are rebuilt often.

##### Check orientation

Hot Reload and look at the app. Now we have the pie chart and it looks alright! However, check what happens if you rotate the device. You will most likely see an overflow. Can you tell why it happens?

<details>
  <summary>Spoiler - answer</summary>

  The card's height is a third of the available height - which, in landscape mode, is the screen's width. This isn't enough to fit the entire content of the pie chart, and the package doesn't know how to deal with not having enough space.

</details><br>

Note that the ugly overflow warning is only visible in debug mode, for the developer to notice. In release mode, the user simply won't see the part of the widget that overflowed.

---

**Build modes**

Flutter offers three build modes:
- *debug mode*, used during development, allows the usage of IDE debugging tools and hot reload
- *profile mode* is used when you want to analyze performance
- *release mode* is the version seen by the end user

The performance in debug mode is almost always worse than the other two modes. Release mode cannot be used on an emulator, but if you want to take nice screenshots you can disable the debug banner from the *Flutter Inspector* tab found on the right edge of Android Studio.

<img src=screenshots/banner.png>

---

Layout issues can usually be solved by either defining the layout differently (we've already seen that the same thing can be done in multiple ways in Flutter) or using a different layout for landscape and portrait with an [`OrientationBuilder`](https://api.flutter.dev/flutter/widgets/OrientationBuilder-class.html).

Let's change the layout yet again to fix the overflow. The easiest way is to replace the `Column` with a `ListView`, which is essentially a scrollable column. We can simply replace the word 'Column' with 'ListView' and the app will work... but if we look at the console, we will see an exception:

<img src=screenshots/console.png>

Flutter errors are very verbose and, more often than not, will offer the exact solution to the problem and an explanation. In our case, it tells us that an `Expanded` widget can only be within a `Flex` widget (usually a `Row` or `Column` widget). We can just remove the `Expanded` widgets now and let the pie chart package control the size of the card on its own.

---

**IntelliSense tip #3: removing widgets**

Similar to wrapping widgets, we can also remove them easily from the tree using Android Studio. Press *Alt* + *Enter* while the cursor is on the name of any widget that has exactly one child, and you will get the option to remove it:

<img src=screenshots/remove.png>

---

The app should now look like this:

<img src=screenshots/content.png height=500>
