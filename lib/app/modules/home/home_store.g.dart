// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: 'HomeStoreBase.loading', context: context);

  @override
  Observable<bool> get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(Observable<bool> value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$productListAtom =
      Atom(name: 'HomeStoreBase.productList', context: context);

  @override
  ObservableStream<List<Product>>? get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(ObservableStream<List<Product>>? value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  late final _$getApiAsyncAction =
      AsyncAction('HomeStoreBase.getApi', context: context);

  @override
  Future getApi() {
    return _$getApiAsyncAction.run(() => super.getApi());
  }

  late final _$resetApiAsyncAction =
      AsyncAction('HomeStoreBase.resetApi', context: context);

  @override
  Future resetApi() {
    return _$resetApiAsyncAction.run(() => super.resetApi());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic getList() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getList');
    try {
      return super.getList();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
productList: ${productList}
    ''';
  }
}
