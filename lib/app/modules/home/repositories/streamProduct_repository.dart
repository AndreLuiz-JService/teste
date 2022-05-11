import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/streamproducts_repository_interface.dart';

import '../models/product_model.dart';

class ProductRepository implements IStreamProductRepository {
  final FirebaseFirestore firestore;
  ProductRepository(this.firestore);
  @override
  Stream<List<Product>> getProductStream() {
    
    return firestore.collection('products').snapshots().map((query) {
      return query.docs.map((doc) {
        return Product.FromDocument(doc);
      }).toList();
    });
  }
}
