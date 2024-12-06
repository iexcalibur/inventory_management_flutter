import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';
import '../services/database_service.dart';

final productViewModelProvider = Provider((ref) {
  final repository = ProductRepository(DatabaseService());
  return ProductViewModel(repository);
});

final productsProvider = StateNotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>((ref) {
  final viewModel = ref.watch(productViewModelProvider);
  return ProductsNotifier(viewModel);
});

class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductViewModel _viewModel;

  ProductsNotifier(this._viewModel) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      state = AsyncValue.data(await _viewModel.getAllProducts());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addProduct(Product product) async {
    await _viewModel.addProduct(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _viewModel.updateProduct(product);
      await loadProducts();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _viewModel.deleteProduct(id);
      await loadProducts();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class ProductViewModel {
  final ProductRepository _repository;

  ProductViewModel(this._repository);

  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);
  }

  Future<List<Product>> getAllProducts() async {
    return await _repository.getAllProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    await _repository.deleteProduct(id);
  }
} 