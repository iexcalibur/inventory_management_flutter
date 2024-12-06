# Inventory Management App

A Flutter application for managing product inventory with CRUD operations, real-time search, and sorting capabilities.

## Features

- **Product Management**
  - Add new products with name, SKU, price, and quantity
  - Edit existing product details
  - Delete products with confirmation
  - Low stock indicators for products with quantity < 5

- **Search & Sort**
  - Real-time search by product name or SKU
  - Sort products by name (A-Z, Z-A)
  - Sort products by price (Low-High, High-Low)

- **User Interface**
  - Clean, modern design
  - Responsive layout
  - Animated transitions
  - Form validation
  - Custom components

## Screenshots

| ![IM_1](https://github.com/user-attachments/assets/54f414b9-fc3e-4e32-97a1-b8ebe2ad6bf1) | ![IM2](https://github.com/user-attachments/assets/f13b4059-d29d-4d0b-85a2-aa7670cc0511) | ![IM3](https://github.com/user-attachments/assets/0b7c8861-e303-4e15-9362-25f7c1f239f6) |
|:---:|:---:|:---:|
| Main | Add Product | Edit Product |

## Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK
- Android Studio / VS Code
- SQLite support

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/inventory_management.git
   ```

2. Navigate to the project directory:
   ```bash
   cd inventory_management
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── models/ # Data models
├── services/ # Database services
├── viewmodels/ # Business logic
├── views/ # UI screens and widgets
└── main.dart # Entry point
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9 # State management
  sqflite: ^2.3.0 # Database
  uuid: ^4.2.1 # Unique IDs
```





