import 'dart:html' as html;
import 'dart:ui_web';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/exhibition.dart';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition}) {
    // viewType 등록
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
            ..innerHtml = '<i class="material-icons" style="font-size: 48px; color: grey;">이미지가 없습니다</i>';
          container.append(iconElement);
        });

      container.append(imageElement);
      return container;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String viewType = 'image-view-${exhibition.imgUrl.hashCode}';

    return GestureDetector(
      onTap: () async {
        if (exhibition.url.isNotEmpty) {
          final Uri url = Uri.parse(exhibition.url);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            print('Could not launch $url');
          }
        }
      },
      child: Stack(
        children: [
          Card(
            color: CupertinoColors.white,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
                  child: AspectRatio(
                    aspectRatio: 3 / 3.0, // 기존 이미지 비율 유지
                    child: HtmlElementView(
                      viewType: viewType,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                          child: Text(
                            exhibition.title,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.building_2_fill,
                                    size: 17,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      exhibition.place + ' | ' + exhibition.area,
                                      style: TextStyle(fontSize: 17, color: CupertinoColors.systemGrey),
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
                                      size: 17, color: CupertinoColors.systemGrey),
                                  SizedBox(width: 4),
                                  Text(
                                    '${exhibition.getFormattedStartDate()} - ${exhibition.getFormattedEndDate()}',
                                    style: TextStyle(fontSize: 17, color: CupertinoColors.systemGrey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.time,
                                    size: 17,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    exhibition.getLocalizedStatus(),
                                    style: TextStyle(fontSize: 17, color: CupertinoColors.systemGrey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: CupertinoColors.systemGrey),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        exhibition.price.isNotEmpty ? exhibition.price : '정보 없음',
                                        style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
              ],
            ),
          ),
          if (exhibition.url.isNotEmpty)
            Positioned(
              bottom: 20,
              right: 20,
              child: Icon(
                CupertinoIcons.link,
                color: CupertinoColors.link,
              ),
            ),
        ],
      ),
    );
  }
}