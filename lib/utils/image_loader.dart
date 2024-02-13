import 'package:sweetbonanzarain/services/file_download_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/services/logger.dart';

class ImageLoader {
  static final ImageLoader _instance = ImageLoader._internal();

  factory ImageLoader() {
    return _instance;
  }

  ImageLoader._internal();

  Future<void> loadImage(String fileName) async {
    if (!ImagesService().isCached(fileName)) {
      final file = await FileDownloadService().loadFile(fileName);
      if (file == null) {
        log.message('Image $fileName not found');
      } else {
        await ImagesService().add(fileName: fileName, file: file);
      }
    }
  }
}
