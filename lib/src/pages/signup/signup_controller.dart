import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../components/config.dart';


class SignupController {
  static const apiUrl = '${Config.apiUrl}/register'; // Reemplaza con la URL de tu servidor API

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}, // Aseguramos que el servidor espera JSON
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );



      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': 'Registro exitoso',
          'user': data['usuario'],
        };
      } else {
        print('3');
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': 'Error de registro: ${data['message']}',
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': 'Ocurrió un error inesperado',
      };
    }
  }
}
