// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tx.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tx _$TxFromJson(Map<String, dynamic> json) {
  return Tx(
      json['guid'] as String,
      json['name'] as String,
      json['enter_date'] == null
          ? null
          : DateTime.parse(json['enter_date'] as String),
      json['description'] as String,
      (json['quantity_num'] as num)?.toDouble(),
      json['name_path'] as String,
      json['account_guid'] as String);
}

Map<String, dynamic> _$TxToJson(Tx instance) => <String, dynamic>{
      'guid': instance.guid,
      'name': instance.name,
      'enter_date': instance.enterDate?.toIso8601String(),
      'description': instance.description,
      'quantity_num': instance.quantityNum,
      'name_path': instance.namePath,
      'account_guid': instance.accountGuid
    };
