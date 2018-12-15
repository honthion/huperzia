import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gsy_github_app_flutter/common/dao/DaoResult.dart';
import 'package:gsy_github_app_flutter/common/model/Tx.dart';
import 'package:gsy_github_app_flutter/common/model/Issue.dart';
import 'package:gsy_github_app_flutter/common/net/Address.dart';
import 'package:gsy_github_app_flutter/common/net/Api.dart';

/**
 * 交易相关
 */

class TxDao {
  /**
   * 创建tx
   *
   */
//  static createTxDao(tx) async {
//    String url = Address.tx();
//    var res = await HttpManager.netFetch(url, tx, null, new Options(method: 'POST'));
//    if (res != null && res.result) {
//      return new DataResult(res.data, true);
//    } else {
//      return new DataResult(null, false);
//    }
//  }

  /**
   * 获取tx 列表
   */
  static getTxDao(accountGuid, searchString, {sort, direction, page = 0}) async {
    next() async {
      String url = Address.searchTx(accountGuid) + Address.getPageParams("?", page);
      var res = await HttpManager.netFetch(url, null, null, new Options(method: "get"));
      if (res != null && res.result!=null) {
        List<Tx> list = new List();
        var data = res.data['list'];
        if (data == null || data.length == 0) {
          return new DataResult(null, false);
        }
        for (int i = 0; i < data.length; i++) {
          var tx = data[i];
//          list.add(Tx(tx['guid'], tx['name'], tx['enter_date'], tx['description'], tx['quantity_num'], tx['name_path'], tx['account_guid']));
          list.add(Tx.fromJson(data[i]));
        }

        return new DataResult(list, true);
      } else {
        return new DataResult(null, false);
      }
    }

    return await next();
  }
}
