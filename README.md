# beer-app
The beer-app is an app for tracking how many beers or drinks of whatever kind a group of people is drinking. The app consists of three parts: the Flutter front end app, the Firebase back end and the beer-chart web app. It is free to fork and use for your own purposes. If you have any contributions to the project, feel free to create a pull request.

For those who just want to use it as is, you can read about how to set it up and export it to a device of your choice below. The app is not on the Play Store or App Store, because it will require you to run your own Firebase back end (this is not that hard), it will also be shown how this is done below.

## Table of contents
- [Prerequisites](#prerequisites)
- [Set up the app](#set-up-the-app)
  - [Clone git repo](#clone-git-repo)
  - [Set up Firebase](#set-up-firebase)
  - [Test the app on a device](#test-the-app-on-a-device)
  - [Build the app to use in "production"](#build-the-app-to-use-in-production)
- [Reporting an issue](#reporting-an-issue)
- [Contributing to the project](#contributing-to-the-project)

## Prerequisites
These are the things you will need when setting up and running the beer-app.

- A computer (duh).
- Some kind of code editor, I don't care what you use.
- Flutter installed, you can read more about how to do this [here](https://docs.flutter.dev/get-started/install).
- A phone or tablet to run the app on, it haven't been tested on desktop or web, but Flutter also runs on these platforms, your mileage may vary.
	- To run on iOS or iPadOS you will have to use a Mac of some kind (thanks Apple).
- A Google account.
- Some knowledge about how to troubleshoot development tools (I don't guarantee everything will always go smoothly).

## Set up the app
This will guide you through how to set up and run the app.

### Clone git repo
Open the terminal at some place on your computer, where you want to have the project located and run the below command.

```zsh
git clone https://github.com/JoakimMellonn/beerapp.git
```

### Set up Firebase
Go to the [Firebase console](https://console.firebase.google.com/) and create a new project, name it whatever you want. Whether or not you enable analytics for the project, is of your own choosing.

Firstly you will now need to setup the two services needed; Authentication and Firestore. To enable Authentication go to the "Build" tab in the side panel and choose Authentication. Choose "Get started" and select "Anonymous" under the Native providers. Now just enable it and press save.
To enable Firestore go to "Firestore Database" in the side panel. Choose "Create database", and start it in production mode with whatever region you would like (it is of course recommended that you choose the closest to your current location, this both affects privacy and performance).

Now you will just need to set up the Firebase back end with the Flutter app. To do this you will have to, on the front page of the project in Firebase below the "Get started by adding Firebase to your app", click the Flutter logo. And follow the setup experience provided by Firebase. The last part with the below code you can omit.

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
```

### Test the app on a device
After setting up the local repo and back end, you should be able to run the app on a device or an emulator. Plug in some device, for the easiest experience an Android device is recommended. Either with the code editor (if supported) or with the terminal run the Flutter app, to do it with the terminal write the below command:

```zsh
flutter run
```

If you run into any problems here, please confront the Flutter docs before creating an issue here, I will of course be as helpful as possible no matter what.

### Build the app to use in "production"
To do this is easiest using the terminal, just run the below command:

```zsh
flutter run --release
```


## Reporting an issue
At the top of this page, choose the "Issues" tab. Search or browse to see if an issue already exists. If not click "New issue" and describe the issue you're experiencing as best as possible. I will get around to fixing it as fast as possible, but I am a student with limited time.

## Contributing to the project
If you have created something awesome you think should be a permanent part of the app, please do create a pull request to contribute to the project!

To do this create a new git branch locally, make your changes, commit and create a pull request. Google has a much better answer than I do on how to do this, plus I'm too lazy to write this part of the guide.
