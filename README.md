## Overview

This app connects to a third-party API ([RapidAPI - Movies & TV Shows Database](https://rapidapi.com/amrelrafie/api/movies-tv-shows-database)) and includes:

- Display of trending movies
- Movie search functionality
- Detailed movie view, including:
  - Title, release year, rating
  - Genres (horizontal collection view)
  - Cast (stars)
  - Description

---

## Architecture

The app follows the **MVC (Model-View-Controller)** pattern:

- `Model` — JSON data models using `Codable`
- `View` — custom UI components and cells
- `Controller` — UI logic, API interaction, and user actions

---

## Technologies

- **Swift**
- **UIKit**
- **SnapKit** — layout using constraints in code
- **URLSession** — networking
- **Codable** — JSON parsing

## Installation

Make sure to install Snapkit through cocoapods. ("pod install")

Just use my API key :D
