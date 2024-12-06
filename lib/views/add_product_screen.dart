import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:uuid/uuid.dart';
import 'widgets/black_button.dart';
import 'widgets/text_input.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInput(
                          controller: _nameController,
                          label: 'Product Name',
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter a name' : null,
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          controller: _skuController,
                          label: 'SKU',
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter SKU' : null,
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          controller: _priceController,
                          label: 'Price',
                          isPrice: true,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter price';
                            }
                            if (double.tryParse(value!) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextInput(
                          controller: _quantityController,
                          label: 'Quantity',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter quantity';
                            }
                            if (int.tryParse(value!) == null) {
                              return 'Please enter a valid whole number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlackButton(
                text: 'Save Product',
                width: double.infinity,
                onPressed: _saveProduct,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = Product(
        id: const Uuid().v4(),
        name: _nameController.text,
        sku: _skuController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
      );
      Navigator.pop(context, product);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
} 