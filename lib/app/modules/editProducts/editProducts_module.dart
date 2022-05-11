import 'package:desafio_pleno/app/modules/editProducts/editProducts_Page.dart';
import 'package:desafio_pleno/app/modules/editProducts/editProducts_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditProductsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EditProductsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => EditProductsPage(args.data)),
  ];
}
