import '../models/product.dart';
import '../services/database_service.dart';

class ProductRepository {
  final DatabaseService _databaseService;

  ProductRepository(this._databaseService);

  Future<void> addProduct(Product product) async {
    await _databaseService.insertProduct(product);
  }

  Future<List<Product>> getAllProducts() async {
    return await _databaseService.getAllProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _databaseService.updateProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    await _databaseService.deleteProduct(id);
  }
} 