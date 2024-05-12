import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Api {
  static Future<Map<String, dynamic>> obtenerDatos() async {
    // Lee el contenido del archivo JSON desde la carpeta de activos
    String jsonString = await rootBundle.loadString('assets/Files.json');

    // Decodifica el contenido JSON en un mapa de strings dinámicos
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Retorna el mapa de datos cargados desde el archivo JSON
    return jsonData;
  }
}
