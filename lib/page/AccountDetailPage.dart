import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/CommonUtils.dart';
import 'package:gsy_github_app_flutter/page/AccountChildListPage.dart';
import 'package:gsy_github_app_flutter/page/AccountTxListPage.dart';
import 'package:gsy_github_app_flutter/widget/GSYCommonOptionWidget.dart';
import 'package:gsy_github_app_flutter/widget/GSYTabBarWidget.dart';
import 'package:gsy_github_app_flutter/widget/ReposHeaderItem.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gsy_github_app_flutter/widget/GSYTitleBar.dart';

/**
 * Account详情
 */
class AccountDetailPage extends StatefulWidget {
  final String guid;
  final String name;

  AccountDetailPage(this.guid, this.name);

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState(guid, name);
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  ReposHeaderViewModel reposHeaderViewModel = new ReposHeaderViewModel();

  final String guid;
  final String name;

  final TarWidgetControl tarBarControl = new TarWidgetControl();

  final AccountDetailModel accountDetailModel = new AccountDetailModel();

  final PageController topPageControl = new PageController();

  final OptionControl titleOptionControl = new OptionControl();

  _AccountDetailPageState(this.guid, this.name);

  _getReposStatus() async {
    setState(() {});
  }

  _refresh() {
    this._getReposStatus();
  }

  _renderTabItem() {
    var itemList = [
      CommonUtils.getLocale(context).account_tab_children,
      CommonUtils.getLocale(context).account_tab_tx,
    ];
    renderItem(String item, int i) {
      return new FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () {
            accountDetailModel.setCurrentIndex(i);
            topPageControl.jumpTo(MediaQuery.of(context).size.width * i);
          },
          child: new Text(
            item,
            style: GSYConstant.smallTextWhite,
            maxLines: 1,
          ));
    }

    List<Widget> list = new List();
    for (int i = 0; i < itemList.length; i++) {
      list.add(renderItem(itemList[i], i));
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<AccountDetailModel>(
      model: accountDetailModel,
      child: new ScopedModelDescendant<AccountDetailModel>(
        builder: (context, child, model) {
          return new GSYTabBarWidget(
            type: GSYTabBarWidget.TOP_TAB,
            tarWidgetControl: tarBarControl,
            tabItems: _renderTabItem(),
            tabViews: [
              new AccountChildPage(guid),
              new AccountTxPage(guid),
            ],
            topPageControl: topPageControl,
            backgroundColor: GSYColors.primarySwatch,
            indicatorColor: Color(GSYColors.white),
//            title: new GSYTitleBar(
//              name,
//              rightWidget: widget,
//            ),
            onPageChanged: (index) {
              accountDetailModel.setCurrentIndex(index);
            },
          );
        },
      ),
    );
  }
}

class AccountDetailModel extends Model {
  String _guid = "";
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  String get guid => _guid;

  static AccountDetailModel of(BuildContext context) => ScopedModel.of<AccountDetailModel>(context);

  void setGuid(String guid) {
    _guid = guid;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
