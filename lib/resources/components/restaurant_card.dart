import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_task_project/core/models/restaurants.dart';
import 'package:test_task_project/resources/components/sub_detail_info.dart';
import 'package:test_task_project/utils/common.dart';

class RestaurantCard extends StatelessWidget {
  final List<Closed> closed;
  final int index;
  final bool isOpen;
  final Function onPressed;
  const RestaurantCard(
      {Key key, this.closed, this.index, this.isOpen, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    inspect(closed);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 6),
              color: Colors.grey[300],
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: closed[index].image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]),
                      child: CachedNetworkImage(
                        imageUrl: closed[index].logo,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error_outline_rounded),
                      ),
                    ),
                  ),
                  !isOpen
                      ? Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isOpen
                        ? Flexible(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Ресторан откроется через ${getTime(closed[index].worksFrom)} часа',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        closed[index].title,
                        style: TextStyle(
                          fontSize: 19,
                          color: isOpen ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: RestaurantSubTitleInfo(
                                data: closed[index].deliveryTime,
                                index: index,
                                fieldName: "deliveryTime",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: RestaurantSubTitleInfo(
                                data: closed[index].minOrder,
                                index: index,
                                fieldName: "minOrder",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: RestaurantSubTitleInfo(
                                data: closed[index].rating,
                                index: index,
                                fieldName: "rating",
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
