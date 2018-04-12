# Learn To Pray

Learn To Pray is an app to help people pray.

## Implementation

The app has three main areas.

1. Guided Prayer
- Guided Prayers are prayer prompts centered around a topic. After selecting a topic, you are given a list of prayer prompts for that topic. If you press "Start Praying", you will be guided to a prayer timer area where you can spend time praying, lead by each prompt. You can dismiss the prayer timer by pressing the Finish button or the 'X' in the top corner. You can also Pause the timer by pressing pause. There is a status bar across the top of the prayer prompts to let people know how far along they are in praying through the prompts.

2. Prayer Timer
- The Prayer Timer is simply a timer for your prayer. A user is prompted to set the time they'd like to pray for, and then they are about to start praying as the timer counts down. The page displays a Bible verse if not Guided Prayer is selected.

3. About the App
- This is a section to explain the app to users in a few words. It also gives users access to email the Learn to Pray developer and/or give a donation toward the free app.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
- XCode 9.2
- Swift 4.0
- CocoaPods
```

### Installing

Clone from Github

```
git clone https://github.com/mdtaps/LearnToPray
```

If you don't have it installed already, install CocoaPods from Terminal

```
$ sudo gem install cocoapods
More Details at https://guides.cocoapods.org/using/getting-started.html
```

Create a Podfile

```
$ cd LearnToPray <-- YOUR PROJECT DIRECTORY GOES HERE
$ pod init
```
Open your Podfile and place the following:

```
pod 'Stripe'
```

Close your XCode project. From Terminal, while still in your project directory, run:

```
$ pod install
If you have trouble, you can find Stripe's install documentation here: https://stripe.com/docs/mobile/ios#getting-started
```

## Deployment

Use the Workspace (.xcworkspace) file to run the app

## Built With

* [Joshua Project](https://joshuaproject.net/api/v2) - Used to pull in foreign people group data

## Authors

* **Mark Tapia** - *Initial work* - [MDTaps](https://github.com/mdtaps)

If you would like to contribute to this project, please leave me a note!

## Acknowledgments

* Thanks to my beautiful wife who put up with me staying up late many nights and waking her up when I come to bed.
* Inspired by anyone who wants to pray or meditate but has trouble focusing.
