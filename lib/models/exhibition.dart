import 'package:xml/xml.dart';

class Exhibition {
  final String instNm;           // 기관명
  final String title;            // 제목
  final String categoryNm;       // 카테고리 이름
  final String url;              // URL
  final String? addr;            // 주소 (Optional)
  final String eventTmInfo;      // 이벤트 시간 정보
  final String? partcptExpnInfo; // 참가 비용 정보 (Optional)
  final String telnoInfo;        // 전화번호
  final String hostInstNm;       // 주최 기관명
  final String hmpgUrl;          // 홈페이지 URL
  final String imageUrl;         // 이미지 URL
  final DateTime beginDe;        // 시작 일자
  final DateTime endDe;          // 종료 일자
  final DateTime writngDe;       // 작성 일자

  Exhibition({
    required this.instNm,
    required this.title,
    required this.categoryNm,
    required this.url,
    this.addr,
    required this.eventTmInfo,
    this.partcptExpnInfo,
    required this.telnoInfo,
    required this.hostInstNm,
    required this.hmpgUrl,
    required this.imageUrl,
    required this.beginDe,
    required this.endDe,
    required this.writngDe,
  });

  // XML 데이터를 Dart 객체로 변환하는 메서드
  factory Exhibition.fromXml(XmlElement xml) {
    return Exhibition(
      instNm: xml.getElement('INST_NM')?.text ?? '',
      title: xml.getElement('TITLE')?.text ?? '',
      categoryNm: xml.getElement('CATEGORY_NM')?.text ?? '',
      url: xml.getElement('URL')?.text ?? '',
      addr: xml.getElement('ADDR')?.text,
      eventTmInfo: xml.getElement('EVENT_TM_INFO')?.text ?? '',
      partcptExpnInfo: xml.getElement('PARTCPT_EXPN_INFO')?.text,
      telnoInfo: xml.getElement('TELNO_INFO')?.text ?? '',
      hostInstNm: xml.getElement('HOST_INST_NM')?.text ?? '',
      hmpgUrl: xml.getElement('HMPG_URL')?.text ?? '',
      imageUrl: xml.getElement('IMAGE_URL')?.text ?? '',
      beginDe: DateTime.parse(xml.getElement('BEGIN_DE')?.text ?? ''),
      endDe: DateTime.parse(xml.getElement('END_DE')?.text ?? ''),
      writngDe: DateTime.parse(xml.getElement('WRITNG_DE')?.text ?? ''),
    );
  }
}
