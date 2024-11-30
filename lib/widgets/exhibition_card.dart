import 'dart:html' as html;
import 'dart:ui_web';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/exhibition.dart';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition}) {
    final String viewType = 'image-view-${exhibition.imgUrl.hashCode}';
    platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final html.DivElement container = html.DivElement()
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.position = "relative";

      final html.ImageElement imageElement = html.ImageElement()
        ..src = exhibition.imgUrl
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.objectFit = "contain"
        ..onError.listen((event) {
          container.children.clear();
          final html.DivElement iconElement = html.DivElement()
            ..style.width = "100%"
            ..style.height = "100%"
            ..style.display = "flex"
            ..style.alignItems = "center"
            ..style.justifyContent = "center"
            ..innerHtml =
                '<i class="material-icons" style="font-size: 44px; color: grey;">이미지가 없습니다</i>';
          container.append(iconElement);
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(CupertinoIcons.building_2_fill,
                          size: 14, color: Color(0xFF6B7AED)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${exhibition.place} | ${exhibition.area}',
                          style: TextStyle(
                              fontSize: 14, color: CupertinoColors.black),
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
                  SizedBox(height: 4),
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
                              ? exhibition.price.length > 13
                                  ? '${exhibition.price.substring(0, 13)}...'
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
                          SizedBox(height: 4),
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
            bottom: 12,
            right: 12,
            child: Icon(
              CupertinoIcons.link,
              color: CupertinoColors.link,
              size: 20,
            ),
          ),
      ],
    );
  }
}
