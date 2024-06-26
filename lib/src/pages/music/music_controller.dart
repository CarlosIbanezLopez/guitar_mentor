import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicController {
  static const String apiUrl = 'http://3.145.61.237:3000/api/openai/generate-song?';

  Future<Map<String, dynamic>> fetchSong(String title, String author) async {
    final url = Uri.parse('${apiUrl}title=$title&author=$author');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load song');
    }
  }
}
