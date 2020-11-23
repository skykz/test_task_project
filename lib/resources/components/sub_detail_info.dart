import 'dart:developer';

import 'package:flutter/material.dart';

class RestaurantSubTitleInfo extends StatelessWidget {
  final dynamic data;
  final int index;
  final String fieldName;

  const RestaurantSubTitleInfo({Key key, this.data, this.index, this.fieldName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("$data");
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: setWidgetByField(fieldName),
    );
  }

  setWidgetByField(String val) {
    switch (val) {
      case 'rating':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 5),
              child: const Icon(
                Icons.star_rounded,
                color: Colors.grey,
                size: 20,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  data == null ? 0.0.toString() : data.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            )
          ],
        );
        break;
      case 'deliveryTime':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 5),
              child: const Icon(
                Icons.timelapse_rounded,
                color: Colors.grey,
                size: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Text(
                data.toString() + " мин",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )
          ],
        );
        break;
      case 'minOrder':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 5),
              child: const Text(
                'От',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Text(
                data.toString() + " ₽",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )
          ],
        );
        break;
      default:
    }
  }
}
