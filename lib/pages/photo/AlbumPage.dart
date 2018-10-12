import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  bool firstIn = true;

  @override
  Widget build(BuildContext context) {
    return firstIn
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Text(" albumpage");
  }
}
