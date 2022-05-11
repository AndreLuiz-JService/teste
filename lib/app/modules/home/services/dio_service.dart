import 'dart:convert';

import 'package:desafio_pleno/app/modules/home/interfaces/cliente_http_service_interface.dart';
import 'package:dio/dio.dart';

import '../models/product_model.dart';

class DioService implements IHttpService {
  Dio? dio;

  DioService([Dio? cliente]){
    if(cliente == null){
      this.dio = Dio();
    }else{
      this.dio = cliente;
    }
  }
  @override
  Future<List<Product>> getApi(String url) async {
    try {
      final response = await dio!.get(url);
      final list = jsonDecode(response.data) as List;
      List<Product> products = [];

      for (var json in list) {
        final product = Product.fromJson(json);
        products.insert(0, product);
      }
      return products.reversed.toList();
    } catch (e) {
      rethrow;
    }
  }
}
