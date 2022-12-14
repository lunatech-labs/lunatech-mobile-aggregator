# Lunatech-mobile-flutter
This project aims to provide a one-stop mobile app where employees 
are able to interact with our existing applications.    
Previous attempts at this kind of mobile applications were performed by using native SDK,
([IOS Apps](https://github.com/lunatech-labs/lunatech-swift-aggregator), 
[Android App](https://github.com/lunatech-labs/lunatech-android-aggregator))
but were quickly dropped. The idea with this new project is to use a cross-platform library
in order to reduce code duplication, maintenance and development time.

[Flutter](https://flutter.dev/) was chosen as the library for this task.

## About Flutter
From Wikipedia:
> Flutter is an open-source UI software development kit created by Google. 
It is used to develop cross platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.

Compared to other libraries that try to bring cross-platform capabilities to mobile development
(mainly React Native), flutter is more performant, embraces a code-only approach to UI design and 
offers hot reload for quick debugging.    
On the other end, using this framework requires learning a new programming language, Dart, 
which luckily enough doesn't differ too much from typed languages as TypeScript and Java.

## About the application
The application will use Google Sign In at start-up in order to receive the Access Token 
that will later be used to authenticate with all our internal applications.
This Sign In will only accept Lunatech employees.

Once authenticated, the user will get access to the main application. From the drawer menu 
he'll be able to select one of the following screens:
- [Home](#home)
- [Vacation App](#vacation-app)
- [Lunch App](#lunch-app)
- [WiFi Password Reset](#wifi-password-reset)
- [Guides](#guides)

### Home
The homepage will be used as a portal to the [Lunatech Blog](https://blog.lunatech.com/)    
There will be a list with the most recent articles published on the blog. It's also possible 
to create other sorting methods (maybe a "random" one to select a random article that might pick the 
interest of the user)    
Upon clicking on one of the articles, an in-app browser will display the content of it.


### Vacation App
The Vacation App will provide the user access to all the functionalities available in the Web App.    
He will be able to see his remaining vacation days, check the status of his vacation requests and 
request new vacations all from this screen. 

### Lunch App
The Lunch App section of the app will allow the users to reserve a spot for the incoming community meals. Just as the web 
app, it will also give the opportunity to specify some diet restrictions (even though this setting doesn???t seem to be used at the moment)

### WIFI Password Reset
Here it will be possible to generate a new password for the LunatechEnterprise network at the press of a button, 
if possible an option to automatically update the existing network configurations will be added

### Guides
In this section various guides will be presented to the user. These guides will have a progress 
bar describing how many tasks are left before completion. Some of the guides that we are planning to implement are:

* [How to survive your first days at Lunatech - Welcome!](https://lunatech.atlassian.net/wiki/spaces/GLOB/pages/1080983595)
* [Employee last day tasks](https://lunatech.atlassian.net/wiki/spaces/GLOB/pages/6107109)

And some more from: [How to do stuff](https://lunatech.atlassian.net/wiki/spaces/INTRANET/pages/56066122)

Ideally, these guides will be interactive, helping the user to accomplish their task (e.g. clicking o n the ???Configure 
a personal WiFi account??? task in "How to survive your first days at Lunatech" will bring you to the wifi section of the app)
