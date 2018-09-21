import 'package:flutter/material.dart';
import 'package:fz/config/Config.dart';
import 'package:fz/model/FeedsModel.dart';
import 'package:fz/widget/FZUserIcon.dart';

class FeedsItem extends StatelessWidget {
  FeedsModel feedsModel;

  FeedsItem(this.feedsModel) : super();

  @override
  Widget build(BuildContext context) {
    var itemLayout = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[],
    );

    var itemHeader = Row(
      children: <Widget>[
        FZUserIcon(
          image: feedsModel.avatar,
          onPressed: null,
        ),
        Expanded(
            child: new Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                feedsModel.title,
                maxLines: 1,
                softWrap: true,
              ),
              Text(
                feedsModel.dateline,
              )
            ],
          ),
          margin: EdgeInsets.only(left: 5.0),
        )),
      ],
    );
    itemLayout.children.add(itemHeader);

    if (feedsModel.message != null && feedsModel.message.length > 0) {
      var titleMessage = Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          feedsModel.message,
        ),
      );
      itemLayout.children.add(titleMessage);
    }

    // 发布图片或者相册的动态
    if (feedsModel.idtype == Config.ALBUM_TYPE_ID ||
        feedsModel.idtype == Config.PIC_TYPE_ID) {
      num screenWidth = MediaQuery.of(context).size.width;
      //屏幕宽度 - 2边间隔 - 中间间隔
      double cellWidth = (screenWidth - 40.0 - 10.0) / 2;

      var images = new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FadeInImage.assetNetwork(
            width: cellWidth,
            fit: BoxFit.cover,
            height: cellWidth,
            placeholder: "static/images/bg.jpg",
            image: feedsModel.image_1,
          ),
          feedsModel.image_2 == null
              ? new Container(
                  width: cellWidth,
                  height: cellWidth,
                )
              : FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: cellWidth,
                  height: cellWidth,
                  placeholder: "static/images/bg.jpg",
                  image: feedsModel.image_2,
                ),
        ],
      );
      itemLayout.children.add(images);
    }

    var inkwell = InkWell(
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        elevation: 5.0,

        child: new Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: itemLayout),
      ),
      onTap: () {
        print("${feedsModel.message}  ${feedsModel.title_message}");
      },
    );

    return inkwell;
  }
}
