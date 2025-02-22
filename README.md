# Api Users Clean Architecture Project

## Description
This project demonstrates the implementation of Clean Architecture for managing users. 
It fetches users from API, caches them locally using SharedPreferences, 
and provides functionality to clear cached users.   

## Project Structure:
~~~
lib/
├── core/
│   ├── error/
│   ├── network/
│   ├── usecases/
│   └── dependency_injection/
├── features/
│   └── user/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories_impl/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
└── main.dart
~~~
## Clean Architecture Layers Overview
The project follows the Clean Architecture principles, where each Feature is separated into layers: 
 
Core Module: contains reusable components and utilities that support all layers. It is not a layer itself but a shared module.  
  - error/: Contains custom exceptions (ServerException, CacheException) and failures (ServerFailure, CacheFailure).  
    Used for consistent error handling across the application.  
  
    network/: Contains network-related utilities, such as the ApiClient for making API calls.  
    
    usecases/: Contains the BaseUseCase abstract class, which defines the call method for use cases.  
    
    dependency_injection/: Contains Dependency Injection Container which Registers and resolves dependencies for the application.  
  
Features Module: 
1. Presentation Layer
   - Contains UI components (Users list Screen) and state management (Bloc).
   - Depends on the Domain Layer for business logic,
   - Handles user interactions and updates the UI based on the current state.
   
3. Domain Layer
   - Contains business logic, entities (User entity),
   - and use cases(GetUsers, CacheUsers and ClearCache).  
   - Defines abstract repositories and use cases.

4. Data Layer

  - Implements the repositories defined in the Domain Layer:
  - Handles data sources (remote API, local cache).
    - Remote API: Fetches data from a remote server.
    - Local Cache: Stores data locally using SharedPreferences.
  - Depends on the Domain Layer.

## Workflow Abstract:
  When the User triggers Ui's Bloc events (fetch users, and clear cached Users) a fetch users event triggers **getUsers.call**
  which is the getusers use case's call method (where call method is defined in BaseUseCase in Core module and is overridden for each use case class implementation with a function call 
  corresponding to the use case which interacts with the repository (defined in the Domain Layer) to perform the required operation based on this use case)  
  
  the UserRepository in data layer gets instances for local and remote data sources and first checks the local cache and If data is available,
  it returns the cached users. Otherwise, it fetches users from the remote API and caches them.
  The UserBloc emits a UserLoaded state with the fetched users, and the UI updates accordingly.
  
  UserRepository also a implements Clear Cache Use Case which is used in a ui button to trigger a clear Cache event.
 
## Application Screenshots: 
![swappy-20250222-001203](https://github.com/user-attachments/assets/b66fb428-76ae-4d75-b787-2a5bff708fac)
