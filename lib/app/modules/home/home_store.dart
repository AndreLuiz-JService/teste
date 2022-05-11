import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/streamproducts_repository_interface.dart';
import 'package:mobx/mobx.dart';

import 'interfaces/apiproducts_repository_interface.dart';
import 'models/product_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IApiProducts apiProductsrepository;
  final IStreamProductRepository streamProductRepository;
  final FirebaseFirestore firestore;

  @observable
  Observable<bool> loading = false.asObservable();

  @observable
  ObservableStream<List<Product>>? productList;

  HomeStoreBase(
    IApiProducts this.apiProductsrepository,
    IStreamProductRepository this.streamProductRepository,
    this.firestore,
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
    await firestore.collection('products').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    loading.value = false;
  }
}
