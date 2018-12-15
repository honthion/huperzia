import 'package:json_annotation/json_annotation.dart';

part 'Tx.g.dart';

@JsonSerializable()
class Tx {
  String guid;
  String name;
  @JsonKey(name: "enter_date")
  DateTime enterDate;
  String description;
  @JsonKey(name: "quantity_num")
  double quantityNum;
  @JsonKey(name: "name_path")
  String namePath;
  @JsonKey(name: "account_guid")
  String accountGuid;

  Tx(this.guid, this.name, this.enterDate, this.description, this.quantityNum, this.namePath, this.accountGuid);

  factory Tx.fromJson(Map<String, dynamic> json) => _$TxFromJson(json);

  Map<String, dynamic> toJson() => _$TxToJson(this);
}
