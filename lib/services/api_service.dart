import 'dart:convert'; // JSON 디코딩을 위해 필요
import 'package:http/http.dart' as http;
import '../models/exhibition.dart';

class ApiService {

  final String baseUrl = "http://localhost:8080";

  ApiService();

  Future<List<Exhibition>> fetchExhibitions({int page = 0, int pageSize = 20}) async {
    try {
      // 페이지와 페이지 크기를 쿼리 파라미터로 포함하여 요청
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/exhibitions?page=$page&pageSize=$pageSize'),
        headers: {
          'User-Agent': 'PostmanRuntime/7.41.2',
          'Accept': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Cache-Control': 'no-cache',
        },
      );

      if (response.statusCode == 200) {
        // JSON 파싱
        final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
        final exhibitions = decodedBody['content'] as List;  // `content`는 Page의 내용

        // Exhibition 모델에 맞게 변환
        return exhibitions.map((exhibition) => Exhibition.fromJson(exhibition)).toList();
      } else {
        throw Exception('Failed to load exhibitions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
