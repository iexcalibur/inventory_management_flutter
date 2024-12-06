# Inventory Management App

A Flutter application for managing product inventory with CRUD operations and real-time search functionality.

## Project Structure

```
lib/
├── models/
│   └── product.dart                 # Product data model
├── services/
│   └── database_service.dart        # SQLite database operations
├── viewmodels/
│   └── product_viewmodel.dart       # Business logic and state management
├── views/
│   ├── widgets/
│   │   ├── black_button.dart        # Reusable button component
│   │   ├── delete_confirmation_dialog.dart  # Delete confirmation popup
│   │   ├── product_card.dart        # Product list item component
│   │   ├── search_field.dart        # Search input component
│   │   └── text_input.dart          # Form input component
│   ├── add_product_screen.dart      # Add new product screen
│   ├── product_edit_screen.dart     # Edit product screen
│   └── product_list_screen.dart     # Main product listing screen
└── main.dart                        # App entry point
```

## Features

### 1. Product List Screen
- Displays all products in a scrollable list.
- Real-time search by product name or SKU.
- Sorting options:
  - Name (A-Z)
  - Name (Z-A)
  - Price (Low-High)
  - Price (High-Low)
- Low stock indicator for products with quantity < 5.
- Add new product via a floating action button (FAB).
- Edit product by tapping on an item.

### 2. Add Product Screen
- Form to add new products with the following fields:
  - **Product Name**
  - **SKU**
  - **Price** (with currency icon)
  - **Quantity**
- Features:
  - Form validation.
  - Animated input fields.
  - Save/Cancel functionality.

### 3. Edit Product Screen
- Edit existing product details.
- Delete product option.
- Form validation.
- Animated input fields.
- Save/Cancel functionality.

## Components

### 1. BlackButton
A customizable button component with the following properties:
- Text
- Background color
- Text color
- Border options
- Disabled state

### 2. TextInput
An enhanced text input component with:
- Animated label
- Focus handling
- Validation
- Currency icon option
- Error states

### 3. SearchField
A search input component with:
- Clear button
- Auto-focus handling
- Real-time search
- Placeholder text

### 4. ProductCard
A product display component showing:
- Product name
- SKU
- Price
- Quantity
- Low stock indicator
- Edit functionality

### 5. DeleteConfirmationDialog
A confirmation dialog with:
- Custom styling
- Cancel/Delete options
- Action handling

## State Management
- Uses **Riverpod** for state management.
- **AsyncValue** for handling loading and error states.
- **StateNotifier** for product operations.

## Data Persistence
- SQLite database for local storage.
- Supports CRUD operations:
  - Create new products.
  - Read product list.
  - Update existing products.
  - Delete products.

## Styling
- Consistent color scheme.
- Responsive design.
- Animated transitions.
- Form validation feedback.
- Error handling UI.
- Loading states.



## Dependencies
- **flutter_riverpod**: State management.
- **sqflite**: Database operations.
- **uuid**: Unique ID generation.

