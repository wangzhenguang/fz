import 'package:flutter/material.dart';
import 'package:fz/model/photo/PhotoViewModule.dart';
import 'package:fz/style/FZTextStyle.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final PhotoViewModule data;

  PhotoViewPage(this.data);

  @override
  Widget build(BuildContext context) {
    var body;
    if (data.list.length == 1) {
      body = PhotoView(
        imageProvider: NetworkImage(data.list[0].getImgPath()),
      );
    } else {
      body = PageView.builder(
          controller: PageController(
            initialPage: data.curIndex,
          ),
          itemCount: data.list.length,
          itemBuilder: (context, index) {
            return PhotoViewInline(
              imageProvider: NetworkImage(data.list[index].getImgPath()),
            );
          });
    }

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double topPadding = mediaQuery.padding.top;
    var appbar = AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        "照片预览",
        style: FZTextStyle.normalTextWhite,
      ),
    );
    final double extent = appbar.preferredSize.height + topPadding;

    return Stack(
      children: <Widget>[
        body,
        Container(
          child: appbar,
          height: extent,
        )
      ],
    );
  }
}
