import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../viewmodels/product_viewmodel.dart';
import 'add_product_screen.dart';
import 'product_edit_screen.dart';
import 'widgets/search_field.dart';
import 'widgets/product_card.dart';

enum SortOption {
  nameAsc('Name (A-Z)'),
  nameDesc('Name (Z-A)'),
  priceAsc('Price (Low-High)'),
  priceDesc('Price (High-Low)');

  final String label;
  const SortOption(this.label);
}

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  SortOption _currentSort = SortOption.nameAsc;

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void initState() {
    super.initState();
    // Add listener to search controller
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchQuery = '';
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _filterProducts(List<Product> products) {
    var filteredList = products;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final searchLower = _searchQuery.toLowerCase();
      filteredList = filteredList.where((product) {
        return product.name.toLowerCase().contains(searchLower) ||
               product.sku.toLowerCase().contains(searchLower);
      }).toList();
    }

    // Apply sorting
    switch (_currentSort) {
      case SortOption.nameAsc:
        filteredList.sort((a, b) => a.name.compareTo(b.name));
      case SortOption.nameDesc:
        filteredList.sort((a, b) => b.name.compareTo(a.name));
      case SortOption.priceAsc:
        filteredList.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceDesc:
        filteredList.sort((a, b) => b.price.compareTo(a.price));
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          
          children: [
            const Text(
              'Inventory Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 12,),
            Icon(Icons.inventory_2_outlined, color: Colors.grey[700]),
          ],
        ),
        actions: [
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            color: Colors.white,
            onSelected: (SortOption option) {
              setState(() {
                _clearSearch();
                _currentSort = option;
              });
            },
            itemBuilder: (BuildContext context) {
              return SortOption.values.map((SortOption option) {
                return PopupMenuItem<SortOption>(
                  value: option,
                  child: Row(
                    children: [
                      Icon(
                        option == _currentSort ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        size: 20,
                        color: option == _currentSort ? Colors.black : Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        option.label,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: option == _currentSort ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: products.when(
        data: (productList) {
          final filteredProducts = _filterProducts(productList);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        controller: _searchController,
                        hintText: 'Search products...',
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                    if (_searchController.text.isNotEmpty) 
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _clearSearch,
                      ),
                  ],
                ),
              ),
              if (filteredProducts.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () async {
                          _clearSearch();
                          final result = await Navigator.push<Map<String, dynamic>>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductEditScreen(product: product),
                            ),
                          );
                          
                          if (result != null) {
                            if (result['delete'] == true) {
                              await ref.read(productsProvider.notifier).deleteProduct(product.id);
                            } else if (result['product'] != null) {
                              await ref.read(productsProvider.notifier).updateProduct(result['product'] as Product);
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _clearSearch();
          final product = await Navigator.push<Product>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
          if (product != null) {
            await ref.read(productsProvider.notifier).addProduct(product);
          }
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
} 