// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vicio.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VicioStore on _VicioStore, Store {
  final _$vicioAtom = Atom(name: '_VicioStore.vicio');

  @override
  VicioModel? get vicio {
    _$vicioAtom.reportRead();
    return super.vicio;
  }

  @override
  set vicio(VicioModel? value) {
    _$vicioAtom.reportWrite(value, super.vicio, () {
      super.vicio = value;
    });
  }

  final _$_VicioStoreActionController = ActionController(name: '_VicioStore');

  @override
  void setVicio(VicioModel pVicio) {
    final _$actionInfo =
        _$_VicioStoreActionController.startAction(name: '_VicioStore.setVicio');
    try {
      return super.setVicio(pVicio);
    } finally {
      _$_VicioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unsetVicio() {
    final _$actionInfo = _$_VicioStoreActionController.startAction(
        name: '_VicioStore.unsetVicio');
    try {
      return super.unsetVicio();
    } finally {
      _$_VicioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vicio: ${vicio}
    ''';
  }
}
