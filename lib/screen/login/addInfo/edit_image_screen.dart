import 'dart:io';

import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/widget/MyWidget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*
* https://github.com/fluttercandies/extended_image
*/
class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key, required this.imageFile}) : super(key: key);
  final XFile imageFile;

  @override
  State<StatefulWidget> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
  GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("이미지 편집",style: MyTextStyle.appbarTitleWhite),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text(Strings.check, style: MyTextStyle.appbarActionWhite),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ExtendedImage.memory(
                File(widget.imageFile.path).readAsBytesSync(),
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                enableLoadState: true,
                extendedImageEditorKey: editorKey,
                initEditorConfigHandler: (ExtendedImageState? state) {
                  return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: const EdgeInsets.all(20.0),
                    hitTestSize: 30.0,
                    cornerColor: Colors.red,
                    // lineColor: Colors.red,
                  );
                },
                cacheRawData: true,
              )
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomAppBar(
        color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextButtonWithIcon(
                icon: const Icon(Icons.flip, color: Colors.white),
                label: const Text(
                  Strings.editImageBottomFlip,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  editorKey.currentState!.flip();
                },
              ),
              TextButtonWithIcon(
                icon: const Icon(Icons.rotate_left, color: Colors.white),
                label: const Text(
                  Strings.editImageBottomRotateLeft,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  editorKey.currentState!.rotate(right: false);
                },
              ),
              TextButtonWithIcon(
                icon: const Icon(Icons.rotate_right, color: Colors.white),
                label: const Text(
                  Strings.editImageBottomRotateRight,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  editorKey.currentState!.rotate(right: true);
                },
              ),
              TextButtonWithIcon(
                icon: const Icon(Icons.restore, color: Colors.white),
                label: const Text(
                  Strings.editImageBottomReset,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  editorKey.currentState!.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}