import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:universal_html/html.dart' as html;
import '../models/pictogram.dart';

class DownloadService {
  /// Descarga una imagen individual como archivo
  static Future<bool> downloadImage(String url, String filename) async {
    try {
      // Descargar la imagen
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        return false;
      }

      // Crear blob y descargar
      final blob = html.Blob([response.bodyBytes], 'image/png');
      final blobUrl = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: blobUrl)
        ..setAttribute('download', filename)
        ..style.display = 'none';

      html.document.body?.append(anchor);
      anchor.click();

      // Limpiar
      await Future.delayed(const Duration(milliseconds: 100));
      anchor.remove();
      html.Url.revokeObjectUrl(blobUrl);

      return true;
    } catch (e) {
      print('Error descargando imagen: $e');
      return false;
    }
  }

  /// Descarga múltiples pictogramas como archivo ZIP
  static Future<bool> downloadPictogramsAsZip(
    List<Pictogram> pictograms,
    String zipFilename, {
    void Function(int current, int total)? onProgress,
  }) async {
    try {
      final archive = Archive();
      int downloaded = 0;

      for (var pictogram in pictograms) {
        try {
          // Descargar la imagen
          final url = pictogram.getImageUrl();
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            // Añadir al archivo ZIP
            final filename = '${_sanitizeFilename(pictogram.firstKeyword)}_${pictogram.id}.png';
            final file = ArchiveFile(
              filename,
              response.bodyBytes.length,
              response.bodyBytes,
            );
            archive.addFile(file);
          }

          downloaded++;
          onProgress?.call(downloaded, pictograms.length);

          // Pequeña pausa para no saturar el servidor
          if (downloaded % 10 == 0) {
            await Future.delayed(const Duration(milliseconds: 100));
          }
        } catch (e) {
          print('Error descargando pictograma ${pictogram.id}: $e');
          // Continuar con el siguiente
        }
      }

      if (archive.files.isEmpty) {
        return false;
      }

      // Codificar como ZIP
      final zipEncoder = ZipEncoder();
      final zipBytes = zipEncoder.encode(archive);

      if (zipBytes == null) {
        return false;
      }

      // Crear blob y descargar
      final blob = html.Blob([Uint8List.fromList(zipBytes)], 'application/zip');
      final blobUrl = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: blobUrl)
        ..setAttribute('download', zipFilename)
        ..style.display = 'none';

      html.document.body?.append(anchor);
      anchor.click();

      // Limpiar
      await Future.delayed(const Duration(milliseconds: 100));
      anchor.remove();
      html.Url.revokeObjectUrl(blobUrl);

      return true;
    } catch (e) {
      print('Error creando ZIP: $e');
      return false;
    }
  }

  /// Sanitiza nombres de archivo para que sean válidos
  static String _sanitizeFilename(String filename) {
    return filename
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
        .replaceAll(' ', '_')
        .toLowerCase();
  }
}
