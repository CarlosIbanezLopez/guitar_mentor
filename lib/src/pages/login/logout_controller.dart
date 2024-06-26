import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../../components/config.dart';

class LogoutController {
  final String apiUrl = '${Config.apiUrl}/logout';
  final Dio dio = Dio();

  LogoutController() {
    dio.interceptors.add(CookieManager(CookieJar()));
  }

  Future<bool> logout(String email, String password, String token) async {
    try {
      final response = await dio.post(
        apiUrl,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody['status'] == 'success') {
          // Clear cookies after successful logout
          await CookieJar().deleteAll();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.statusCode} ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      return false;
    }
  }
}
