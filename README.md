# Flutter Projects

**Flutter Projects** is a Flutter app that fetches and displays a list of projects from a JSON API. This app showcases project details including the language used, Git repository links, and project completion status.

## Features

- Fetches project data from a remote JSON API.
- Displays project information in a responsive and user-friendly interface.
- Each project card includes the project's name, language, Git address, and completion status.

## Installation

To run the Projects Loader app locally, follow these steps:

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- [Dart](https://dart.dev/get-dart) (comes with Flutter SDK).

### Setup

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/projects_loader.git
   cd projects_loader
   ```

2. **Install dependencies:**

   ```sh
   flutter pub get
   ```

3. **Run the app:**

   ```sh
   flutter run
   ```

## Configuration

The app fetches project data from the following URL:

```plaintext
https://raw.githubusercontent.com/CodeFoxy-Github/Flutter-Projects/main/projects.json
```

You can modify the URL in the `lib/main.dart` file if you want to use a different API endpoint.
And the json format is:
The JSON data is organized as follows:

```json
{
  "Project Name": {
    "Language": "Programming Language(s) used",
    "Git Address": "URL to the project's Git repository",
    "Finished?": "Status of project completion"
  }
}
```
## Contributing

Contributions are welcome! If you find any issues or have suggestions, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev) for building the cross-platform app.
