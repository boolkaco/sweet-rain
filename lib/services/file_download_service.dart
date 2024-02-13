import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sweetbonanzarain/services/logger.dart';

class FileDownloadService {
  String basePath = dotenv.env['DOMAIN_URL']!;
  static final FileDownloadService _instance = FileDownloadService._internal();

  factory FileDownloadService() {
    return _instance;
  }

  FileDownloadService._internal();

  Future<File?> loadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(basePath + url));
      if (response.statusCode != 200) {
        log.message('Network error: ${response.statusCode}');
        return null;
      }

      final directory = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final filePath = '${directory.path}/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      return file;
    } catch (e, t) {
      log.exception(e, t);
      return null;
    }
  }
}
