# The Clean Architecture with MVVM - Flutter

## Overview
The project focuses on creating a structured, robust, testable, scalable application for absence managers with mock data (JSON), supporting dark and light themes.

## Table of Contents
- [Architecture](#architecture)
- [Technologies and Libraries Used](#technologies-and-libraries-used)
- [Supporting Operating Systems](#supporting-operating-systems)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Running the Project](#running-the-project)
- [Author](#author)

## Architecture

The Project is Based on MVVM and Clean Architecture with consideration of SOLID principles which Includes four Module:

1. App: responsible for the project's infrastructure including network handlers, exception handlers, and base files.
2. Data: The data layer serves as a bridge between the domain layer and the presentation layer, supplying data by implementing data sources, repositories, and models.
3. Domain: The domain layer encapsulates the core business logic and rules, acting as an intermediary between the data layer and presentation layer to ensure the separation of concerns and maintain a clean, business-centric architecture.  
4. Presentation: The presentation layer manages user interfaces and interactions, focusing on the visual representation of data and user experience. It relies on the domain layer for business logic and the data layer for data retrieval, fostering a clear separation of concerns in the application architecture.

## Technologies and Libraries Used

- **Flutter**: Flutter is a UI toolkit that enables the creation of natively compiled mobile, web, and desktop applications from a single codebase.

- **[Freezed](https://pub.dev/packages/freezed)**: A code generation package for unions/pattern-matching/copy/toString/equals/hashCode.

- **[Get](https://pub.dev/packages/get)**: A state management, Dependency Injection library for Flutter.

- **[Json Annotation](https://pub.dev/packages/json_annotation) and [Json Serializable](https://pub.dev/packages/json_serializable)**: Packages for converting Dart objects to and from JSON.

- **[Lottie](https://pub.dev/packages/lottie)**: A Flutter package for smoothly displaying Lottie animations.

- **[iCal](https://pub.dev/packages/ical)**: A Dart package to generate iCalendar files.

- **[Path Provider](https://pub.dev/packages/path_provider)**: A Flutter plugin for finding commonly used locations on the filesystem. Supports Android, iOS, Linux, macOS and Windows.

- **[Open File](https://pub.dev/packages/open_file)**: A plug-in that can call native APP to open files with string results in the Flutter, support iOS(DocumentInteraction) / android(intent) / PC(ffi) / web(dart:html).

- **[Build Runner](https://pub.dev/packages/build_runner)**: Provides a concrete way of generating files using Dart code. Files are always generated directly on disk, and rebuilds are incremental.

- **[Flutter Lints](https://pub.dev/packages/flutter_lints)**: Contains a recommended set of lints for Flutter apps, packages, and plugins to encourage good coding practices.

## Supporting Operating Systems

- **Android**

- **Web**: generating the .iCal file is not supported on the web yet...

## Getting Started

### Prerequisites

- Ensure that you have Flutter and Dart installed on your machine. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/m4rzb4ni/Absence-Manager-Flutter.git

### Running the Project


1. Update the pub:

   ```bash
   flutter pub get
2. Build models with [Freezed](https://pub.dev/packages/freezed):

   ```bash
   dart run build_runner build --delete-conflicting-outputs  
3. Build the apk:

   ```bash
   flutter build apk

4. Build the web:

   ```bash
   flutter build web
   
### Author

 **Hamidreza Marzbani**

- **LinkedIn**: https://www.linkedin.com/in/marzbani/
- **Email**: [marzbani.business[at]gmail[dot]com]()






