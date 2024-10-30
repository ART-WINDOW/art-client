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
              Center(
                child: Image.asset(
                  'lib/assets/images/art-logo.png', // 이미지 경로
                  height: 400,
                ),
              ),
              Center(
                child: Text(
                  '안녕하세요 😊\n\n'
                  '아트 윈도우는 가볍게 전시 보러 가고 싶을 때 이용할 수 있는 무료 전시 정보 서비스예요.\n\n'
                  '전시 정보가 여러 군데 흩어져 있어서 찾기 불편하잖아요?\n\n'
                  '그래서 제가 직접 만들어 보았습니다. 현재 완전히 사비로 유지되고 있습니다.\n\n'
                  '아직 부족한 점이 많지만, 지속적으로 발전시켜 나가겠습니다.\n\n'
                  '건의사항이나 궁금한 점이 있으시면 jang6129@naver.com 이메일로 연락 부탁드려요.\n\n'
                  '감사합니다!\n\n',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  '아트윈도우 이용 방법 ⬇️\n',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              Center(
                child: Text(
                  '\'전체 목록\' 은 현재 진행중인 전체 전시 목록이에요\n'
                  '최대한 누락 없이 많은 정보를 보여드리려고 노력중이에요!\n\n'
                  '\'주요 전시\' 는 국립현대미술관, 서울시립미술관 등 주요 전시관에서 진행중인 전시 목록이에요\n'
                  '전시관 선정 기준이 아직 미비합니다.. 많은 조언 부탁드려요!\n\n',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Image.asset(
                  'lib/assets/images/guide1.png', // 이미지 경로
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
