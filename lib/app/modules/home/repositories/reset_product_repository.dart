import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/reset_product_repository_interface.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/streamproducts_repository_interface.dart';

import '../models/product_model.dart';

class ResetRepository implements IResetRepository {
  final FirebaseFirestore firestore;
  ResetRepository(this.firestore);
  @override
  Future<void> resetProducts() async {
    await firestore.collection('products').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
