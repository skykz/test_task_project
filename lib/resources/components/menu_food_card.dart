import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_task_project/core/models/menus.dart';

class MenuFoodCard extends StatelessWidget {
  final bool isPrice;
  final Dish dish;
  final Function onPressed;
  const MenuFoodCard({Key key, this.isPrice = true, this.dish, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey[300],
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: CachedNetworkImage(
                imageUrl: dish.image,
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
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline_rounded),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        dish.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(231, 205, 141, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: isPrice
                                  ? Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        ' ${dish.price} ₽ ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: const Color.fromRGBO(
                                              231, 205, 141, 1),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Icon(
                                            Icons.remove_rounded,
                                            color: const Color.fromRGBO(
                                                231, 205, 141, 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Icon(
                                            Icons.add_rounded,
                                            color: const Color.fromRGBO(
                                                231, 205, 141, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
