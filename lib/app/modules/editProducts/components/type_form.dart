import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../home/models/product_model.dart';
import '../editProducts_store.dart';
import '../models/type.dart';

class TypeForm extends StatelessWidget {
  final Product product;

  const TypeForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditProductsStore store = Modular.get();
    return Align(
        alignment: Alignment.centerLeft,
        child: DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          isExpanded: true,
          hint: 
          product.type!.isNotEmpty ?
          Text(
            product.type!,
            style: TextStyle(fontSize: 14),
          ):
          const Text(
            'Informe o tipo do produto',
            style: TextStyle(fontSize: 14),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.purple,
          ),
          iconSize: 35,
          buttonHeight: 60,
          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey[600]),
          items: store.typesDropDown,
          validator: (type) {
            if (product.type!.isNotEmpty) {
            } else {
              return 'informe o tipo do produto';
            }
          },
          onChanged: (type) {
            product.type = type;
          },
          onSaved: (type) {
            if (type != null) {
              product.type = type;
            }
          },
        ));
  }
}
