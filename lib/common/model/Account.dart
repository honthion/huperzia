import 'package:json_annotation/json_annotation.dart';

part 'Account.g.dart';

@JsonSerializable()
class Account {
  int id;

  String name;

  String guid;

  String path;

  @JsonKey(name: "path_name")
  String pathName;

  @JsonKey(name: "commodity_guid")
  String commodityGuid;

  @JsonKey(name: "parent_guid")
  String parentGuid;

  double balance;

  @JsonKey(name: "account_type")
  String accountType;

  List<Account> children;

  ///issue总数，不参加序列化
  int allIssueCount;

  Account(
      this.id,
      this.name,
      this.guid,
      this.path,
      this.pathName,
      this.commodityGuid,
      this.parentGuid,
      this.balance,
      this.accountType,
      this.children,
      this.allIssueCount);

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
