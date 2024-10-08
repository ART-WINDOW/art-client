import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/exhibition.dart';
import 'dart:typed_data';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition});

  @override
  Widget build(BuildContext context) {
    // 서버에서 받아온 이미지 데이터를 Uint8List로 변환
    Uint8List imageData = Uint8List.fromList(exhibition.imageData);

    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: AspectRatio(
              aspectRatio: 3 / 3.0, // 원하는 비율로 설정
              child: Image.memory(
                imageData, // 서버에서 받아온 이미지 데이터 사용
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Icon(CupertinoIcons.photo);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0.0),
            child: Text(
              exhibition.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              maxLines: 2, // 최대 2줄까지만 표시
              overflow: TextOverflow.ellipsis, // 넘치는 텍스트는 생략
            ),
          ),
          Flexible( // 이 부분에서 Flexible을 사용하여 텍스트가 높이를 조절할 수 있게 함
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.building_2_fill,
                    size: 17,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(width: 4),
                  Expanded( // 텍스트가 길어지면 유동적으로 차지할 수 있게 만듦
                    child: Text(
                      exhibition.place + ' | ' + exhibition.area,
                      style: TextStyle(fontSize: 17, color: CupertinoColors.systemGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
