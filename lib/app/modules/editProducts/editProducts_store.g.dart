// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editProducts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditProductsStore on _EditProductsStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_EditProductsStoreBase.loading', context: context);

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

  late final _$_EditProductsStoreBaseActionController =
      ActionController(name: '_EditProductsStoreBase', context: context);

  @override
  dynamic setloadint() {
    final _$actionInfo = _$_EditProductsStoreBaseActionController.startAction(
        name: '_EditProductsStoreBase.setloadint');
    try {
      return super.setloadint();
    } finally {
      _$_EditProductsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
