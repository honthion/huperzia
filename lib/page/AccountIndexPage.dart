import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/config/Config.dart';
import 'package:gsy_github_app_flutter/common/dao/EventDao.dart';
import 'package:gsy_github_app_flutter/common/dao/ReposDao.dart';
import 'package:gsy_github_app_flutter/common/dao/AccountDao.dart';
import 'package:gsy_github_app_flutter/common/model/Account.dart';
import 'package:gsy_github_app_flutter/common/redux/GSYState.dart';
import 'package:gsy_github_app_flutter/common/utils/AccountUtils.dart';
import 'package:gsy_github_app_flutter/widget/AccountItem.dart';
import 'package:gsy_github_app_flutter/widget/AccountIndexItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYListState.dart';
import 'package:gsy_github_app_flutter/widget/GSYPullLoadWidget.dart';
import 'package:redux/redux.dart';

/**
 * Account主页
 */
class AccountIndexPage extends StatefulWidget {
  @override
  _AccountIndexPageState createState() => _AccountIndexPageState();
}

class _AccountIndexPageState extends State<AccountIndexPage> with AutomaticKeepAliveClientMixin<AccountIndexPage>, GSYListState<AccountIndexPage>, WidgetsBindingObserver {
  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    var result = await AccountDao.getGnucashIndexDao(_getStore());
    setState(() {
      pullLoadWidgetControl.needLoadMore = (result != null);
    });
    isLoading = false;
    return null;
  }

  @override
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    var result = await AccountDao.getGnucashIndexDao(_getStore());
    setState(() {
      pullLoadWidgetControl.needLoadMore = (result != null);
    });
    isLoading = false;
    return null;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() {}

  @override
  requestLoadMore() {}

  @override
  bool get isRefreshFirst => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ReposDao.getNewsVersion(context, false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList = _getStore().state.accountList;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (pullLoadWidgetControl.dataList.length != 0) {
        showRefreshLoading();
      }
    }
  }

  _renderAccountItem(Account e) {
    AccountViewModel accountViewModel = AccountViewModel.fromMap(e);
    return new AccountIndexItem(
      accountViewModel,
      onPressed: () {
        AccountUtils.ActionUtils(context, e, "");
      },
    );
  }

  Store<GSYState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new StoreBuilder<GSYState>(
      builder: (context, store) {
        return GSYPullLoadWidget(
          pullLoadWidgetControl,
          (BuildContext context, int index) => _renderAccountItem(pullLoadWidgetControl.dataList[index]),
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
        );
      },
    );
  }
}

class ModelA {
  String name;
  String tag;

  ModelA(this.name, this.tag);

  ModelA.empty();

  ModelA.forName(this.name);
}
