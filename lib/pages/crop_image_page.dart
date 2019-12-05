import 'dart:io';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;

class CropImagePage extends StatefulWidget {
  final File imageFile;

  const CropImagePage({Key key, this.imageFile}) : super(key: key);

  @override
  _CropImagePageState createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      backgroundColor: Color(0xff010101),
      body: ExtendedImage.file(
        widget.imageFile,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editorKey,
        initEditorConfigHandler: (state) {
          return EditorConfig(
            maxScale: 8,
            cropRectPadding: EdgeInsets.all(20),
            hitTestSize: 20,
            cropAspectRatio: 1,
            eidtorMaskColorHandler: (context, pointerDown) {
              return Color(0xff2b2b2b).withOpacity(pointerDown ? 0.4 : 0.8);
            },
          );
        },
      ),
      bottomNavigationBar: _bottomBar,
    );
  }

  /// AppBar
  Widget get _appbar {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close),
      ),
      title: Text('裁剪'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.done),
          padding: EdgeInsets.symmetric(horizontal: 16),
          onPressed: ()async{
            Uint8List data = editorKey.currentState.rawImageData;
          },
        ),
      ],
      textTheme: Theme.of(context).textTheme,
    );
  }

  /// BottomNavigationBar
  Widget get _bottomBar {
    return BottomAppBar(
      color: AppBarTheme.of(context).color,
      shape: CircularNotchedRectangle(),
      child: ButtonTheme(
        minWidth: 0,
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.flip, size: 37.5),
                onPressed: () {
                  editorKey.currentState.flip();
                },
              ),
              IconButton(
                icon: Icon(Icons.rotate_left, size: 37.5),
                onPressed: () {
                  editorKey.currentState.rotate(right: false);
                },
              ),
              IconButton(
                icon: Icon(Icons.rotate_right, size: 37.5),
                onPressed: () {
                  editorKey.currentState.rotate(right: true);
                },
              ),
              IconButton(
                icon: Icon(Icons.restore, size: 37.5),
                onPressed: () {
                  editorKey.currentState.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
