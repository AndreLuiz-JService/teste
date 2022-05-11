
import '../models/product_model.dart';

abstract class IApiProducts {
  Future<List<Product>> getProductsApi();
}
