# Flutter News App

Welcome to the Flutter News App! This project is built using clean architecture and BLoC state management. It fetches news articles from various categories such as tech, science, sports, and business. Additionally, it supports saving articles locally using the Floor database and opening articles in an external browser.

## Features

- **Category-Based News**: Fetches articles from categories like Tech, Science, Sports, and Business.
- **Local Storage**: Save interesting articles for later reading using the Floor database.
- **External Browser Access**: Open articles in an external browser directly from the app.
- **Dependency Injection**: Implemented using Get_it for seamless management.

## Packages Used

- **UI Enhancements**:
  - `flutter_svg: ^2.0.9`
  - `intl: ^0.19.0`
- **Networking**:
  - `retrofit: ^3.0.1`
  - `dio: ^4.0.6`
- **State Management**:
  - `flutter_bloc: ^8.1.5`
  - `equatable: ^2.0.5`
- **Utilities**:
  - `flutter_hooks`
  - `cached_network_image`
- **Service Locator**:
  - `get_it: ^7.6.7`
- **Local Database**:
  - `floor: ^1.4.2`
  - `sqflite: ^2.2.8`
- **Link Handling**:
  - `url_launcher: ^6.2.5`

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter_news_app.git

