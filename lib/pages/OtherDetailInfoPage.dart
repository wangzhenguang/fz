import 'package:flutter/material.dart';
import 'package:fz/model/user/UserDetailInfo.dart';
import 'package:fz/net/service/Api.dart';
import 'package:fz/style/FZColors.dart';

class OtherDetailInfoPage extends StatefulWidget {
  final String username;
  final String id;

  OtherDetailInfoPage(this.username, this.id);

  @override
  createState() => _OtherDetailInfoState();
}

class _OtherDetailInfoState extends State<OtherDetailInfoPage> {
  bool showLoading = true;
  UserDetailInfo info;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        centerTitle: false,
      ),
      body: showLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _renderPage(),
    );
  }

  void _requestUserInfo() {
    Api.getUserProfile(widget.id).then((UserDetailInfo info) {
      setState(() {
        showLoading = false;
        this.info = info;
      });
    });
  }

  _renderPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Image.network(
                info.avatar,
                width: 40.0,
                height: 40.0,
              ),
            ),
            Padding(
              child: Text(widget.username),
              padding: EdgeInsets.all(20.0),
            )
          ],
        ),

        //粉丝 关注 私信
        Row(
          children: <Widget>[
            _renderFansWidget("关注", info.follows_count),
            _renderFansWidget(
              "粉丝",
              info.fans_count,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: new Border.all(
                              color: Color(FZColors.cellBlackBg))),
                      child: Text("关注"),
                      height: 40.0,
                      padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40.0,
                      width: 40.0,
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: new Border.all(
                              color: Color(FZColors.cellBlackBg))),
                      child: Icon(
                        Icons.mail,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),

        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _renderFansWidget(
                "相册",
                info.photo_count,
              ),
            ),
            Expanded(
              flex: 1,
              child: _renderFansWidget(
                "记录",
                info.doing_count,
              ),
            ),
            Expanded(
              flex: 1,
              child: _renderFansWidget(
                "日志",
                info.blog_count,
              ),
            ),
          ],
        ),

        Divider(
          color: Color(FZColors.white),
        ),

        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => _renderItem(context, index),
            itemCount: _getListCount(),
          ),
        ),
      ],
    );
  }

  _renderFansWidget(name, count, {onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[Text(name), Text(count)],
        ),
      ),
    );
  }

  _renderItem(context, index) {
    var fieldInfo = info.fieldInfos[index];
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('${fieldInfo.name}：'),
          Flexible(
            child: Text(fieldInfo.value),
          )
        ],
      ),
    );
  }

  _getListCount() {
    return info.fieldInfos?.length;
  }
}
