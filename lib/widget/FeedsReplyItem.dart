import 'package:flutter/material.dart';
import 'package:fz/model/feeds/DetailItem.dart';
import 'package:fz/style/FZColors.dart';
import 'package:fz/widget/FZUserIcon.dart';

class FeedsReplyItem extends StatelessWidget {
  DetailItem detailItem;

  FeedsReplyItem(this.detailItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FZUserIcon(
            image: detailItem.avatar,
            onPressed: () {
              print(' 查看他人信息 ');
            },
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    detailItem.userName,
                    style: TextStyle(color: Color(FZColors.textGray),fontSize: 12.0),
                  ),

                  Text(
                    detailItem.content,
                    style: TextStyle(color: Color(FZColors.textGray),fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          Text(
            detailItem.dateline,
            style: TextStyle(color: Color(FZColors.textGray)),
          )
        ],
      ),
    );
  }
}
