# ACS UPB Mobile - Flutter workshop

This workshop is meant to help you get started with Flutter and contributing to the **ACS UPB Mobile** app. We will be using the app as reference throughout the workshop, so please make sure you follow the steps described [here](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/README.md#building-from-source-with-android-studio) to build and run it.

**Table of contents**
* [Getting started with Flutter](#getting-started-with-flutter)
  + [What **is** Flutter?](#what---is---flutter-)
  + [Create a new Flutter application](#create-a-new-flutter-application)
  + [Change it up](#change-it-up)
  + [Create the layout](#create-the-layout)
    - [AppBar](#appbar)
    - [Card](#card)
  + [Add the content](#add-the-content)
    - [Import a package](#import-a-package)
    - [Use the package](#use-the-package)
    - [Check orientation](#check-orientation)
  + [Make it interactive](#make-it-interactive)
    - [Start with the header](#start-with-the-header)
    - [Build the data rows](#build-the-data-rows)
    - [Update the datamap](#update-the-datamap)
  + [Add another page](#add-another-page)
    - [New home page](#new-home-page)
    - [Navigating between pages](#navigating-between-pages)
    - [Passing data](#passing-data)
  + [Test it](#test-it)

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

Subsequent sections will link to a tag in this repository which has the code you should end up with at the end of that section. You can use them to skip a section or cross-check your code if you have a problem. The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/new_app).

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

### Create the layout

We will now attempt to create a layout similar to the grading view in **ACS UPB Mobile**:

<img src=screenshots/grading_view.png height=500>

#### AppBar

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

#### Card

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

The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/basic_layout). You should now have an app that looks like this:

<img src=screenshots/layout.png height=500>

### Add the content

We're ready to add the actual content!

#### Import a package

Even though Flutter is a fairly new technology, the community is very active, and because it is open source there are countless available resources online that you can use. A good rule of thumb is, *don't try to reinvent the wheel*. Before starting to work on something, check if someone has done it before. You might find a useful package that you can add to the app, or maybe even a sample app that you can copy and modify for your needs.

One such example is, in our case, displaying some data in the form of a pie chart in Flutter. The [pie_chart](https://pub.dev/packages/pie_chart) package is just a mere Google Search away. Get used to the resources offered by pub.dev - any package published will have documentation, statistics, instructions and an example usage. And the best part of open source? If the API doesn't quite suit your requirements but you'd like to use parts of a package, you can pretty much always just copy and modify the parts of their code you're interested in. To be safe, you can check the LICENSE file of the project, but generally all Dart packages have either an MIT or BSD license.

---

***Life pro tip:*** If you do fiddle with someone's package, for instance to add functionality or expose some fields, it might be a good idea to even contribute to that package itself. E-mail the owner to tell them what you'd like to do, and if they say it's okay, submit a PR! Open source points on your résumé are always useful.

---

Back to our app - all we need to do to use this package is to add it to our `pubspec.yaml` file under `dependencies`:

```yaml
dependencies:
  pie_chart: <latest version>
```

You can see the latest version in the package's name. Specifying it is not mandatory, but it is recommended. You will often see a caret next to the version specified in pubspec files (e.g. `pie_chart: ^3.1.1`), symbolising "version 3.1.1 or the newest compatible version", or ">=3.1.1 <4.0.0", since a new major version usually implies breaking changes.

Android Studio will prompt you to run `flutter pub get` to update the dependencies of your project. Do so.

#### Use the package

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

#### Check orientation

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

The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/content). The app should now look like this:

<img src=screenshots/content.png height=500>

### Make it interactive

We want the user to be able to change the values of the items in the datamap, so we'll make an editable table containing two columns: *Name* (not editable) and *Value* (editable).

#### Start with the header

Let's add a header just under the card, with the *Name* label taking up 3/4 of the horizontal space, and the *Value* label the other 1/4 (*hint*: the wigets you need are `Row`, `Expanded` and `Text`). We should give it a padding as well - the standard 8 pixels on each side looks good.

The `Text` widget takes a `style` argument, which allows us to control the colour, size, font and weight of the text. You could manually set these properties, but for consistency in an app, it is generally recommended to use pre-defined styles from the app's theme. You can define these globally in the same place where you defined the primary and secondary colours earlier. For our header, we could use the `headline6` text style, which you can obtain by calling `Theme.of(context).textTheme.headline6`, similar to how you used `MediaQuery` to get the screen size before. This is particularly important with apps with a customizable theme, like **ACS UPB Mobile** which has a dark mode and a light mode.

It should now look like this:

<img src=screenshots/header.png><br>

<details>
  <summary>Spoiler - solution</summary>

  ```dart
  ListView(
    children: [
      Card(child: PieChart(dataMap: dataMap)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "Name",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: Text(
                "Value",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    ],
  )
  ```

</details><br>

Keep in mind that, since **ACS UPB Mobile** is localized (works in both English and Romanian), you will never have to type string literals in the code itself, since everything needs to be defined in both languages in the localization files. The [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl) Android Studio plugin generates localization code automatically, so make sure you have it installed. Say we need to define the strings for "Name" and "Value" - we would need to define them in [intl_en.arb](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/l10n/intl_en.arb) and [intl_ro.arb](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/l10n/intl_ro.arb) (the plugin fires automatically when we save an .arb file), and then use them in the code as `S.of(context).name` and `S.of(context).value`.

#### Build the data rows

Now, we need to add a row for each entry in the datamap. To keep things clean, create a method (`List<Widget> buildTextFields(Map<String, double> dataMap, BuildContext context)`) that generates a row with two `TextFormField` widgets for each (key, value) pair in the map. We only want to modify the values, so make the field that corresponds to the key (the name) `readOnly`. The value field should only accept numerical values (*hint*: check the `keyboardType` attribute).

For a nicer look, you can add some padding to these rows and some spacing between the columns (don't forget the header). Padding between list items can be added using a `SizedBox` instead of a `Padding` widget, if you want to avoid unnecessary nesting.

<details>
  <summary>Spoiler - possible solution</summary>

  ```dart
  List<Widget> buildTextFields(
      Map<String, double> dataMap, BuildContext context) {
    return dataMap
        .map(
          (key, value) => MapEntry(
              key,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: key,
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: value.toString(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              )),
        )
        .values
        .toList();
  }
  ```

</details><br>

Concatenate the result to the end of the `ListView`'s children (`ListView(children: [...] + buildTextFields(dataMap, context))`) and you should now have a table that looks like this:

<img src=screenshots/table.png>

#### Update the datamap

You can now modify the values in the second column, but the datamap doesn't get updated. To update it, we should define the `TextFormField`'s `onChanged` callback. Add a `print` statement to make sure it gets called correctly.

```dart
TextFormField(
  initialValue: value.toString(),
  keyboardType:
      TextInputType.numberWithOptions(decimal: true),
  onChanged: (newString) {
    double newValue = double.tryParse(newString) ?? 0.0;
    dataMap[key] = newValue;
    print(key + ': ' + newValue.toString());
  },
)
```
Now, if we look at the console we can see it does get called when a value is changed, but the pie chart remains unchanged. Can you guess why that is?

<details>
  <summary>Spoiler - answer</summary>

  Our widget is stateless. It is built once and never gets updated, meaning that if the datamap changes afterwards, the widget won't be rebuilt. We need a stateful widget for this.

</details><br>

---

**IntelliSense tip #4: stateless to stateful**

Android Studio to the rescue again! It's easy to convert a stateless widget into a stateful one - just *Alt*+*Enter* on the name of the widget!

<img src=screenshots/convert.png>

---

Alongside the `build` method, which is called every time the widget is updated, stateful widgets have an `initState` method that is called on the first build. Let's make the `dataMap` a class attribute and initialize it in `initState`:

```dart
class _MainPageState extends State<MainPage> {
  Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();

    dataMap = new Map();
    dataMap.putIfAbsent("Flutter", () => 5);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);
  }

  @override
  Widget build(BuildContext context) {
    ...
  }
```

When we change the state (in our case, by updating the data map), we need to notify the framework to process the change. We do this by making the change in a function that is passed to `setState`. The last thing we need to do for our pie chart to be interactive is to make a slight modification to the `onChanged` callback of our text fields:

```dart
onChanged: (newString) {
  double newValue = double.tryParse(newString) ?? 0.0;
  setState(() {
    dataMap[key] = newValue;
  });
  print(key + ': ' + newValue.toString());
}
```

We can now change the value of the items in the data map and watch the pie chart update as we do that. The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/interactive). The app should now look like this and be interactive:

<img src=screenshots/interactive.png height=500>

### Add another page

Now, what do we do if we want to have another page? And more importantly, what do we do if we want to share data between those pages?

Say we want our home page to contain just the chart, centered and with the legend placed at the top. On the right side of the scaffold, we'd have an edit button that takes us to the page we've already build.

#### New home page

Let's rename our stateful widget to `EditPage` and create a new `MainPage` widget with the characteristics above. Leave out the edit button for now. You can put each of them in their own file to avoid having a very large `main.dart` file. You can also change the title on the app bar for each of them accordingly ('View chart'/'Edit chart').

<details>
  <summary>Spoiler - solution</summary>

  ```dart
  class MainPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      Map<String, double> dataMap = new Map();
      dataMap.putIfAbsent("Flutter", () => 5);
      dataMap.putIfAbsent("React", () => 3);
      dataMap.putIfAbsent("Xamarin", () => 2);
      dataMap.putIfAbsent("Ionic", () => 2);

      return Scaffold(
        appBar: AppBar(
          title: Text('View chart'),
        ),
        body: PieChart(
          dataMap: dataMap,
          legendPosition: LegendPosition.top,
        ),
      );
    }
  }
  ```

</details>

#### Navigating between pages

Now, we need to add the edit button to the scaffold's app bar. This is done by adding an `IconButton` as an `action` to the `AppBar`. The `onPressed` callback on this button uses `Navigator` to open an `EditPage`.

```dart
AppBar(
  title: Text('View chart'),
  actions: [
    IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditPage())),
    )
  ],
)
```

The pages in an app act like a stack - if we `push` a new page, the user can navigate back to the previous page in the stack by pressing the back button (equivalent to `pop`ping the stack). We have full control of the stack with various `Navigator` methods - for instance, if we want to replace the current page, we can use `pushReplacement`.

Alternatively, a cleaner way to deal with navigation is through *named routes*. Replace `home: MainPage()` in the `MaterialApp` with:

```dart
routes: {
  '/': (context) => MainPage(),
  '/edit': (context) => EditPage(),
}
```

The default route when the app opens is '/', but you can specify a different one using `initialRoute`, should you need to. You can now open the edit page by simply calling:
```dart
Navigator.of(context).pushNamed('/edit')
```

An interesting effect of using named routes is that they are accessible through the URL in the web version. Try running the app on the web, by selecting "Chrome (web)" from the device dropdown. You will notice that, if the URL is, for instance, 'http://localhost:52755/#/', you can access 'http://localhost:52755/#/edit' to get to the edit page.

#### Passing data

Right now, each page uses a separate data map. If we used `MaterialPageRoute` and built the `EditPage` instance in the `MainPage` to navigate, we could technically pass the data map as a parameter to `EditPage`'s constructor. However, changes made on the edit page would still not be visible on the main page, since we couldn't notify the main page of the changes. There are multiple ways to handle this, but **ACS UPB Mobile** uses the [provider](https://pub.dev/packages/provider) package.

`Provider` is a dependency injection framework which can be used to manage state in a Flutter application. `Provider`s offer an easy way to encapsulate state and share it with a branch of the widget tree. It achieves that by being defined as the parent of that branch.

Install the [provider](https://pub.dev/packages/provider) package and create a new source file called `data_provider.dart` in the `lib/` folder. Define the `DataProvider` class here, like this:

```dart
class DataProvider with ChangeNotifier {
  Map<String, double> _dataMap;

  DataProvider() {
    _dataMap = new Map();
    _dataMap.putIfAbsent("Flutter", () => 5);
    _dataMap.putIfAbsent("React", () => 3);
    _dataMap.putIfAbsent("Xamarin", () => 2);
    _dataMap.putIfAbsent("Ionic", () => 2);
  }

  Map<String, double> get dataMap => _dataMap;

  set dataMap(Map<String, double> newDataMap) {
    _dataMap = newDataMap;
    notifyListeners();
  }
}
```

It initialized the data map that we know in the constructor, and has a custom getter and setter - with the setter calling `notifyListeners()` to notify any widget that is using this `Provider` about the change. Now add it to the root of the application:

```dart
void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => DataProvider(), child: MyApp()));
}
```

There are different types of `Provider`s, but `ChangeNotifierProvider` is the right one for our needs. Now, to fetch this data map from the provider in both of our pages, we simply need to call:

```dart
Provider.of<DataProvider>(context).dataMap;
```

The `<DataProvider>` type specification is optional because we only have one `Provider` as the parent, but becomes necessary when there are multiple `Provider`s in the tree. Finally, we should add a 'Save' button to the edit page which registers the changes with our `DataProvider`:

```dart
class _EditPageState extends State<EditPage> {
  Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
    dataMap = Provider.of<DataProvider>(context, listen: false).dataMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit chart'),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              Provider.of<DataProvider>(context, listen: false).dataMap =
                  dataMap;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ...
  }

  ...
}
```

The `listen: false` attribute tells the provider that the particular context in which it is used does not need to listen for changes. The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/pages). If you did everything correctly, the pie chart on the main page should now be updated when you press 'Save' on the edit page, and the app should look like this:

<img src=screenshots/main.png height=500> <img src=screenshots/edit.png height=500>

---

**BLoC**

**ACS UPB Mobile** uses a variation of the **BLoC** (Business Logic Component) design pattern used in Flutter development. This variant utilizes `Provider`s to avoid boilerplate code.

With BLoC, every page in the app will have three components:

<img src=screenshots/bloc.png height=100><br>

- the *UI/Flutter layer*, also called the *view*, which acts as a middleman between the user and the BLoC layer (in this workshop, the `MainPage` and `EditPage`)
- the *BLoC layer*, which we also refer to as the *Provider* or *service*, contains the actual business logic and communicates with the database (in this workshop, the `DataProvider`)
- the *data layer* or the data *model* contains simple data classes which represent the data that is to be displayed in the UI, and is provided by the BLoC (in this workshop, we don't need a custom class because we simply use a `Map<String, double>` as our model)
---

### Test it

Now we have the functionality we wanted, but we've only tested it manually. Let's add some automated testing in the `test/widget_test.dart` file.

The simplest thing to test is the existence of the legend labels for the pie chart:

```dart
testWidgets('Test names', (WidgetTester tester) async {
  await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => DataProvider(), child: MyApp()));

  expect(find.text('Flutter'), findsOneWidget);
  expect(find.text('React'), findsOneWidget);
  expect(find.text('Xamarin'), findsOneWidget);
  expect(find.text('Ionic'), findsOneWidget);
});
```

Note that, when pumping the app, you need to pump it with the appropriate `Provider`. Another thing we can test easily is navigation:

```dart
testWidgets('Test navigation', (WidgetTester tester) async {
  await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => DataProvider(), child: MyApp()));

  expect(find.byType(MainPage), findsOneWidget);
  expect(find.byType(EditPage), findsNothing);

  await tester.tap(find.byIcon(Icons.edit));
  await tester.pumpAndSettle();

  expect(find.byType(MainPage), findsNothing);
  expect(find.byType(EditPage), findsOneWidget);

  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();

  expect(find.byType(MainPage), findsOneWidget);
  expect(find.byType(EditPage), findsNothing);
});
```

Remember that, after actions like tapping certain buttons, you need to wait for the animations to finish by calling `await tester.pumpAndSettle()`.

Now, right-click `widget_test.dart` and select *Run > tests in widget_test...* to make sure the tests work. If you don't see that option, you may need to *Edit configurations* and add a Flutter Test configuration for the `test/` folder.

To test that the most important feature - editing the chart data - actually works, we first need to initialise the `DataProvider` and test the initial values:

```dart
DataProvider provider = DataProvider();
Map<String, double> dataMap = provider.dataMap;

expect(dataMap['Flutter'], equals(5));
expect(dataMap['React'], equals(3));
expect(dataMap['Xamarin'], equals(2));
expect(dataMap['Ionic'], equals(2));
```

Then , we pump the app, open the edit page, change the value in one of the fields and press 'Save':

```dart
await tester.pumpWidget(
    ChangeNotifierProvider(create: (context) => provider, child: MyApp()));

await tester.tap(find.byIcon(Icons.edit));
await tester.pumpAndSettle();

Finder flutterValueField = find.widgetWithText(TextFormField, '5.0');
await tester.enterText(flutterValueField, '10');

await tester.tap(find.text('Save'));
await tester.pumpAndSettle();
```

Finally, we test the new values:

```dart
expect(dataMap['Flutter'], equals(10));
expect(dataMap['React'], equals(3));
expect(dataMap['Xamarin'], equals(2));
expect(dataMap['Ionic'], equals(2));
```

Run this last test as well to make sure everything works as expected. The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/testing).

---

**GitHub Actions**

**ACS UPB Mobile** uses GitHub Actions for continuous integration & continuous deployment. What this means is, with every push to the repository, the tests are run in a virtual machine and the last commit pushed will be marked with a checkmark if the tests pass and an x if at least one test fails. If a new tag is added and the tests pass, the new version is automatically deployed onto the website and as an apk on GitHub.

Ideally, every new feature should have its own tests or at least be added to the [integration test](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/test/integration_test.dart), which runs on both orientations and multiple screen sizes and navigates to all pages in the app to make sure there are no obvious errors like overflows.

---
