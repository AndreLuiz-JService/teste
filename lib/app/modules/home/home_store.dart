import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/reset_product_repository_interface.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/streamproducts_repository_interface.dart';
import 'package:mobx/mobx.dart';

import 'interfaces/apiproducts_repository_interface.dart';
import 'models/product_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IApiProducts apiProductsrepository;
  final IStreamProductRepository streamProductRepository;
  final IResetRepository resetRepository;

  @observable
  Observable<bool> loading = false.asObservable();

  @observable
  ObservableStream<List<Product>>? productList;

  HomeStoreBase(
    IApiProducts this.apiProductsrepository,
    IStreamProductRepository this.streamProductRepository,
    IResetRepository this.resetRepository,
  ) {
    getList();
  }

  @action
  getList() {
    productList = streamProductRepository.getProductStream().asObservable();
  }

  @action
  getApi() async {
    List<Product> products = await apiProductsrepository.getProductsApi();
    for (var product in products) {
      await product.save();
    }
  }

  @action
  resetApi() async {
    loading.value = true;
    resetRepository.resetProducts();
    loading.value = false;
  }
}
