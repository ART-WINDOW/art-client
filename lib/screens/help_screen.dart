import 'package:flutter/cupertino.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Center(
              //   child: Image.asset(
              //     'lib/assets/images/art-logo.png', // 이미지 경로
              //     height: 400,
              //   ),
              // ),
              Center(
                child: Text(
                  '\n안녕하세요 😊\n\n'
                  '아트 윈도우는 순수 사비로 1인 운영중인 서비스예요.\n\n'
                  '그래서 좋은 서비스를 만들기 위해 여러분의 도움이 필요해요.\n\n'
                  '아주 사소한 피드백이라도 보내주신다면 아주 큰 도움이 된답니다.\n\n'
                  '서비스 이용에 불편하셨던 점이나 추가적으로 지원했으면 하는 기능이 있으시다면\n\n'
                  '아래 이메일로 의견을 전달해주세요!\n',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                      'jang6129@naver.com\n\n'
                      '\n\n',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  '아트윈도우 이용 방법\n',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              Center(
                child: Text(
                  '전체 목록',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  '현재 진행중이거나 예정된 전시 목록이에요\n'
                  '최대한 누락 없이 많은 정보를 보여드리려고 노력중이에요!\n',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  '주요 전시',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  '국립현대미술관, 서울시립미술관 등 주요 전시관에서 진행중인 전시 목록이에요\n'
                  '전시관 선정 기준이 아직 미비해요. 많은 조언 부탁드려요!\n\n',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/guide1.png', // 이미지 경로
                  height: 400,
                ),
              ),
              // CupertinoButton(
              //   color: CupertinoColors.activeBlue,
              //   onPressed: () {
              //     // 버튼 클릭 시 동작 추가
              //   },
              //   child: Text('더 알아보기'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
