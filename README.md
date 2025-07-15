# Movie Explorer App

A simple iOS application that displays popular movies from TMDB API with favorite functionality.

## Features
- View popular movies in a grid layout
- Mark movies as favorites
- View movie details
- Persistent favorite storage using UserDefaults

## Architecture
The app follows Clean Architecture with MVVM pattern:
- **Presentation Layer**: Views and ViewModels
- **Domain Layer**: Entities and Use Cases
- **Data Layer**: Repositories, DTOs, and Services

### Key Components
- **NetworkService**: Generic networking layer with async/await
- **FavoriteStorage**: Actor-based storage for favorites
- **DependencyContainer**: Handles all dependency injections

## Dependencies
- Alamofire: For networking
- SDWebImage: For image loading and caching
