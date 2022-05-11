import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'models/type.dart';

part 'editProducts_store.g.dart';

class EditProductsStore = _EditProductsStoreBase with _$EditProductsStore;

abstract class _EditProductsStoreBase with Store {
  @observable
  Observable<bool> loading = false.asObservable();

  @action
  setloadint() {
    loading.value = !loading.value;
  }

  List<String> _types = [
    'dairy',
    'fruit',
    'vegetable',
    'bakery',
    'vegan',
    'meat',
  ];
  List<DropdownMenuItem<String>> get typesDropDown => _types
      .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
      .toList();
}
