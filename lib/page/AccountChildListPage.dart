import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/dao/AccountDao.dart';
import 'package:gsy_github_app_flutter/common/model/Account.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/AccountUtils.dart';
import 'package:gsy_github_app_flutter/widget/AccountIndexItem.dart';
import 'package:gsy_github_app_flutter/widget/AccountItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYListState.dart';
import 'package:gsy_github_app_flutter/widget/GSYPullLoadWidget.dart';

/**
 * 账户子列表
 */
class AccountChildPage extends StatefulWidget {
  final String guid;

  AccountChildPage(this.guid);

  @override
  _AccountChildPageState createState() => _AccountChildPageState(guid);
}

class _AccountChildPageState extends State<AccountChildPage> with AutomaticKeepAliveClientMixin<AccountChildPage>, GSYListState<AccountChildPage> {
  final String guid;

  String searchText;
  String accountGuid;

  _AccountChildPageState(this.guid);

  _renderAccountItem(Account e) {
    AccountViewModel accountViewModel = AccountViewModel.fromMap(e);
    return new AccountIndexItem(
      accountViewModel,
      onPressed: () {
        AccountUtils.ActionUtils(context, e, "");
      },
    );
  }

  _getDataLogic(String guid) async {
    return await AccountDao.getChildrenDao(guid);
  }

  @override
  requestLoadMore() async {
    return await _getDataLogic(this.guid);
  }

  @override
  requestRefresh() async {
    return await _getDataLogic(this.guid);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get needHeader => false;

  @override
  bool get isRefreshFirst => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(GSYColors.mainBackgroundColor),
      body: GSYPullLoadWidget(
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderAccountItem(pullLoadWidgetControl.dataList[index]),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}
