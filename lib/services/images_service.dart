// ignore_for_file: implementation_imports, library_prefixes

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweetbonanzarain/services/logger.dart';

class ImagesService {
  String basePath = dotenv.env['DOMAIN_URL']!;
  final _imageCaches = <String, File>{};

  static final ImagesService _instance = ImagesService._internal();

  factory ImagesService() {
    return _instance;
  }

  ImagesService._internal();


  Future<ui.Image> loadImage(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<ImageComposition.Image?> getImageByFilename(String fileName) async {
    try {
      final file = _imageCaches[basePath + fileName];
      if (file == null) return null;

      final bytes = await file.readAsBytes();
      final codec = await instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();

      return frame.image;
    } catch (e, t) {
      log.exception(e, t);
      return null;
    }
  }

  Future<void> add({
    required String fileName,
    required File file,
  }) async {
    try {
      _imageCaches[basePath + fileName] = file;
    } catch (e, t) {
      log.exception(e, t);
    }
  }

  File? getByFilename(String fileName) {
    try {
      return _imageCaches[basePath + fileName];
    } catch (e, t) {
      log.exception(e, t);
      return null;
    }
  }

  bool isCached(String fileName) {
    return _imageCaches.containsKey(fileName);
  }
}
