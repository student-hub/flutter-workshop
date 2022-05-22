# ACS UPB Mobile - Flutter workshop

This workshop is meant to help you get started with Flutter and contributing to the **ACS UPB Mobile** app. We will be using the app as reference throughout the workshop, so please make sure you follow the steps described [here](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/README.md#building-from-source-with-android-studio) to build and run it. The estimated time for completing the workshop is roughly 4h, but it can take longer if you follow the additional resource links. If you feel the time estimates are inaccurate or want to fill in the missing estimates, feel free to open a PR on this repo directly to fix them. 

- [Start contributing](#start-contributing)
- [Get started with Flutter](#get-started-with-flutter)
  * [What **is** Flutter?](#what-is-flutter)
  * [Create a new Flutter application - 10 mins](#create-a-new-flutter-application---10-mins)
  * [Change it up - 10 mins](#change-it-up---10-mins)
  * [Create the layout - 25 mins](#create-the-layout---25-mins)
    + [AppBar](#appbar)
    + [Card](#card)
  * [Add the content - 12 mins](#add-the-content---12-mins)
    + [Import a package - 5 mins](#import-a-package---5-mins)
    + [Use the package - 5 mins](#use-the-package---5-mins)
    + [Check orientation - 2 mins](#check-orientation---2-mins)
  * [Make it interactive - 40 mins](#make-it-interactive---40-mins)
    + [Start with the header - 10 mins](#start-with-the-header---10-mins)
    + [Build the data rows - 20 mins](#build-the-data-rows---20-mins)
    + [Update the datamap - 10 mins](#update-the-datamap---10-mins)
  * [Add another page - 45 mins](#add-another-page---45-mins)
    + [New home page - 13 mins](#new-home-page---13-mins)
    + [Navigating between pages - 7 mins](#navigating-between-pages---7-mins)
    + [Passing data - 25 mins](#passing-data---25-mins)
  * [Test it - 8 mins](#test-it---8-mins)
  * [Make data persistent - 20 mins](#make-data-persistent---20-mins)
    + [Enable the plugin - 5 mins](#enable-the-plugin---5-mins)
    + [Handle the data - 12 mins](#handle-the-data---12-mins)
    + [Fix the tests - 3 mins](#fix-the-tests---3-mins)
  * [Add improvements](#add-improvements)
- [Get started with Firebase](#get-started-with-firebase)
  * [Add Firebase to your app(s)](#add-firebase-to-your-app-s-)
    + [Enable the FlutterFire plugins](#enable-the-flutterfire-plugins)
    + [Add Firebase to Android](#add-firebase-to-android)
    + [Add Firebase to iOS](#add-firebase-to-ios)
    + [Add Firebase to Web and host the app](#add-firebase-to-web-and-host-the-app)
  * [Use Firestore in the app](#use-firestore-in-the-app)
    + [Create the database](#create-the-database)
    + [Update the provider](#update-the-provider)
    + [Update the layout](#update-the-layout)
    + [Check permissions](#check-permissions)

## Start contributing

If you're not familiar with git, consider learning the basics from one of the many resources available online. We recommend [GitHub's resources](https://try.github.io/), particularly the [Git-It](https://github.com/jlord/git-it-electron) hands-on tutorial.

In order to start contributing, simply follow these 10 steps:

1. Please make sure you've read through the [CONTRIBUTING.md](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/CONTRIBUTING.md) file.
2. Fork the [ACS UPB Mobile](https://github.com/acs-upb-mobile/acs-upb-mobile) repository.
3. Clone the fork onto your system (`git clone`) and open it as an Android Studio project.
4. Don't forget to run `flutter pub get` to update the dependencies.

|:question:|Something isn't working, I see a bunch of errors! What do I do?|
|:--------:|:--------------------------------------------------------------|
|  :bulb:  |Did you skip that part in the first paragraph about following the [Prerequisites](https://github.com/student-hub/acs-upb-mobile#prerequisites) section before moving forward? Make sure you have everything installed, and **the correct Flutter version checked out**. Finally, you can try the troubleshooting steps [here](https://github.com/student-hub/acs-upb-mobile/blob/master/README.md#not-working).|


5. Create a new branch by clicking on *Git: master* on the bottom right border in Android Studio and selecting *New Branch*. Its name should succinctly describe the modification/feature you are trying to add, so in this case something like `update_contributors` would be appropriate.
6. Add yourself to the list of contributors in the `README.md` file. The recommended format is: `[FirstName LastName](link_to_github_profile)`.
7. Commit and push the changes to the forked repository (*Ctrl*+*K* for committing, *Ctrl*+*Shift*+*K* for pushing in Android Studio).
8. Create a pull request either from GitHub (you will see a message prompting you to create a PR when you open the forked repository) or Android Studio (VCS > Git > Create Pull Request). Make sure the PR points from the branch you created to the master branch in the acs-upb-mobile repo. Give it a meaningful name (refer to [How to Write a Git Commit Message](https://cbea.ms/git-commit/)).
9. Wait for the PR to be approved.
10. Pat yourself on the back, you've made your first steps as an open source contributor!

Once in a while you should sync your fork's master with the upstream (the original repo) master. To do this:
1. In the repo on your machine add a new remote that points to **acs-upb-mobile/master** using the command: `git remote add upstream https://github.com/acs-upb-mobile/acs-upb-mobile.git`.
2. Fetch the data from the upstream repo: `git fetch upstream`.
3. Checkout your fork's `master` branch: `git checkout master`.
4. Merge `upstream` into your fork's `master`: `git merge upstream/master`. This may produce conflicts, unfortunately. To fix them, open the *VCS* menu in Android Studio, select *Git* and *Resolve conflicts*.
5. Push `master` to save the sync to GitHub either by using the Android Studio GUI or by calling `git push origin/master`.

## Get started with Flutter

### What **is** Flutter?

First of all, let's talk a bit about Flutter. It is a cross-platform framework developed by Google, meaning it allows us to use the same codebase for an application that can run on multiple operating systems (iOS, Android, Fuchsia, MacOS etc.) and the web. Flutter uses **Dart** as its main programming language. The Dart syntax is clean and looks similar to Java, while sharing certain useful features with languages like JavaScript and C# (for example, the `async`/`await` combo, with `Future`s in Dart being similar to `Promise`s and `Task`s in JavaScript and C# respectively).

In order to familiarize yourself with Dart, please go through this simple, 20-minute [codelab](https://codelabs.developers.google.com/codelabs/from-java-to-dart/) before proceeding with this workshop.

### Create a new Flutter application - 10 mins

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

---

**Troubleshooting tips**

<img align="right" src=https://www.cipher-it.co.uk/wp-content/uploads/2017/11/ITCrow.jpg width=300>

If Android Studio doesn't work properly (it doesn't highlight the code and errors or make suggestions), it may be a good idea to restart it. Click `File` > `Invalidate Caches / Restart` and hope for the best.

If the app doesn't work as expected, try restarting it (Hot Reload doesn't work with major code/flow changes). If that still doesn't work and you think your code is correct, you can try re-building it from scratch (run `flutter clean` to delete build files and then try `flutter run` or pressing the play button/*Shift*+*F10* again).

Finally, if you see weird errors like classes not getting recognized, make sure Flutter is up to date (run `flutter upgrade`) and you're on the right branch (e.g. `flutter channel beta` if you're using the web version). Additionally, keep your dependencies up to date by running `flutter pub get`.

<br clear="right">

---

Subsequent sections will link to a tag in this repository which has the code you should end up with at the end of that section. You can use them to skip a section or cross-check your code if you have a problem. Keep in mind that the code snippets in this document are often not complete, since they are only meant to help you understand what you need to do. Avoid copy-pasting and try solving problems yourself before opening **Spoiler** sections or looking up the complete code in this repository.

The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/new_app).

### Change it up - 10 mins

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

### Create the layout - 25 mins

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

First, for the `Card` to actually be visible in the app, it needs to hold *something*. We won't add the pie chart just yet, but we can use a placeholder for now. The standard way of defining an 'empty' widget is through a `Container` or `SizedBox` with no attributes set, like this:

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

It is important to observe that this call returns the height of the screen itself (taking orientation into account). In other words, the card now takes up a third of the *entire screen*, not the available space in the scaffold. If we want the latter behaviour, we need to subtract the height of the AppBar as follows:

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

<img src=https://docs.flutter.dev/assets/images/docs/ui/layout/row-diagram.png> <img src=https://docs.flutter.dev/assets/images/docs/ui/layout/column-diagram.png>

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

### Add the content - 12 mins

We're ready to add the actual content!

#### Import a package - 5 mins

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

Android Studio will prompt you to run `flutter pub get` to update the dependencies of your project. Do so. If you see any issues, feel free to fall back to using 3.1.1 as the version - maybe since we've written this workshop, things have changed in the package and it doesn't work as it used to. For any package we use here, you can refer to the [pubspec.yaml](pubspec.yaml) file to see what version we've used when setting up the workshop.

#### Use the package - 5 mins

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

#### Check orientation - 2 mins

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

### Make it interactive - 40 mins

We want the user to be able to change the values of the items in the datamap, so we'll make an editable table containing two columns: *Name* (not editable) and *Value* (editable).

#### Start with the header - 10 mins

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

Keep in mind that, since **ACS UPB Mobile** is localized (works in both English and Romanian), you will never have to type string literals in the code itself, since everything needs to be defined in both languages in the localization files. The [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl) Android Studio plugin generates localization code automatically, so make sure you have it installed. Say we need to define the strings for "Name" and "Value" - we would need to define them in [intl_en.arb](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/l10n/intl_en.arb) and [intl_ro.arb](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/l10n/intl_ro.arb) (the plugin fires automatically when we save an .arb file), and then use them in the code as `S.current.name` and `S.current.value`.

#### Build the data rows - 20 mins

Now, we need to add a row for each entry in the datamap. To keep things clean, create a method (`List<Widget> buildTextFields(Map<String, double> dataMap, BuildContext context)`) in the `MainPage` class, that generates a row with two `TextFormField` widgets for each (key, value) pair in the map. We only want to modify the values, so make the field that corresponds to the key (the name) `readOnly`. The value field should only accept numerical values (*hint*: check the `keyboardType` attribute).

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

Concatenate the result to the end of the `ListView`'s children, before the comma (`ListView(children: [...] + buildTextFields(dataMap, context),)`) and you should now have a table that looks like this:

<img src=screenshots/table.png>

#### Update the datamap - 10 mins

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

Alongside the `build` method, which is called every time the widget is updated, stateful widgets have an `initState` method that is called on the first build. It's kind of like a constructor for the `State`. Let's make the `dataMap` a class attribute and initialize it in `initState` **instead of** `build`:

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

We can now change the value of the items in the data map and watch the pie chart update as we do that. Please keep in mind that the Hot Reload functionality does not work with major changes such as making a widget stateful. In order to run the app, rebuilding is necessary.
 
The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/interactive). The app should now look like this and be interactive:

<img src=screenshots/interactive.png height=500>

### Add another page - 45 mins

Now, what do we do if we want to have another page? And more importantly, what do we do if we want to share data between those pages?

Say we want our home page to contain just the chart, centered and with the legend placed at the top. On the right side of the scaffold, we'd have an edit button that takes us to the page we've already build.

#### New home page - 13 mins

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

#### Navigating between pages - 7 mins

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

#### Passing data - 25 mins

Right now, each page uses a separate data map. If we used `MaterialPageRoute` and built the `EditPage` instance in the `MainPage` to navigate, we could technically pass the data map as a parameter to `EditPage`'s constructor. However, changes made on the edit page would still not be visible on the main page, since we couldn't notify the main page of the changes. There are multiple ways to handle this, but **ACS UPB Mobile** uses the [provider](https://pub.dev/packages/provider) package.

`Provider` is a dependency injection framework which can be used to manage state in a Flutter application. `Provider`s offer an easy way to encapsulate state and share it with a branch of the widget tree. It achieves that by being defined as the parent of that branch.

Install the [provider](https://pub.dev/packages/provider) package (don't forget to run `flutter pub get`) and create a new source file called `data_provider.dart` in the `lib/` folder. Define the `DataProvider` class here, like this:

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

It initialized the data map that we know in the constructor, and has a custom getter and setter - with the setter calling `notifyListeners()` to notify any widget that is using this `Provider` about the change.

---

**IntelliSense tip #5: auto import**

When using a class for a first time in a file, you need to specify the library you want to import it from (be it part of the framework, a package, or your own codebase). You never need to actually remember the library because Android Studio gives you options to import when you start typing the class name, like with the `ChangeNotifier` we just used:

<img src=screenshots/import.png><br>

Just select the right option (look at the package name on the right side) and press *Tab* or *Enter* to confirm, and Android Studio will automatically add a line like `import 'package:flutter/foundation.dart';` to the beginning of the file. If you want to order the imports (alphabetically), you can press *Ctrl*+*Alt*+*O*.

Note that some framework components, like `ChangeNotifier`, can be found in multiple libraries. The one you choose to import won't affect the functionality, but we usually prefer to go with the narrow-scope libraries if possible. In this case, the rule of thumb would be:
*`foundation.dart` (Core Flutter framework) > `widgets.dart` (Flutter widgets framework) > `material.dart` (Android-like/Material Design components, used most often in **ACS UPB Mobile**) > `cupertino.dart` (iOS design components)*

---

Now add the provider you created to the root of the application:

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

The `listen: false` attribute tells the provider that the particular context in which it is used does not need to listen for changes. In our case, the Edit page does not need to listen for changes, but the main page does (`listen` is `true` by default, so we don't need to specify it when using the Provider there).
 
The code that corresponds to this section can be found [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/pages). If you did everything correctly, the pie chart on the main page should now be updated when you press 'Save' on the edit page. After rebuilding the app and running it, you should see something like this:

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

### Test it - 8 mins

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

### Make data persistent - 20 mins

Our app is now interactive and we can modify the chart data as we please. However, these modifications are not persistent - they are lost if we restart the app. The go-to way to persist data is by using a database (e.g. [SQLite](https://flutter.dev/docs/cookbook/persistence/sqlite), [Hive](https://medium.com/@alexawaikin/hive-for-flutter-fast-local-storage-database-made-with-dart-167ad63e2d1) or [Firebase](https://flutter.dev/docs/development/data-and-backend/firebase), see section [Get started with Firebase](#get-started-with-firebase)), but for very simple data such as ours, we can store key-value data on the disk using the [`shared_preferences`](https://pub.dev/packages/shared_preferences) plugin. It works by wrapping platform-specific persistent storage for simple data (`NSUserDefaults` on iOS and macOS, `SharedPreferences` on Android, etc.).

#### Enable the plugin - 5 mins

**ACS UPB Mobile** uses the [`preferences`](https://pub.dev/packages/preferences) plugin (which in turn depends on `shared_preferences`) to store simple data such as settings. Let's use this in our app as well, add the dependency to the `pubspec.yaml` file.

As per the package documentation, you need to call `PrefService.init()` before running the app. Change the main method to:
```dart
import 'package:preferences/preferences.dart';

void main() async {
  await PrefService.init();

  runApp(ChangeNotifierProvider(
      create: (context) => DataProvider(), child: MyApp()));
}
```
Because the `PrefService.init()` call is asynchronous, we need to use the `await` keyword to make sure it completes before the `runApp` call. The `await` keyword can only be used in asynchronous functions, hence why we need to mark `main` as `async`. If we don't use `await`, the `runApp` call would be made while the `PrefService.init()` method is still running.

---

**Asynchronous programming in Dart**

Dart makes asynchronous programming easier with `async`/`await` and `Future`s. Asynchronous operations let your program complete work while waiting for another operation to finish. This is particularly important when handling UI - the interface operations need to be handled on the main thread for the app to run smoothly, while more complex operations such as network calls and reading from files should be handled in a background thread.

***Key terms:***
- **synchronous operation**: A synchronous operation blocks other operations from executing until it completes.
- **asynchronous operation**: Once initiated, an asynchronous operation allows other operations to execute before it completes.
- **`async`**: You can use the `async` keyword before a function’s body to mark it as asynchronous.
- **`await`**: You can use the `await` keyword to get the completed result of an asynchronous expression. The await keyword only works within an async function.
-**future**: A future is an instance of the `Future` class. A future represents the result of an asynchronous operation, and can have two states: *uncompleted* or *completed*.

To understand asynchronous programming in Dart, consider completing [this 50-minute codelab](https://dart.dev/codelabs/async-await).

---

#### Handle the data - 12 mins

The `shared_preferences` plugin only allows for the following data types to be stored under a key: `bool`, `double`, `int`, `String`, `List<String>`. Because we'd like to store a `Map<String, double>`, we could store it as two string lists. Note that **you should never do this with more complex data**, as it adds the overhead of converting between collections, when the whole point of `Map`s in general is to be very fast.

To set the default values we've been using so far, add the following in your `main` function, after the initialization:

```dart
PrefService.setDefaultValues({
    'data_map_keys': ['Flutter', 'React', 'Xamarin', 'Ionic'],
    'data_map_values': ['5', '3', '2', '2'],
  });
```

If you try to run the app now, you will get an error. As is often the case with Flutter, the error tells you exactly what to do to fix it: you need to add `WidgetsFlutterBinding.ensureInitialized();` as the first line in your `main` function.

Now we need to change our `Provider` to use the new way to save data. This being very easy to do is one of the most important benefits of providers. First, instead of initialising the map, the constructor should now read it from the preferences:

```dart
DataProvider() {
    var keys = PrefService.get('data_map_keys');
    var values = PrefService.get('data_map_values');

    _dataMap = Map<String, double>.from(keys.asMap().map(
        (index, key) => MapEntry(key, double.tryParse(values[index] ?? 0))));
  }
```

Second, we need to update the custom setter:

```dart
set dataMap(Map<String, double> newDataMap) {
    _dataMap = newDataMap;

    PrefService.setStringList(
        'data_map_keys', List<String>.from(_dataMap.keys));
    PrefService.setStringList('data_map_values',
        List<String>.from(_dataMap.values.map((value) => value.toString())));

    notifyListeners();
  }
```

We need the `Iterable<T>.from` calls to convert between different types of iterables (`Map`s, `List`s). If you try to run the app without these calls, you will get type errors.

Run the app - it should work the same way as before, except if you close it and open it again, the changes will still be there.

#### Fix the tests - 3 mins

Every time you change something or do something new, you need to remember to run the tests before committing to the repository. If we try to run our tests now, they will fail because `PrefService` was not initialised.

In Flutter testing, we can use `setUp` to define some code that needs to run before each test (or `setUpAll` for code that needs to run once before all tests). Add the following code to `widget_test.dart` to make the tests pass again:

```dart
setUp(() {
  WidgetsFlutterBinding.ensureInitialized();
  PrefService.enableCaching();
  PrefService.cache = {};
  PrefService.setStringList(
      'data_map_keys', ['Flutter', 'React', 'Xamarin', 'Ionic']);
  PrefService.setStringList('data_map_values', ['5', '3', '2', '2']);
});
```

Congratulations, you now have a fully functional, interactive pie chart app with persistent data! You can find the code [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/persistence).

### Add improvements

You can keep playing around with the app to learn more about Flutter development. Here are some suggestions on what you could do:

- When you press enter on one field on the edit page, change focus to the following field (*hint*: `FocusNode`).
- Add a "Total" field on the edit page (check out the grading view screenshot in the [Create the layout](#create-the-layout) section; the only new widget you would need to copy that layout is `Divider`).
- Make it so you can change keys in the data map as well, not just the values.
- Add a way for users to add new entries in the data map. There are at least two ways to do that:
  + Add a plus button (maybe a `FloatingActionButton`) that makes a new row of text fields appear.
  + Make a new, empty row of text fields appear if both fields in the last row have data in them.
- Add [form validation](https://flutter.dev/docs/cookbook/forms/validation) to make sure the data in the text fields has the format you want (e.g. non-zero numbers for the values, maybe check that the names are capitalized etc.)

Be creative, and remember to update the tests accordingly!

## Get started with Firebase

**ACS UPB Mobile** uses [Firebase](https://firebase.google.com/) services for analytics ([Google Analytics](https://firebase.google.com/docs/analytics)), authentication ([Firebase Auth](https://firebase.google.com/products/auth)) and storage ([Firestore](https://firebase.google.com/products/firestore), [Cloud Storage](https://firebase.google.com/docs/storage)). In order to get familiar with it, this section will guide you through the process of adding and using Firebase in your app. If you skipped the previous section, you can start with the code [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/testing).

### Add Firebase to your app(s)

Go to the [Firebase console](https://console.firebase.google.com/) and *Create a project*. Give it a name (like "Flutter workshop") and enable Google Analytics (you may need to create a Google Analytics account - you can call it "Personal projects" and reuse it whenever you'd like to play around with Firebase). When creation is complete, you will need to add it to your Flutter app on each individual platform (Android, iOS and Web).

#### Enable the FlutterFire plugins

The easiest way to access Firebase services in Flutter is by making use of [`flutterfire`](https://github.com/FirebaseExtended/flutterfire) plugins, which provide an easy-to-use API for Flutter applications. **ACS UPB Mobile** currently uses [`firebase_analytics`](https://pub.dartlang.org/packages/firebase_analytics), [`firebase_auth`](https://pub.dartlang.org/packages/firebase_auth), [`cloud_firestore`](https://pub.dartlang.org/packages/cloud_firestore) and [`firebase_storage`](https://pub.dartlang.org/packages/firebase_storage), all of which depend on [`firebase_core`](https://pub.dev/packages/firebase_core). These packages offer many useful features for all three target platforms (Android, iOS, Web), except `cloud_firestore`, which (as of July 2020) still [lacks Web support](https://github.com/flutter/flutter/issues/45294).

Add the most recent versions of `firebase_core`, `firebase_analytics` and `cloud_firestore` to the project's `pubspec.yaml` file. Remember to run `flutter pub get`.

#### Add Firebase to Android

- Click the Android icon in the Firebase console  to launch the setup workflow. You can find the Android package name in your Flutter project's `android/app/build.gradle` file if you search for the `applicationId` field.
- Download `google-services.json` and save it in the `android/app/` folder.
- Follow the instructions to enable Firebase for the Android app.
- Update `minSdkVersion` in the app-level `build.gradle` file to `21`.
- You may need to run `flutter clean` and re-build the application for the verification step.
- In the Android Studio console, run `flutter packages get`.

*Note*: If you get an error saying "Plugin project :firebase_auth_web not found. Please update settings.gradle.", try the fix [here](https://github.com/FirebaseExtended/flutterfire/issues/2599).

#### Add Firebase to iOS

Skip this step if you do not have a MacOS computer.

- Click "Add app" in the Firebase console and select "iOS" to launch the setup workflow. The bundle ID should be the same as the `applicationId` you used earlier for the Android setup, or you can find it in `ios/Runner.xcodeproj/project.pbxproj` if you search for `PRODUCT_BUNDLE_IDENTIFIER`.
- Download `GoogleService-Info.plist` and save it in the `ios/Runner` folder.
- Follow the instructions to enable Firebase for the Android app. You may need to run `flutter clean` and re-build the application for the verification step.
- In the Android Studio console, run `flutter packages get`.

#### Add Firebase to Web and host the app

- Click "Add app" in the Firebase console and select "Web" to launch the setup workflow.
- Enable hosting. You can keep the default domain name.
- Follow the instructions and add the scripts to `web/index.html` in your project **before the "main.dart.js" script**.
- Run `flutter build web` before following the hosting instructions. Make sure you select `build/web` as the public directory when running `firebase init`:
<img src=screenshots/firebase_init.png>
- You can now access the link and the app should be up and running on the internet! However, if you try to run it locally from Android Studio, you will get an error. Some additional setup is needed to fix that:
  + From the Firebase console, open the settings for the web application.
  + Under *Firebase SDK snippet*, select *CDN*. Replace the scripts you added earlier with this version.
- We will use Firestore as our database for the app. To add the dependency, simply duplicate the `".../firebase-analytics.js"` script line (*Ctrl*+*D* in Android Studio) from `index.html` and change `analytics` to `firestore`.

Your code should now look like [this](https://github.com/acs-upb-mobile/flutter-workshop/tree/firebase), but keep in mind you should use your own configuration. The Firebase console offers all sorts of useful information about your app(s), including usage statistics.

### Use Firestore in the app

#### Create the database

Time to create our Firestore instance. Go to the Firebase console and open the *Database* view from the *Develop* category. Click *Create database*, select *Start in production mode* and choose a location for the cloud resource (the closer to the userbase, the better).

---

**Firestore and its data model**

[Cloud Firestore](https://firebase.google.com/docs/firestore) is a noSQL database that organises
its data in *collections* and *documents*.

**Collections** are simply a list of documents, where each document has an ID within the collection.

**Documents** are similar to a JSON file (or a C `struct`, if you prefer), in that they contain
different fields which have three important components: a ***name*** - what we use to refer to the
field, similar to a dictionary key -, a ***type*** (which can be one of `string`, `number`,
`boolean`, `map`, `array`, `null` - yeah *null* is its own type -, `timestamp`, `geopoint`,
`reference` - sort of like a pointer to another document), and the actual ***value***, the data
contained in the field.  
In addition to fields, documents can contain collections... which contain other documents... which
can contain collections, and so on and so forth, allowing us to create a hierarchical structure
within the database.

More information about the Firestore data model can be found
[here](https://firebase.google.com/docs/firestore/data-model).

---

After the database is initialized, create a collection (you can call it 'data' or whatever you want) with a single document (you can allow Firebase to give it an automatic unique ID) containing the data map we've been using so far, containing number fields.

<img src=screenshots/document.png>

#### Update the provider

Time to update the `Provider` once again, this time to use our cloud-based database. We no longer need the `preferences` plugin and its setup, but we can keep it in the app in case we want to use it for something else.

We no longer need to initialize something in the constructor, so we can delete it. We will create two async methods for fetching and updating the data in the database.

In order to fetch the information, we use the name of the collection and the `documentID` and `await` for the network response. We then extract the `data_map` field from the response and convert it to a `Map<String, double>`.

```dart
Future<Map<String, double>> fetchDataMap() async {
  DocumentSnapshot snap =
      await _db.collection('data').document('vztH0rlKnqYCOyzK11HS').get();

  _dataMap = Map<String, double>.from(snap.data['data_map']
      .map((key, value) => MapEntry(key, value.toDouble())));

  notifyListeners();

  return _dataMap;
}
```

Conversion is relatively easy to do because Firebase stores data as maps and our data model is a simple `Map`. For custom data classes, you would need to implement a way to convert between an instance of the class and a `DocumentSnapshot` or a map. **ACS UPB Mobile** does that by creating `extension`s on the data classes with methods like `fromSnap` and `toData` (a good example is [here](https://github.com/acs-upb-mobile/acs-upb-mobile/blob/master/lib/pages/portal/service/website_provider.dart)). Extensions extend the functionality of a class by adding new attributes, constructors or methods. They are usually made on classes you cannot modify (such as pre-defined classes like `StatelessWidget` or even `String`), but in our case help with the separation of concerns. The data layer should not have any database-specific functionality (as per the design pattern we described in the [Passing data](#passing-data) section), hence why we define this behavior in the service layer (our provider).

The process of updating data is fairly similar:

```dart
void updateDataMap(Map<String, double> newDataMap) async {
  DocumentReference ref =
      _db.collection('data').document('vztH0rlKnqYCOyzK11HS');

  await ref.updateData({'data_map': newDataMap});
}
```

Our setter will now call `updateDataMap` instead of updating the preferences. We won't bother waiting for it, but depending on the situation, in other apps you may want to wait and report an error if it occurs. You could, for instance, wrap the call in a `try`/`catch` block.

```dart
set dataMap(Map<String, double> newDataMap) {
  _dataMap = newDataMap;
  updateDataMap(newDataMap);
  notifyListeners();
}
```

The `dataMap` field now acts as a simple in-memory cache. It will be `null` if `fetchDataMap` was not called successfully, therefore we must change `MainPage` to make sure it does call it.

#### Update the layout

Flutter has a very useful widget for dealing with futures, called a `FutureBuilder`. It can display something different depending on whether the future is complete or not. We will use it as the body of our scaffold, and make it display a progress indicator while waiting for the data, a pie chart if the data is fetched successfully or an error message otherwise.

```dart
body: FutureBuilder<Map<String, double>>(
    future: Provider.of<DataProvider>(context).fetchDataMap(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Something went wrong.'));
        }
        return PieChart(
          dataMap: snapshot.data ?? {},
          legendPosition: LegendPosition.top,
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    })
```

If you run the app, it should now display the "Something went wrong" error message. If you look at the console, you will see an error like `W/Firestore(32521): (21.3.0) [Firestore]: Listen for Query(data/vztH0rlKnqYCOyzK11HS) failed: Status{code=PERMISSION_DENIED, description=Missing or insufficient permissions., cause=null}`. We will fix it in a bit, for now let's try to open the edit page. You'll see the ugly Flutter exception screen because we don't deal with a lack of data in this page. The simplest way to do that is by updating the body of the scaffold to check whether the cached `dataMap` is `null`:

```dart
body: (dataMap == null)
          ? Center(child: Text('No data to edit'))
          : Padding(
            ...
```

Now that the edit page handles lack of data, we can do even more - restrict access to it altogether if there is nothing to edit. If the `onPressed` callback of an `IconButton` is `null`, the button will appear disabled and will not respond to touch:

```dart
IconButton(
  icon: Icon(Icons.edit),
  onPressed: dataMap == null
      ? null
      : () => Navigator.of(context).pushNamed('/edit'),
)
```

Do keep in mind that users on the web version can still access the edit page by changing the URL, so it's important that we handle the `null` value inside the page as well as restricting access.

#### Check permissions

Now, to fix the `PERMISSION_DENIED` error. We need to allow read/write access to our `data` collection from the Firebase console. Go back to the database and open the *Rules* menu. Here we can define custom security rules which control who can do what in our database. You can find more information about Firebase Security Rules [here](https://firebase.google.com/docs/rules), but for now we will simply allow access to our collection by changing the rules like this:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /data/{data}/{document=**} {
    	allow read, write: if true
    }
  }
}
```

Publish the rules and reload the app. The pie chart should now show, but the edit button will probably still be greyed out - for it to be updated accordingly, you would need to wrap the entire `Scaffold` into a `FutureBuilder` and use the data from the snapshot to verify whether the button should be disabled. You can do that later, for now just restarting the app should do the trick.

If the data fetching is very fast and you'd like to make sure that the loading indicator works as expected, you might need to make the `fetchDataMap` take longer. You can temporarily add something like `await Future.delayed(Duration(seconds: 5))` to make it last 5 seconds longer so you have time to see the progress indicator.

Try to edit the chart while having the document open in the Firebase console. You will see it update immediately! Now whoever uses the app can see and make live updates. If something isn't working correctly, you can check the code [here](https://github.com/acs-upb-mobile/flutter-workshop/tree/firestore) (just remember to use your own configuration and unique `documentID`).
