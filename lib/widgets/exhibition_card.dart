import 'dart:html' as html;
import 'dart:ui_web';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/exhibition.dart';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition}) {
    // 스타일 추가
    final styleElement = html.StyleElement()
      ..text = '''
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
    ''';
    html.document.head?.append(styleElement);

    final String viewType = 'image-view-${exhibition.imgUrl.hashCode}';
    platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final html.DivElement container = html.DivElement()
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.position = "relative";

      // 이미지 클릭 이벤트
      final html.ImageElement imageElement = html.ImageElement()
        ..src = exhibition.imgUrl
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.objectFit = "contain";

      container.onClick.listen((event) {
        if (exhibition.url.isNotEmpty) {
          html.window.open(exhibition.url, '_blank');
        }
      });

// 이미지 로딩 시작 시 로딩 인디케이터 표시
      container.append(html.DivElement()
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.display = "flex"
        ..style.alignItems = "center"
        ..style.justifyContent = "center"
        ..append(html.DivElement()
          ..className = "loading-spinner"
          ..style.border = "4px solid #f3f3f3"
          ..style.borderTop = "4px solid #6B7AED"
          ..style.borderRadius = "50%"
          ..style.width = "30px"
          ..style.height = "30px"
          ..style.animation = "spin 1s linear infinite"));

// 이미지 로드 완료 시 로딩 인디케이터 제거하고 이미지 표시
      imageElement.onLoad.listen((event) {
        container.children.clear();
        container.append(imageElement);
      });

// 이미지 로드 실패 시 에러 메시지 표시
      imageElement.onError.listen((event) {
        container.children.clear();
        container.append(html.ImageElement()
          // ..src = 'assets/images/no-image.png' // 플레이스홀더 이미지 경로
          ..src = 'data:image/png;base64,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' // 플레이스홀더 이미지 경로
          ..style.width = "70%" // 이미지 크기를 50%로 줄임
          ..style.height = "70%" // 이미지 크기를 50%로 줄임
          ..style.position = "absolute" // 절대 위치 지정
          ..style.left = "50%" // 왼쪽에서 50% 위치
          ..style.top = "50%" // 위에서 50% 위치
          ..style.transform = "translate(-50%, -50%)" // 중앙 정렬을 위한 transform
          ..style.objectFit = "contain");
      });

      container.append(imageElement);
      return container;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String viewType = 'image-view-${exhibition.imgUrl.hashCode}';
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        if (exhibition.url.isNotEmpty) {
          final Uri url = Uri.parse(exhibition.url);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        }
      },
      child: Card(
        color: CupertinoColors.white,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 5,
        child: screenWidth <= 600
            ? _buildMobileLayout(viewType)
            : _buildDesktopLayout(viewType),
      ),
    );
  }

  Widget _buildMobileLayout(String viewType) {
    return Container(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                bottomLeft: Radius.circular(0.0),
              ),
              child: HtmlElementView(viewType: viewType),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exhibition.title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(CupertinoIcons.calendar,
                          size: 14, color: Color(0xFF6B7AED)),
                      SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '${exhibition.getFormattedStartDate()} - ${exhibition.getFormattedEndDate()}',
                          style: TextStyle(
                              fontSize: 14, color: CupertinoColors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(CupertinoIcons.location_solid,
                          size: 14, color: Color(0xFF6B7AED)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${exhibition.place}',
                          style: TextStyle(
                              fontSize: 14, color: CupertinoColors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(CupertinoIcons.map,
                          size: 14, color: Color(0xFF6B7AED)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${exhibition.area}',
                          style: TextStyle(
                              fontSize: 14, color: CupertinoColors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(CupertinoIcons.time,
                          size: 14, color: Color(0xFF6B7AED)),
                      SizedBox(width: 4),
                      Text(
                        exhibition.getLocalizedStatus(),
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.black),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3.8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF6B7AED), width: 1.6),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          exhibition.price.isNotEmpty
                              ? exhibition.price.length > 14
                                  ? '${exhibition.price.substring(0, 14)}...'
                                  : exhibition.price
                              : '정보 없음',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF6B7AED)),
                        ),
                      ),
                      Spacer(),
                      if (exhibition.url.isNotEmpty)
                        Icon(
                          CupertinoIcons.link,
                          color: CupertinoColors.link,
                          size: 20,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(String viewType) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
              child: AspectRatio(
                aspectRatio: 3 / 3.0,
                child: HtmlElementView(viewType: viewType),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 12.0, 8.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      child: Text(
                        exhibition.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.building_2_fill,
                                  size: 17, color: Color(0xFF6B7AED)),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${exhibition.place} | ${exhibition.area}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: CupertinoColors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(CupertinoIcons.calendar,
                                  size: 17, color: Color(0xFF6B7AED)),
                              SizedBox(width: 4),
                              Text(
                                '${exhibition.getFormattedStartDate()}  -  ${exhibition.getFormattedEndDate()}',
                                style: TextStyle(
                                    fontSize: 17, color: CupertinoColors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(CupertinoIcons.time,
                                  size: 17, color: Color(0xFF6B7AED)),
                              SizedBox(width: 4),
                              Text(
                                exhibition.getLocalizedStatus(),
                                style: TextStyle(
                                    fontSize: 17, color: CupertinoColors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3.6),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.6, color: Color(0xFF6B7AED)),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  exhibition.price.isNotEmpty
                                      ? exhibition.price.length > 30
                                          ? '${exhibition.price.substring(0, 30)}...'
                                          : exhibition.price
                                      : '정보 없음',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color(0xFF6B7AED)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
        if (exhibition.url.isNotEmpty)
          Positioned(
            bottom: 15,
            right: 15,
            child: Icon(
              CupertinoIcons.link,
              color: CupertinoColors.link,
              size: 27,
            ),
          ),
      ],
    );
  }
}
