import 'package:desafio_pleno/app/modules/editProducts/components/images_form.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_pleno/app/modules/editProducts/editProducts_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../helpers/format_data.dart';
import '../common/remove_product.dart';
import '../home/models/product_model.dart';
import 'components/type_form.dart';

class EditProductsPage extends StatefulWidget {
  final Product product;
  bool editing;
  EditProductsPage(Product? p)
      : editing = p != null ? true : false,
        product = p != null ? p.clone() : Product();
  @override
  EditProductsPageState createState() => EditProductsPageState();
}

class EditProductsPageState extends State<EditProductsPage> {
  final EditProductsStore store = Modular.get();
  final FormataData formataData = FormataData();
  final moneyController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    moneyController.text = widget.product.price == null
        ? '0,00'
        : formataData.formatPt_Br(widget.product.price!.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editing ? 'Editar Produto' : 'criar produto'),
        centerTitle: true,
        actions: [
          if (widget.editing)
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => RemoveProductDialog(
                            product: widget.product,
                          ));
                },
                icon: const Icon(
                  Icons.delete_rounded,
                ))
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImagesForm(product: widget.product),
                const SizedBox(
                  height: 10,
                ),
                TypeForm(product: widget.product),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: widget.product.title,
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[600],
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Informe um titulo';
                    }
                    if (name.length < 6) {
                      return 'Titulo de no minimo seis caracteres';
                    }
                    return null;
                  },
                  onSaved: (name) => widget.product.title = name,
                ),
                TextFormField(
                  controller: moneyController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Preço',
                    labelStyle: TextStyle(color: Colors.purple.shade600),
                    isDense: true,
                    prefixText: 'R\$ ',
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  validator: (price) {
                    if (price!.isEmpty) return 'invalido';

                    return null;
                  },
                  onChanged: (price) {
                    widget.product.price = formataData.formatdoubleEn_US(price);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: Text(
                    'Descrição',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple[600],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                TextFormField(
                  initialValue: widget.product.description,
                  decoration: const InputDecoration(
                    hintText: 'Descrição',
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  validator: (desc) {
                    if (desc!.isEmpty) return 'Informe uma descrição';
                    if (desc.length < 6) {
                      return 'Descrição de no minimo dez caracteres';
                    }
                    return null;
                  },
                  onSaved: (desc) => widget.product.description = desc,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'Height',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple[600],
                      fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  initialValue: widget.product.height.toString(),
                  decoration: const InputDecoration(
                    hintText: 'height',
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  validator: (height) {
                    if (height!.isEmpty) return 'Informe um height';
                    if ((int.tryParse(height) ?? 0) <= 0)
                      return 'Informe um height valido';
                    return null;
                  },
                  onSaved: (height) =>
                      widget.product.height = int.parse(height!),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'Width',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple[600],
                      fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  initialValue: widget.product.width.toString(),
                  decoration: const InputDecoration(
                    hintText: 'width',
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  validator: (width) {
                    if (width!.isEmpty) return 'Informe um width';
                    if ((int.tryParse(width) ?? 0) <= 0)
                      return 'Informe um width valido';
                    return null;
                  },
                  onSaved: (width) => widget.product.width = int.parse(width!),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Observer(builder: (_) {
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: !store.loading.value
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                store.setloadint();
                                await widget.product.save();
                                await Future.delayed(Duration(seconds: 2));
                                store.setloadint();
                                Navigator.of(context).pop();
                              } else {}
                            }
                          : null,
                      child: store.loading.value
                          ? const Padding(
                              padding:  EdgeInsets.all(6),
                              child:  Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                            )
                          : const Text('Salvar'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple[400],
                          textStyle: const TextStyle(fontSize: 18),
                          side: BorderSide(color: Colors.white)),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
