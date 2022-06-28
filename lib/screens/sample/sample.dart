import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  GlobalKey globalKey = new GlobalKey();

  Future<void> _capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);
    // print(pngBytes);
    print(bs64);

    final decodedBytes = base64Decode(bs64);
    var file = Io.File("decodedBezkoder.png");
    file.writeAsBytesSync(decodedBytes);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Center(
        child: TextButton(
          child: const Text('Hello World', textDirection: TextDirection.ltr),
          onPressed: _capturePng,
        ),
      ),
    );
  }
}
