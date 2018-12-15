import 'package:dio/dio.dart';
import 'package:gsy_github_app_flutter/common/dao/DaoResult.dart';
import 'package:gsy_github_app_flutter/common/model/Account.dart';
import 'package:gsy_github_app_flutter/common/net/Address.dart';
import 'package:gsy_github_app_flutter/common/net/Api.dart';
import 'package:gsy_github_app_flutter/common/redux/AccountRedux.dart';
import 'package:redux/redux.dart';

class AccountDao {
  /**
   * 获取主页信息
   */
  static getGnucashIndexDao(Store store) async {
    String url = Address.getGnucashIndex();
    try {
      var res = await HttpManager.netFetch(url, null, null, new Options(method: 'GET'));
      if (res != null && res.data != null) {
        print(res);
        List<Account> list = new List();
        var data = res.data['data'];
        if (data == null || data.length == 0) {
          return null;
        }
        for (int i = 0; i < data.length; i++) {
          var cur = data[i];
          Account model = new Account(0, cur['name'], cur['guid'], cur['path'], cur['path_name'], cur['commodity_guid'], cur['parent_guid'], cur['balance'], cur['account_type'], null, 0);
          list.add(model);
        }
        if (list != null && list.length > 0) {
          store.dispatch(new RefreshAccountAction(list));
          return list;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  /**
   * 获取子项信息
   */
  static getChildrenDao(String guid) async {
    String url = Address.accountChild(guid);
    try {
      var res = await HttpManager.netFetch(url, null, null, new Options(method: 'GET'));
      if (res != null && res.data != null) {
        print(res);
        List<Account> list = new List();
        var data = res.data['data'];
        if (data == null || data.length == 0) {
          return  new DataResult(null, false);
        }
        for (int i = 0; i < data.length; i++) {
          var cur = data[i];
          Account model = new Account(0, cur['name'], cur['guid'], cur['path'], cur['path_name'], cur['commodity_guid'], cur['parent_guid'], cur['balance'], cur['account_type'], null, 0);
          list.add(model);
        }
        if (list != null && list.length > 0) {
          return  new DataResult(list, true);
        }
      }
    } catch (e) {
      print(e);
    }
    return  new DataResult(null, false);
  }

  static clearEvent(Store store) {
    store.state.eventList.clear();
    store.dispatch(new RefreshAccountAction([]));
  }
}
