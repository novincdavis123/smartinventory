## 📱 Product Discovery & Inventory App

A Flutter-based Product Discovery & Inventory application built as part of a machine test.
The app fetches products from a public API and provides search, filtering, and detailed product views using a clean architecture approach.

## 🚀 Features

📦 Fetch products from FakeStoreAPI
🔍 Local search by title and category
🧠 State management using Riverpod
❤️ Product detail view with full information
🖼️ Image loading with error handling
🔄 Pull-to-refresh support
⚡ Clean separation of UI and business logic
🏗️ Architecture

## The project follows Clean Architecture (simplified):

lib/
├── core/                 # Shared utilities & error handling
├── features/
│   └── products/
│       ├── data/        # Models, API, repository impl
│       ├── domain/      # Entities, repository contracts, usecases
│       └── presentation # UI + Riverpod state management
├── main.dart
Flow:
UI → Riverpod Notifier → UseCase → Repository → Remote Data Source → API

## 🧠 State Management

Implemented using Riverpod
NotifierProvider manages:
Product fetching state
Loading / error / data states
Local search filtering

## 🌐 API Used

FakeStoreAPI
https://fakestoreapi.com/products
📱 Screens
🏠 Home Screen
Product list
Search bar (title/category filter)
Pull-to-refresh
📄 Product Detail Screen
Product image (Hero animation)
Title, category, price
Rating & description
## ⚙️ Tech Stack

Flutter
Dart
Riverpod
HTTP package
Clean Architecture principles

## 📦 How to Run

flutter pub get
flutter run