
import '../models/product_model.dart';

abstract class IHttpService  {

  Future<List<Product>> getApi(String url) ;
}