import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class NewsRepository {
  final Dio dio = Dio();

  Future addNews (
      {required String title,
      required String content,
      required String date,
      required File image}) async {
    try {
      FormData formData = FormData.fromMap({
        'judul': title,
        'deskripsi': content,
        'tanggal': date,
        'url_image':
            await MultipartFile.fromFile(image.path, filename: 'image.jpg')
      });

      Response response = await _dio.post(
        'https://client-server-nova.000webhostapp.com/addnews.php',
        data: formData,
      );

      log(response.data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add news');
      }
      } catch (error) {
        throw Exception('Error: $error');
      }
    }
}