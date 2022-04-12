import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:after_school/common/model/ImageModel.dart';
import 'package:after_school/common/resources/MyTextStyle.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/widget/MyWidget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:after_school/common/util/crop_editor_helper.dart';

/*
* https://github.com/fluttercandies/extended_image
*/
class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key, required this.imageState}) : super(key: key);
  final ModelImageState imageState;

  @override
  State<StatefulWidget> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  late bool _isFileImage;
  bool _cropping = false;
  // late String _networkImage;
  // late File _fileImage;
  // late Uint8List _test;

  @override
  void initState() {
    super.initState();
    widget.imageState.type == ModelImageState.FILE
        ? _isFileImage = true
        : _isFileImage = false;
    // if (_isNetworkImage) {
    //   _networkImage = widget.imageState.image;
    // } else {
    //   _fileImage = widget.imageState.image;
    // }
  }

  Future<void> _cropImage() async {
    if (_cropping) {
      return;
    }
    try {
      _cropping = true;
      //await showBusyingDialog();

      Uint8List? fileData =
          await cropImageDataWithNativeLibrary(state: editorKey.currentState!);

      if (fileData != null) {
        widget.imageState.type = ModelImageState.EDIT;
        widget.imageState.image = fileData;
        Navigator.of(context).pop();
      }
    } catch (e, stack) {
      print('save failed: $e\n $stack');
    }
    _cropping = false;
  }

  Widget _editImage() {
    EditorConfig editorConfig = EditorConfig(
      maxScale: 8.0,
      cropRectPadding: const EdgeInsets.all(20.0),
      hitTestSize: 30.0,
      cornerColor: Colors.red,
      lineHeight: 2,
      lineColor: Colors.white,
      cropLayerPainter: CircleEditorCropLayerPainter()
      // lineColor: Colors.red,
    );

    switch(widget.imageState.type){
      case ModelImageState.FILE :
        return ExtendedImage.file(
          File(widget.imageState.image.path),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          enableLoadState: true,
          extendedImageEditorKey: editorKey,
          initEditorConfigHandler: (ExtendedImageState? state) {
            return editorConfig;
          },
          cacheRawData: true,
        );
      case ModelImageState.EDIT :
        return ExtendedImage.memory(
          widget.imageState.image,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          enableLoadState: true,
          extendedImageEditorKey: editorKey,
          initEditorConfigHandler: (ExtendedImageState? state) {
            return editorConfig;
          },
          cacheRawData: true,
        );
      default :
        return ExtendedImage.network(
          widget.imageState.image,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          enableLoadState: true,
          extendedImageEditorKey: editorKey,
          initEditorConfigHandler: (ExtendedImageState? state) {
            return editorConfig;
          },
          cacheRawData: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("이미지 편집", style: MyTextStyle.appbarTitleWhite),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: _cropImage,
            child: Text(Strings.check, style: MyTextStyle.appbarActionWhite),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: _editImage(),
              // ExtendedImage.file(
              //         _fileImage,
              //         fit: BoxFit.contain,
              //         mode: ExtendedImageMode.editor,
              //         enableLoadState: true,
              //         extendedImageEditorKey: editorKey,
              //         initEditorConfigHandler: (ExtendedImageState? state) {
              //           return EditorConfig(
              //             maxScale: 8.0,
              //             cropRectPadding: const EdgeInsets.all(20.0),
              //             hitTestSize: 30.0,
              //             cornerColor: Colors.red,
              //             // cropLayerPainter: CustomEditorCropLayerPainter()
              //             // lineColor: Colors.red,
              //           );
              //         },
              //         cacheRawData: true,
              //       )
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

//  코너 둥근모양
// class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
//   const CustomEditorCropLayerPainter();
//   @override
//   void paintCorners(
//       Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
//     final Paint paint = Paint()
//       ..color = painter.cornerColor
//       ..style = PaintingStyle.fill;
//     final Rect cropRect = painter.cropRect;
//     const double radius = 6;
//     canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
//     canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
//     canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
//     canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
//   }
// }
//
// //  둥근 이미지
class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Paint paint = Paint()
      ..color = painter.cornerColor
      ..style = PaintingStyle.fill;
    final Rect cropRect = painter.cropRect;
    const double radius = 6;
    canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
  }

  @override
  void paintMask(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect rect = Offset.zero & size;
    final Rect cropRect = painter.cropRect;
    final Color maskColor = painter.maskColor;
    canvas.saveLayer(rect, Paint());
    canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = maskColor);
    canvas.drawCircle(cropRect.center, min(cropRect.width, cropRect.height) / 2.0,
        Paint()..blendMode = BlendMode.clear);  //clear
    canvas.restore();
  }

  //  격자
  // @override
  // void paintLines(
  //     Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
  //   final Rect cropRect = painter.cropRect;
  //   if (painter.pointerDown) {
  //     canvas.save();
  //     canvas.clipPath(Path()..addOval(cropRect));
  //     super.paintLines(canvas, size, painter);
  //     canvas.restore();
  //   }
  // }
}
