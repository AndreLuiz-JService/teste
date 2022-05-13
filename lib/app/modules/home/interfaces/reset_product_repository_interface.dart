import '../models/product_model.dart';

abstract class IResetRepository {

  Future<void> resetProducts();
}