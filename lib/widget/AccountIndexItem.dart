import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/widget/AccountItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYCardItem.dart';
import 'package:intl/intl.dart';

/**
 * 首页账户Item
 */
class AccountIndexItem extends StatelessWidget {
  final AccountViewModel accountViewModel;

  final VoidCallback onPressed;

  final bool needImage;

  final formatCurrency = new NumberFormat("#,##0.00", "zh_CN");

  AccountIndexItem(this.accountViewModel, {this.onPressed, this.needImage = true}) : super();

  @override
  Widget build(BuildContext context) {
    Widget des = (accountViewModel.pathName == null)
        ? new Container()
        : new Container(
            child: new Text(
              accountViewModel.pathName,
              style: GSYConstant.smallSubText,
              maxLines: 3,
            ),
            margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
            alignment: Alignment.topLeft);

    return new Container(
      child: new GSYCardItem(
          child: new FlatButton(
              onPressed: onPressed,
              child: new Padding(
                padding: new EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(child: new Text(accountViewModel.name, style: GSYConstant.smallTextBold)),
                        des,
                      ],
                    ),
                    new Container(child: new Text('${formatCurrency.format(accountViewModel.balance)}', style: GSYConstant.middleSubText), margin: new EdgeInsets.only(top: 6.0, bottom: 2.0), alignment: Alignment.topLeft),
                  ],
                ),
              ))),
    );
  }
}
