import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/exhibition.dart';

class ExhibitionCard extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionCard({required this.exhibition});

  @override
  Widget build(BuildContext context) {
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
              aspectRatio: 3 / 3, // 원하는 비율로 설정
              child: Image.network(
                exhibition.imgUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Icon(CupertinoIcons.photo),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0.0),
            child: Text(
              exhibition.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.building_2_fill,
                  size: 15,
                  color: CupertinoColors.systemGrey,
                ),
                SizedBox(width: 4),
                Text(
                  exhibition.place + ' | ' + exhibition.area,
                  style: TextStyle(fontSize: 15, color: CupertinoColors.systemGrey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                    CupertinoIcons.calendar,
                    size: 15,
                    color: CupertinoColors.systemGrey),
                SizedBox(width: 4),
                Text(
                  '${exhibition.getFormattedStartDate()} - ${exhibition.getFormattedEndDate()}',
                  style: TextStyle(fontSize: 15, color: CupertinoColors.systemGrey),
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
                  size: 15,
                  color: CupertinoColors.systemGrey,
                ),
                SizedBox(width: 4),
                Text(
                  exhibition.getLocalizedStatus(),
                  style: TextStyle(fontSize: 15, color: CupertinoColors.systemGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}