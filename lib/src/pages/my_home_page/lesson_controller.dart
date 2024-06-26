import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../components/config.dart';

class LessonController {
  Future<List<dynamic>> lections() async {
    try {
      final response = await http.get(Uri.parse('${Config.apiUrl}/leccion/1'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success' && jsonData.containsKey('data') && jsonData['data'] is List) {

          return List<dynamic>.from(jsonData['data']);
        } else {
          throw Exception('Error al cargar los datos: JSON no contiene una lista válida');
        }
      } else if (response.statusCode == 404) {
        throw Exception('Error al cargar los datos: Recurso no encontrado');
      } else {
        throw Exception('Error al cargar los datos: ${response.statusCode}');
      }
    } catch (e) {

      throw Exception('Error al cargar los datos: $e');
    }
  }
}
