import 'dart:developer';

import 'package:desafio_pleno/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_fade/image_fade.dart';

import '../common/remove_product.dart';
import 'models/product_model.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: ((String value) async {
              if (value == 'resetar') {
                await controller.resetApi();
              }
            }),
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('resetar api'),
                value: 'resetar',
              ),
            ],
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.productList!.hasError) {
            log(controller.productList!.error.toString());
            return Center(
              child: TextButton(
                onPressed: () async {
                  await controller.getApi();
                },
                child: const Text('Carregar Api'),
              ),
            );
          }
          if (controller.productList!.data == null ||
              controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }

          List<Product> list = controller.productList!.data;

          if (list.isEmpty) {
            return Center(
              child: TextButton(
                onPressed: () async {
                  await controller.getApi();
                },
                child: const  Text(
                  'Carregar Api',
                  style: TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
            );
          }

          return ListView.builder(
            itemBuilder: ((context, index) {
              Product product = list[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 160,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[600],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        product.image == null || product.image!.isEmpty
                            ? Container(
                                height: 70,
                                width: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const  [
                                    Icon(Icons.search,color: Colors.purple,size: 30,),
                                    Text('Buscando sua Imagen',textAlign: TextAlign.center,)
                                  ],
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple)),
                                child: ImageFade(
                                  fadeDuration: const Duration(seconds: 1),
                                  image: NetworkImage(
                                    product.image!,
                                  ),
                                  fit: BoxFit.fill,
                                )),
                        SizedBox(
                          width: size.width * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                    product.title! + '  ',
                                    maxLines: 3,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.purple[700],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(product.type!),
                                ],
                              ),
                              Text(
                                product.description!,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                maxLines: 3,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Atualizado: ${product.formattedDate}',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: product.rating!,
                                minRating: 0,
                                glowColor: Colors.purple.withAlpha(60),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                ),
                                onRatingUpdate: (rating) {
                                  product.rating = rating;
                                  product.saveRating();
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PopupMenuButton(
                              onSelected: ((String value) {
                                if (value == 'editar') {
                                  Modular.to.pushNamed('/editProduct',
                                      arguments: product);
                                }
                                if (value == 'excluir') {
                                  showDialog(
                                      context: context,
                                      builder: (_) => RemoveProductDialog(
                                            product: product,
                                          ));
                                }
                              }),
                              icon: const Icon(Icons.more_horiz),
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                  child: Text('editar'),
                                  value: 'editar',
                                ),
                                const PopupMenuItem(
                                  child: Text('excluir'),
                                  value: 'excluir',
                                ),
                              ],
                            ),
                            Text(
                              product.price!.toStringAsFixed(2),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            itemCount: list.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Modular.to.pushNamed('/editProduct',arguments: null);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
