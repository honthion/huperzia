// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
      json['id'] as int,
      json['name'] as String,
      json['guid'] as String,
      json['path'] as String,
      json['path_name'] as String,
      json['commodity_guid'] as String,
      json['parent_guid'] as String,
      (json['balance'] as num)?.toDouble(),
      json['account_type'] as String,
      (json['children'] as List)
          ?.map((e) =>
              e == null ? null : Account.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['allIssueCount'] as int);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'guid': instance.guid,
      'path': instance.path,
      'path_name': instance.pathName,
      'commodity_guid': instance.commodityGuid,
      'parent_guid': instance.parentGuid,
      'balance': instance.balance,
      'account_type': instance.accountType,
      'children': instance.children,
      'allIssueCount': instance.allIssueCount
    };
