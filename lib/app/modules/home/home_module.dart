import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/apiproducts_repository_interface.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/reset_product_repository_interface.dart';
import 'package:desafio_pleno/app/modules/home/interfaces/streamproducts_repository_interface.dart';
import 'package:desafio_pleno/app/modules/home/repositories/apiproducts_repository.dart';
import 'package:desafio_pleno/app/modules/home/repositories/streamProduct_repository.dart';
import 'package:desafio_pleno/app/modules/home/services/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_store.dart';

import 'home_page.dart';
import 'repositories/reset_product_repository.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore(i.get<IApiProducts>(),
        i.get<IStreamProductRepository>(), i.get<IResetRepository>())),
    Bind.lazySingleton<IApiProducts>((i) => ApiProductsRepository(i.get())),
    Bind.lazySingleton((i) => DioService()),
    Bind.lazySingleton<IStreamProductRepository>(
        (i) => ProductRepository(FirebaseFirestore.instance)),
    Bind.lazySingleton<IResetRepository>(
        (i) => ResetRepository(FirebaseFirestore.instance))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
