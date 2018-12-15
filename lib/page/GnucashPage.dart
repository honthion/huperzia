import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/dao/AccountDao.dart';
import 'package:gsy_github_app_flutter/common/redux/GSYState.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/NavigatorUtils.dart';
import 'package:gsy_github_app_flutter/widget/AccountItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYListState.dart';
import 'package:gsy_github_app_flutter/widget/GSYPullLoadWidget.dart';
import 'package:redux/redux.dart';

/**
 * Gnucash主页
 */
class GnucashPage extends StatefulWidget {
  @override
  _GnucashPageState createState() => _GnucashPageState();
}

class _GnucashPageState extends State<GnucashPage> with AutomaticKeepAliveClientMixin<GnucashPage>, GSYListState<GnucashPage> {
  _renderItem(e) {
    AccountViewModel accountViewModel = AccountViewModel.fromTrendMap(e);
    return new AccountItem(accountViewModel, onPressed: () {
      NavigatorUtils.goAccountDetail(context, accountViewModel.guid);
    });
  }

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    await AccountDao.getGnucashIndexDao(_getStore());
    setState(() {
      pullLoadWidgetControl.needLoadMore = false;
    });
    isLoading = false;
    return null;
  }

  @override
  requestRefresh() async {
    return null;
  }

  @override
  requestLoadMore() async {
    return null;
  }

  @override
  bool get isRefreshFirst => false;

  @override
  void dispose() {
    super.dispose();
    clearData();
  }

  Store<GSYState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new StoreBuilder<GSYState>(
      builder: (context, store) {
        return new Scaffold(
          backgroundColor: Color(GSYColors.mainBackgroundColor),
          body: GSYPullLoadWidget(
            pullLoadWidgetControl,
            (BuildContext context, int index) => _renderItem(pullLoadWidgetControl.dataList[index]),
            handleRefresh,
            onLoadMore,
            refreshKey: refreshIndicatorKey,
          ),
        );
      },
    );
  }
}
