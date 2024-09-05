import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../models/exhibition.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Exhibition>> fetchExhibitions() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);
      final rows = document.findAllElements('row');
      return rows.map((row) => Exhibition.fromXml(row)).toList();
    } else {
      throw Exception('Failed to load exhibitions');
    }
  }
}
