import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/model/Tx.dart';
import 'package:gsy_github_app_flutter/common/style/GSYStyle.dart';
import 'package:gsy_github_app_flutter/common/utils/CommonUtils.dart';
import 'package:gsy_github_app_flutter/widget/GSYCardItem.dart';
import 'package:gsy_github_app_flutter/widget/GSYMarkdownWidget.dart';
import 'package:intl/intl.dart';

/**
 * 交易相关item
 */
class TxItem extends StatelessWidget {
  final TxItemViewModel txItemViewModel;

  ///点击
  final GestureTapCallback onPressed;

  ///长按
  final GestureTapCallback onLongPress;

  ///是否需要底部状态
  final bool hideBottom;

  ///是否需要限制内容行数
  final bool limitComment;

  TxItem(this.txItemViewModel, this.onPressed, this.onLongPress, this.hideBottom, this.limitComment);

  final formatCurrency = new NumberFormat("#,##0.00", "zh_CN");

  ///描述内容
  _renderDesText() {
    return (limitComment)
        ? new Container(
            child: new Text(
              "" + txItemViewModel.description,
              style: GSYConstant.smallSubText,
              maxLines: limitComment ? 2 : 1000,
            ),
            margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
            alignment: Alignment.topLeft,
          )
        : GSYMarkdownWidget(markdownData: txItemViewModel.description);
  }

  ///描述内容
  _renderPathText() {
    return new Container(
            child: new Text(
              "" + txItemViewModel.namePath,
              style: GSYConstant.smallSubText,
              maxLines: limitComment ? 2 : 1000,
            ),
            margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
            alignment: Alignment.topRight,
          );
  }

  @override
  Widget build(BuildContext context) {
    return new GSYCardItem(
      child: new InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        child: new Padding(
          padding: new EdgeInsets.only(left: 5.0, top: 5.0, right: 10.0, bottom: 8.0),
          child: new Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            new Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      ///金额
                      new Expanded(child: new Text(" | ${formatCurrency.format(txItemViewModel.quantityNum)}", style: GSYConstant.smallTextBold)),
                      // 日期
                      new Text(
                        txItemViewModel.enterDate,
                        style: GSYConstant.smallSubText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  ///备注
                  _renderDesText(),

                  ///评论内容
                  _renderPathText(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class TxItemViewModel {
  String guid = "---";
  String name = "---";
  String enterDate = "---";
  String description = "---";
  double quantityNum = 0.0;
  String namePath = "---";
  String accountGuid = "---";

  TxItemViewModel();

  TxItemViewModel.fromMap(Tx txMap) {
    enterDate = CommonUtils.getNewsTimeStr(txMap.enterDate);
    guid = txMap.guid;
    name = txMap.name;
    description = txMap.description;
    quantityNum = txMap.quantityNum;
    namePath = txMap.namePath;
    accountGuid = txMap.accountGuid;
  }
}
