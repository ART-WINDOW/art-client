import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/exhibition.dart';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition});

  @override
  Widget build(BuildContext context) {
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
        child:
            screenWidth <= 600 ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
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
              child: Container(
                // 새로운 Container 추가
                height: 180, // 부모 Container와 동일한 높이
                alignment: Alignment.center, // 중앙 정렬
                child: Image.network(
                  exhibition.imgUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.25, // 화면 너비의 15%
                        height: MediaQuery.of(context).size.width *
                            0.25, // 정사각형 유지를 위해 너비와 동일
                        child: Image.asset(
                          'assets/images/no-image.png',
                          fit: BoxFit.contain, // 비율 유지하면서 컨테이너에 맞춤
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exhibition.title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(CupertinoIcons.calendar,
                          size: 14, color: Color(0xFF6B7AED)),
                      SizedBox(width: 4),
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
                  SizedBox(height: 5),
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

  Widget _buildDesktopLayout() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
              child: AspectRatio(
                aspectRatio: 3 / 3.0,
                child: Image.network(
                  exhibition.imgUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
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
