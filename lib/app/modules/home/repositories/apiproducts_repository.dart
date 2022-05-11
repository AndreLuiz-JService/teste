import 'package:desafio_pleno/app/modules/home/interfaces/apiproducts_repository_interface.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/cliente_http_service_interface.dart';

import '../models/product_model.dart';


class ApiProductsRepository implements IApiProducts {
  final IHttpService service;

  ApiProductsRepository(this.service);

  @override
  Future<List<Product>> getProductsApi() async{
    try {
      List<Product> response = await service.getApi(
          "https://raw.githubusercontent.com/AndreLuiz-JService/DataBase2/main/products.json");

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
