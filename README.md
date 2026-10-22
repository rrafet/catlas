# Catlas App

Catlas (Campus Cat Care Network) is a Flutter app we are developing for CS310. It aims to help students and staff coordinate the care of stray cats on campus.

Users can look up cats, share sightings, log food and water refills and report cats that need help. Each campus or community has its own space, which users join with an organization code.

## Planned Features

- Sign up, log in and log out with email and password
- Join an organization and access its cats, stations and reports
- Browse cat profiles and filter cats by campus zone and color
- Log cat sightings with the device's location and the time
- View cats' last known locations and feeding stations on a map
- View feeding stations by time since their last refill and log food or water refills with one tap
- Submit health reports with a photo, location and description, with an option to link them to a cat
- View open reports in a "Needs Help" list and mark them as resolved as the reporter or an admin
- Add, edit and delete cats and feeding stations as an admin

The initial cat records and photos will be imported from our existing campus cat database.

## Optional Features

- Follow cats through a personal "My Tracked Cats" list

## Tech Stack

- Flutter and Dart
- Firebase Authentication for email and password sign-in
- Cloud Firestore for app data and real-time updates
- Firebase Storage for cat and health-report photos
- `google_maps_flutter` for maps
- `geolocator` for device location
- Firebase Admin SDK for a one-time script to import the existing cat records and photos

## Group Information

**Course:** CS310 Mobile Application Development  
**Group:** 13

### Members

- Rafet Ayvalı (31155)
- Batuhan Işık (33951)
- Alya Ayşe Arslan (34121)
