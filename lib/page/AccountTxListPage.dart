import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/dao/TxDao.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/CommonUtils.dart';
import 'package:gsy_github_app_flutter/widget/GSYListState.dart';
import 'package:gsy_github_app_flutter/widget/GSYPullLoadWidget.dart';
import 'package:gsy_github_app_flutter/widget/TxItem.dart';

/**
 * 账户交易列表
 */
class AccountTxPage extends StatefulWidget {
  final String guid;

  AccountTxPage(this.guid);

  @override
  _AccountTxPageState createState() => _AccountTxPageState(guid);
}

class _AccountTxPageState extends State<AccountTxPage> with AutomaticKeepAliveClientMixin<AccountTxPage>, GSYListState<AccountTxPage> {
  final String guid;

  String searchText;
  String accountGuid;

  _AccountTxPageState(this.guid);

  _renderEventItem(index) {
    TxItemViewModel txItemViewModel = TxItemViewModel.fromMap(pullLoadWidgetControl.dataList[index]);
    return new TxItem(txItemViewModel, null, null, false, false);
  }

  _getDataLogic(String guid, String searchString) async {
    return await TxDao.getTxDao(guid, searchString, page: page);
  }

//
//  _createTx() {
//    String title = "";
//    String content = "";
//    CommonUtils.showEditDialog(context, CommonUtils.getLocale(context).tx_edit_tx, (titleValue) {
//      title = titleValue;
//    }, (contentValue) {
//      content = contentValue;
//    }, () {
//      if (title == null || title.trim().length == 0) {
//        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).tx_edit_tx_title_not_be_null);
//        return;
//      }
//      if (content == null || content.trim().length == 0) {
//        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).tx_edit_tx_content_not_be_null);
//        return;
//      }
//      CommonUtils.showLoadingDialog(context);
//      //提交修改
//      TxDao.createTxDao({"title": title, "body": content}).then((result) {
//        showRefreshLoading();
//        Navigator.pop(context);
//        Navigator.pop(context);
//      });
//    }, needTitle: true, titleController: new TextEditingController(), valueController: new TextEditingController());
//  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get needHeader => false;

  @override
  bool get isRefreshFirst => true;

  @override
  requestLoadMore() async {
    return await _getDataLogic(this.guid, this.searchText);
  }

  @override
  requestRefresh() async {
    return await _getDataLogic(this.guid, this.searchText);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            GSYICons.ISSUE_ITEM_ADD,
            size: 55.0,
            color: Color(GSYColors.textWhite),
          ),
          onPressed: () {
//            _createTx();
          }),
      backgroundColor: Color(GSYColors.mainBackgroundColor),
      body: GSYPullLoadWidget(
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderEventItem(index),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}
