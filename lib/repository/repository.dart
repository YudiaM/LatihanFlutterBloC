import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:shared preferences/shared preferences.dart';

class Repository {
  Future<bool> checkSession(String sessionToken) async {
    final Dio dio = Dio();

    try {
      //source check session di sini
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sessionToken = prefs.getString('session') ?? "";
      Map fdataMap = {'session_token': sessionToken};
      FormData fdata = FormData();
      fdata.fields.addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));
      final response = await _dio.post(
        'https://server-yudiam.000webhostapp.com/session.php',
        data: fdata,
      );

      log("check session $response");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.data);
        return data['status'] == 'success';
      }
      
    } catch (error){
      //handle error if needed
    }
    return false;
  }
}