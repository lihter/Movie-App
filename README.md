# MovieApp (from 2021)

[![Swift](https://img.shields.io/badge/Language-Swift-FA7343?logo=swift\&logoColor=white\&style=flat-square)](https://swift.org/)  [![UIKit](https://img.shields.io/badge/UI-UIKit-000000?logo=apple\&logoColor=white\&style=flat-square)](https://developer.apple.com/documentation/uikit)  [![Combine](https://img.shields.io/badge/Reactive-Combine-00C6FF?style=flat-square)](https://developer.apple.com/documentation/combine)  [![Networking](https://img.shields.io/badge/Networking-URLSession-007ACC?style=flat-square)](https://developer.apple.com/documentation/foundation/urlsession)  [![Core Data](https://img.shields.io/badge/Persistence-CoreData-6BA18A?logo=apple\&logoColor=white\&style=flat-square)](https://developer.apple.com/documentation/coredata)  [![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-772953?style=flat-square)](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)  [![Coordinator](https://img.shields.io/badge/Pattern-Coordinator-4A90E2?style=flat-square)](https://khanlou.com/2015/01/coordinators-redux/)  [![Custom Fonts](https://img.shields.io/badge/Styling-Custom%20Fonts-663399?style=flat-square)](https://developer.apple.com/documentation/coretext)  [![SnapKit](https://img.shields.io/badge/Layout-SnapKit-4285F4?logo=square\&logoColor=white\&style=flat-square)](https://github.com/SnapKit/SnapKit)  [![SPM](https://img.shields.io/badge/Dependency-SPM-000000?logo=swift\&logoColor=white\&style=flat-square)](https://swift.org/package-manager/)

> A demo iOS app to browse, search, and favorite movies using The Movie Database (TMDB) API.

## Table of Contents

* [Overview](#overview)
* [Features](#features)
* [Architecture](#architecture)
* [Tech Stack](#tech-stack)
* [Screenshots](#screenshots)

---

## Overview

MovieApp is a sample iOS application built in 2021 to demonstrate modern app architecture and UI patterns:

* Fetches movie data from TMDB via `URLSession` and Combine
* Caches favorites and user settings locally (Core Data & UserDefaults)
* Uses Clean Architecture and Coordinator Pattern for maintainability
* Custom layouts with SnapKit and custom fonts
* Fully adaptive to both portrait and landscape orientations

---

## Features

* **Home & Browse**

  * Displays popular, now playing, and top rated movies
  * Infinite scroll with paginated API calls
* **Search**

  * Live search by title with debounced queries using Combine
* **Movie Details**

  * Poster, title, release date, genres, runtime, overview, and crew
  * Favorite/unfavorite toggle
* **Favorites**

  * Persisted in Core Data and UserDefaults
  * Offline access to favorited movies
* **Custom Styling**

  * Custom `.ttf` fonts applied app-wide

---

## Architecture

The app follows **Clean Architecture** layered structure with the **Coordinator Pattern** for navigation:

```
┌────────────────────────┐
| Presentation Layer     |
| • ViewControllers      |
| • Presenters           |
├────────────────────────┤
| Domain Layer           |
| • Use Cases            |
├────────────────────────┤
| Data Layer             |
| • MovieRepository      |
| • MovieNetworkDataSource |
| • MovieLocalDataSource |
| • UserDefaultsDataSource|
└────────────────────────┘
```

### Layers Detail

1. **Data Layer**

   * **MovieNetworkDataSource**

     * Fetches movie lists, search results, and details from TMDB (`URLSession` + Combine)
   * **MovieLocalDataSource**

     * Core Data for storing movies and caching essential data
   * **UserDefaultsDataSource**

     * For storing favorited movies
   * **MovieRepository**

     * Exposes unified APIs for the Domain layer, orchestrates between network and local sources

2. **Domain Layer**

   * **MoviesUseCase**

     * Encapsulates business logic for fetching, searching, and managing favorites

3. **Presentation Layer**

   * **Presenters**

     * Transform domain entities into view models
   * **ViewControllers**

     * UIKit-based UI components bound to presenters

4. **Coordinator / Router**

   * Handles navigation flows (Home → Details → Favorites)
   * Decouples navigation logic from view controllers

### Clean Architecture Benefits

* **Separation of Concerns:** Business logic isolated from UI and data concerns
* **Testability:** Each layer can be unit-tested in isolation
* **Maintainability:** Easy to replace or extend data sources, use cases, or presentation components

---

## Tech Stack

* **Language:** Swift 5
* **UI:** UIKit
* **Reactive:** Combine
* **Networking:** URLSession + Combine
* **Persistence:** Core Data & UserDefaults
* **Architecture:** Clean Architecture & Coordinator Pattern
* **Layout:** SnapKit
* **Dependency Management:** Swift Package Manager (SPM)
* **Styling:** Custom `.ttf` fonts

---

*Enjoy exploring movies!*

---

## Screenshots
<img width="360" alt="screenshot-movieapp-2" src="https://github.com/user-attachments/assets/7216196e-1b8f-4cb8-bdaf-7f55e1aa23cb" />
<img width="360" alt="screenshot-movieapp-2" src="https://github.com/user-attachments/assets/22a23df8-587b-4c87-af94-ff120314d16e" />

