import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../components/config.dart';

class LoginController {
  static const apiUrl = '${Config.apiUrl}/login'; // Reemplaza con la URL de tu punto de inicio de sesión

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, String> bodyData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(bodyData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        // Accede al token dentro del campo anidado 'data'
        final token = data['data']['token'];
        print(token);
        return {
          'success': true,
          'message': 'Inicio de sesión exitoso',
          'token': token,
        };
      } else {
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': 'Error de inicio de sesión: ${data['message']}',
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }
}
