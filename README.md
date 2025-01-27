# ExchangeMate

This is the app where you can view latest currency rates with base currency as Euro. Also you can add the currencies you liked to you favourites. The app has two tabs which are Currencies and Favourites. You can view these currencies in an offline mode if you have prefetched the data before. You can view screenshots as an example of how the app works.
<img src="https://github.com/lenchyk/ExchangeMate/blob/develop/Screenshots/CurTab.png" alt="Example Image" style="width:100; height:200;">
<img src="https://github.com/lenchyk/ExchangeMate/blob/develop/Screenshots/FavTab.png" alt="Example Image" style="width:100; height:200;">

## How to build and launch the app from XCode
You have to do some steps in order to build the app in Xcode. So, let's get started.

As we have GraphQL for network layer, we have to make sure to configure all necessary settings. The first one is to add apollo-ios-cli to your project file: go to Xcode project and right-click (click with two fingers) onto Project file. You will see downdrop menu with one grey option Apollo below. Select **Install CLI**.

 After this open the terminal, navigate to your root folder where ExchangeMate is located (there you can also see files like apollo-codegen-config.json and the project file itself) and run the next command:
```ruby
touch .env
```
In this .env file we will store our ApiKey for SwopAPI. Now open this newly created .env, paste the line under open command and save the file:
```ruby
open .env
```
Paste:
GRAPHQL_API_KEY=<here should be the api key itself>

Next go back to the project in Xcode, select the target (ExchangeMate, it is only one, ha-ha), press "Edit scheme", go to the second tab Arguments, and create environment key (you can see the image below) with GRAPQL_API_KEY name and apiKey as a value.
![alt text](https://github.com/lenchyk/ExchangeMate/blob/chore/readme/Screenshots/ApiKeySchema.png)

Next run the bash script by running this command (this will configure the schema for GraphQL):
```ruby
./fetch-schema.sh
```
Next one generate our local API dependency:
```ruby
./apollo-ios-cli generate
```

So, that's it. It is time to build and run the app as usually in Xcode.

### App architecture and design choices

I have decided to choose **MVVM+C** architecture because on my opinion it is really good architecture. Also wanted to user **Coordinator** to make navigation more easy and clearly used. For UI part decided to use classic UIKit with storyboards and xibs where necessary, because wanted to make the app as simple as possible without boilerplate code (the reason for this is the small app itself and that I am one developer on this project, so there wouldn't be any merge conflicts in XML storyboard code:). 

About design choices... Well that part was really hard for me, so I have done some research about how really good apps look like and decided to create TabBar with 2 basic lists and heart button on each cell to like or dislike specific currency. For me it is much more intuitive in UX aspect (but I guess it is my subjective point view).

### Description of app structure and major components

So, the project is really modular. I thought that it is better readable when everything is inside it's home folder.

- So the main UI part is **MVVM** folder - this is the place where Controllers with their ViewModel and Storyboards are.
- Then **Coordinator** goes along: there is just one AppCoordinator yet (because the main navigation is like showing tab bar and configuring controllers), but if the app is scaling, we can add more if needed.
- I have some **Reusable views**: the cell for tableViews and a placeholderView.
- **Helpers** are some utility methods or extensions (Previously there have been also separate folder for Extensions but it is one file, so decided to move it here).
- **GraphQL** (schema and one query file) and **API** with SwopAPIManager
- **Models** of course contains Currency Core Data generate models (but previously it was manually written class)
- **CoreData** with its main ExchangeMate.xcdatamodeld file
- **Application** and **Recources** with AppDelegate and some suppourting files accordingly

### How offline mode was implemented

Using CoreData I am saving the currencies that were previously fetched by apollo client. But first I am clearing the ones that were saved yesterday. For favourite tab I also use core data mode, just adding NSPredicate which filters currencies by isFavourited boolean. When user taps heart to like or dislike I update the currency and save the context.

### What can be done better? (Mostly cause of lack of time)

- I really wanted to use CoreDataManager to work with saving, adding to local storage and deleting, but there were some difficulties in implementation and I got not much time to fix it.
- Much more googling how securely store API keys.
- Showing errors alerts to the user.
- Adding some more features to the app (and not just on query), for example baseCurrency specification.
- I wanted to add a library to read ApiKey from .env file, but there were too much boilerplate code to get the filePath of .env file. Another way was to implement it by myself and I tried that too, but honestly working with file paths really sucks.
- And of course add some tests (unit test the business logic in CurrenciesViewModel especially)

Really hope that you enjoyed to read so much text:)
Have a great time of the day!
