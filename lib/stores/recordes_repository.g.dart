// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordes_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecordesRepository on RecordesRepositoryBase, Store {
  final _$recordesDesafioAtom =
      Atom(name: 'RecordesRepositoryBase.recordesDesafio');

  @override
  Map<dynamic, dynamic> get recordesDesafio {
    _$recordesDesafioAtom.reportRead();
    return super.recordesDesafio;
  }

  @override
  set recordesDesafio(Map<dynamic, dynamic> value) {
    _$recordesDesafioAtom.reportWrite(value, super.recordesDesafio, () {
      super.recordesDesafio = value;
    });
  }

  final _$recordesNormalAtom =
      Atom(name: 'RecordesRepositoryBase.recordesNormal');

  @override
  Map<dynamic, dynamic> get recordesNormal {
    _$recordesNormalAtom.reportRead();
    return super.recordesNormal;
  }

  @override
  set recordesNormal(Map<dynamic, dynamic> value) {
    _$recordesNormalAtom.reportWrite(value, super.recordesNormal, () {
      super.recordesNormal = value;
    });
  }

  final _$RecordesRepositoryBaseActionController =
      ActionController(name: 'RecordesRepositoryBase');

  @override
  dynamic loadRecordes() {
    final _$actionInfo = _$RecordesRepositoryBaseActionController.startAction(
        name: 'RecordesRepositoryBase.loadRecordes');
    try {
      return super.loadRecordes();
    } finally {
      _$RecordesRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recordesDesafio: ${recordesDesafio},
recordesNormal: ${recordesNormal}
    ''';
  }
}
