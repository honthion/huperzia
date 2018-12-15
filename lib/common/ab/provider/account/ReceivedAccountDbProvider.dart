import 'dart:async';
import 'dart:convert';

import 'package:gsy_github_app_flutter/common/ab/SqlProvider.dart';
import 'package:gsy_github_app_flutter/common/model/Account.dart';
import 'package:sqflite/sqflite.dart';

/**
 * 账户接受事件表
 * Created by guoshuyu
 * Date: 2018-08-07
 */

class ReceivedAccountDbProvider extends BaseDbProvider {
  final String name = 'ReceivedAccount';

  final String columnGuid = "_guid";
  final String columnData = "data";

  String guid;
  String data;

  ReceivedAccountDbProvider();

  Map<String, dynamic> toMap(String eventMapString) {
    Map<String, dynamic> map = {columnData: eventMapString};
    if (guid != null) {
      map[columnGuid] = guid;
    }
    return map;
  }

  ReceivedAccountDbProvider.fromMap(Map map) {
    guid = map[columnGuid];
    data = map[columnData];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnGuid) +
        '''
        $columnData text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  ///插入到数据库
  Future insert(String eventMapString) async {
    Database db = await getDataBase();

    ///清空后再插入，因为只保存第一页面
    db.execute("delete from $name");
    return await db.insert(name, toMap(eventMapString));
  }

  ///获取事件数据
  Future<List<Account>> getEvents() async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(name, columns: [columnGuid, columnData]);
    List<Account> list = new List();
    if (maps.length > 0) {
      ReceivedAccountDbProvider provider = ReceivedAccountDbProvider.fromMap(maps.first);
      List<dynamic> eventMap = json.decode(provider.data);
      if (eventMap.length > 0) {
        for (var item in eventMap) {
          list.add(Account.fromJson(item));
        }
      }
    }
    return list;
  }
}