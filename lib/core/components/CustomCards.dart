import 'package:flutter/material.dart';
import 'package:otomasyon/core/constants/CustomColors.dart';

class CustomCards {
  static Card productSatisCard = Card(
    child: Row(
      children: [
        Container(
          width: 66,
          height: 53,
        ),
        Column(
          children: [
            Row(
              children: [
                Text('Ülker Çikolatalı Gofret'),
                Spacer(),
                Text('Ekim 16, 2021'),
              ],
            ),
            Text('₺ 4,5'),
          ],
        )
      ],
    ),
    color: CustomColors.palatinateBlue,
    shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.all(Radius.circular(4)),
    ),
  );
}
