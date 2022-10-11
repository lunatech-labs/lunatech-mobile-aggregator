# Contributing

Everyone is welcome to contribute on the mobile app for Lunatech! Contribution 
can be anything from code contributions, documentation, finding issues, suggesting 
new features and design changes.

When first starting, consider talking to [members of the team](https://lunatech.atlassian.net/wiki/spaces/INC/pages/3715629063/Lunatech+Mobile) 
who will be happy to introduce you to the project

## Setup
Some steps are required to set up the dev environment
* Follow the steps to install [Flutter](https://docs.flutter.dev/get-started/install) on your machine.
The Android emulator is the easiest to set up, so it's probably the best to start with.
* Ask any of the team members for the `setup_files`. These files are necessary for the app to compile, 
since they provide the private key that will be used to authenticate with Google

## Troubleshooting
**I'm trying to login into the app but the spin keeps spinning forever??**   
There is a common issue where, sometimes, the login doesn't go through. Try to "Go back" 
to the sign in page cancelling the login process.   
If at the bottom a snackbar message with `ApiException: 16` pops up, that means that you 
are affected by said issue.


_Only known solution at the moment is to [wipe the data from your emulated device](https://developer.android.com/studio/run/managing-avds#emulator)_