import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gsy_github_app_flutter/common/ab/provider/issue/IssueCommentDbProvider.dart';
import 'package:gsy_github_app_flutter/common/ab/provider/issue/IssueDetailDbProvider.dart';
import 'package:gsy_github_app_flutter/common/ab/provider/repos/RepositoryIssueDbProvider.dart';
import 'package:gsy_github_app_flutter/common/dao/DaoResult.dart';
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
  static createTxDao(tx) async {
    String url = Address.tx();
    var res = await HttpManager.netFetch(url, tx, null, new Options(method: 'POST'));
    if (res != null && res.result) {
      return new DataResult(res.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  /**
   * 获取tx 列表
   */
  static getTxDao(accountGuid, searchString, {sort, direction, page = 0}) async {
    next() async {
      String url = Address.tx() +
          Address.getPageParams("?", page) +
          (searchString != null || searchString.trim().length == 0 ? "" : "&q=" + searchString.trim()) +
          (accountGuid != null || accountGuid.trim().length == 0 ? "" : "&accountGuid=" + accountGuid.trim());
      var res = await HttpManager.netFetch(url, null, null, new Options(method: "get"));
      if (res != null && res.result) {
        List<Issue> list = new List();
        var data = res.data;
        if (data == null || data.length == 0) {
          return new DataResult(null, false);
        }
        for (int i = 0; i < data.length; i++) {
          list.add(Issue.fromJson(data[i]));
        }

        return new DataResult(list, true);
      } else {
        return new DataResult(null, false);
      }
    }

    return await next();
  }
}
