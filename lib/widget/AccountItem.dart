import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/model/Account.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/widget/GSYCardItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYIConText.dart';

/**
 * 账户Item
 */
class AccountItem extends StatelessWidget {
  final AccountViewModel accountViewModel;

  final VoidCallback onPressed;

  AccountItem(this.accountViewModel, {this.onPressed}) : super();

  ///仓库item的底部状态，比如star数量等
  _getBottomItem(IconData icon, String text, {int flex = 2}) {
    return new Expanded(
      flex: flex,
      child: new Center(
        child: new GSYIConText(
          icon,
          text,
          GSYConstant.smallSubText,
          Color(GSYColors.subTextColor),
          15.0,
          padding: 5.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new GSYCardItem(
          child: new FlatButton(
              onPressed: onPressed,
              child: new Padding(
                padding: new EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ///仓库名
                              new Text(accountViewModel.name,
                                  style: GSYConstant.normalTextBold),
                            ],
                          ),
                        ),
                      ],
                    ),
                    new Container(
                        ///仓库描述
                        child: new Text(
                          accountViewModel.pathName,
                          style: GSYConstant.smallSubText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                        alignment: Alignment.topLeft),
                    new Padding(padding: EdgeInsets.all(10.0)),

                    ///金额
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _getBottomItem(GSYICons.ACCOUNT_BALANCE,
                            accountViewModel.balance.toString()),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}

class AccountViewModel {
  String guid;
  String name;
  String accountType;
  double balance;
  String commodityGuid;
  String parentGuid;
  String pathName;

  AccountViewModel();

  AccountViewModel.fromMap(Account data) {
    name = data.name;
    guid = data.guid;
    accountType = data.accountType;
    balance = data.balance;
    commodityGuid = data.commodityGuid;
    parentGuid = data.parentGuid;
    pathName = data.pathName;
  }

  AccountViewModel.fromTrendMap(model) {
    name = model.name;
    guid = model.guid;
    accountType = model.accountType;
    balance = model.balance;
    commodityGuid = model.commodityGuid;
    parentGuid = model.parentGuid;
    pathName = model.pathName;
  }
}
