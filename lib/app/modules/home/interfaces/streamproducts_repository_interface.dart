
import '../models/product_model.dart';

abstract class IStreamProductRepository {
  IStreamProductRepository(Object object);

  Stream<List<Product>> getProductStream();
}
