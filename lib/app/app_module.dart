import 'package:desafio_pleno/app/modules/editProducts/editProducts_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/editProducts/editProducts_Page.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds {
    return [];
  }

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/editProduct', module: EditProductsModule())
  ];
}
