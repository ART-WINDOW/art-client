import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/exhibition.dart';
import 'dart:typed_data';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition});

  @override
  Widget build(BuildContext context) {

    return Card(
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
              aspectRatio: 3 / 3.0, // 원하는 비율로 설정
              child: Image.network(
                exhibition.storageUrl, // 서버에서 받아온 이미지 데이터 사용
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Icon(CupertinoIcons.photo);
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
                  Text(
                    exhibition.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    maxLines: 1, // 최대 1줄 까지만 표시
                    overflow: TextOverflow.ellipsis, // 넘치는 텍스트는 생략
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}