import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future<Map<String, dynamic>> obtenerDatos(
      String username, String mail, String password) async {
    final url = Uri.parse('http://192.168.100.13:2100/api/account/getUser');

    final body = json.encode({
      'user': [
        {
          'username': username,
          'mail': mail,
          'password': password,
        }
      ]
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Verificar si 'data' es nulo o no es un Map<String, dynamic>
      if (jsonData['data'] != null &&
          jsonData['data'] is Map<String, dynamic>) {
        final jsonFolderData = jsonData['data']['folders'][0];
        return jsonFolderData;
      } else {
        // Manejar el caso donde 'data' es nulo o no es el tipo esperado
        throw Exception('La respuesta de la API no contiene datos válidos.');
      }
    } else {
      // Manejo de errores
      throw Exception(
          'Error al cargar datos de la API: ${response.reasonPhrase}');
    }
  }
}
