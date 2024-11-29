import 'dart:convert'; // JSON 데이터를 처리하기 위한 라이브러리
import 'package:http/http.dart' as http; // HTTP 요청을 보내기 위한 패키지
import '../models/exhibition.dart'; // Exhibition 모델을 가져옴
import '../models/museum.dart'; // Museum 모델을 가져옴

// ApiService 클래스는 API 요청을 처리하는 역할을 한다.
class ApiService {
  // API의 기본 URL
  final String baseUrl = 'https://art-window.duckdns.org/api/v1';
  // 테스트용 URL
  // final String baseUrl = 'http://localhost:8080/api/v1';

  // Exhibition 데이터를 페이지 단위로 가져오는 메서드
  Future<List<Exhibition>> fetchExhibitions({int page = 0, int pageSize = 15}) async {
    try {
      // http.get을 통해 GET 요청을 보낸다.
      final response = await http.get(
        Uri.parse('$baseUrl/exhibitions?page=$page&pageSize=$pageSize'),
        headers: {
          'Content-Type': 'application/json',
          // 'User-Agent': 'Mozilla/5.0 (Mobile)'
        },
      );

      // UTF-8로 디코딩된 응답 데이터
      final decodedBody = utf8.decode(response.bodyBytes);

      // 응답 코드가 200일 경우 (정상 응답)
      if (response.statusCode == 200) {
        // 응답 데이터를 JSON으로 파싱하고, UTF-8로 디코딩된 데이터를 사용
        final List<dynamic> jsonList = json.decode(decodedBody)['content'];

        // JSON 데이터를 Exhibition 객체로 변환하여 리스트로 반환
        return jsonList.map((json) => Exhibition.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load exhibitions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('API 호출 중 오류 발생: $e'); // 오류 로그 출력
      throw Exception('Failed to load exhibitions'); // 오류를 다시 던짐
    }
  }

  // Museum 데이터를 페이지 단위로 가져오는 메서드
  Future<List<Museum>> fetchMuseums({int page = 0, int pageSize = 9}) async {
    try {
      // http.get을 통해 GET 요청을 보낸다.
      final response = await http.get(
        Uri.parse('$baseUrl/museums?page=$page&pageSize=$pageSize'),
        headers: {
          'Content-Type': 'application/json',
          // 'User-Agent': 'Mozilla/5.0 (Mobile)'
        },
      );

      // UTF-8로 디코딩된 응답 데이터
      final decodedBody = utf8.decode(response.bodyBytes);

      // 응답 코드가 200일 경우 (정상 응답)
      if (response.statusCode == 200) {
        // 응답 데이터를 JSON으로 파싱하고, UTF-8로 디코딩된 데이터를 사용
        final List<dynamic> jsonList = json.decode(decodedBody)['content'];

        // JSON 데이터를 Museum 객체로 변환하여 리스트로 반환
        return jsonList.map((json) => Museum.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load museums. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('API 호출 중 오류 발생: $e'); // 오류 로그 출력
      throw Exception('Failed to load museums'); // 오류를 다시 던짐
    }
  }

  // Major Exhibitions(주요 전시회) 데이터를 가져오는 메서드
  Future<List<Exhibition>> fetchMajorExhibitions({int page = 0, int pageSize = 9}) async {
    try {
      // 주요 전시회의 데이터를 가져오기 위해 별도의 API 엔드포인트 호출
      final response = await http.get(
        Uri.parse('$baseUrl/exhibitions/major?page=$page&pageSize=$pageSize'),
        headers: {
          'Content-Type': 'application/json',
          // 'User-Agent': 'Mozilla/5.0 (Mobile)'
        },
      );

      // UTF-8로 디코딩된 응답 데이터
      final decodedBody = utf8.decode(response.bodyBytes);

      // 응답 코드가 200일 경우 (정상 응답)
      if (response.statusCode == 200) {
        // 응답 데이터를 JSON으로 파싱하고, UTF-8로 디코딩된 데이터를 사용
        final List<dynamic> jsonList = json.decode(decodedBody)['content'];

        // JSON 데이터를 Exhibition 객체로 변환하여 리스트로 반환
        return jsonList.map((json) => Exhibition.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load major exhibitions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('API 호출 중 오류 발생: $e'); // 오류 로그 출력
      throw Exception('Failed to load major exhibitions'); // 오류를 다시 던짐
    }
  }
}