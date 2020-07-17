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

The coloured strip at the top is called an `AppBar`. Let's give our `Scaffold` an `AppBar` with a meaningful `title`:

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

We're ready to add the actual content!
