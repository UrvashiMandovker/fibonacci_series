# isolate_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Fibonacci Series App with BLoC and Isolate

## Overview
This Flutter app calculates the Fibonacci series using two approaches:
1. **Async Future**: Runs computation on the main thread.
2. **Isolate**: Uses a separate thread for better performance.

The app uses **BLoC** for efficient state management.

## Features
- Input a number to generate its Fibonacci series.
- Choose between **Async** or **Isolate** computation.
- Uses **BLoC** for state management.

## How It Works
1. User enters a number.
2. Presses `Async` or `Isolate`.
3. `FibonacciBloc` processes the request.
4. Computation is performed (on the main thread or using an Isolate).
5. Results are displayed dynamically.

## Installation
1. Clone the repository.
2. Run `flutter pub get`.
3. Execute `flutter run` to start the app.

---
This project demonstrates efficient Fibonacci computation using Flutter, BLoC, and Isolate.

## version
- flutter version: 3.24.1
- Dart version: 3.5.1