import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:test_task_project/provider/home_provider.dart';
import 'package:test_task_project/resources/components/menu_food_card.dart';

import '../provider/home_provider.dart';
import '../provider/home_provider.dart';
import '../provider/home_provider.dart';

class RestaurantMenuDetail extends StatefulWidget {
  final String title;
  const RestaurantMenuDetail({Key key, this.title}) : super(key: key);

  @override
  _RestaurantMenuDetailState createState() => _RestaurantMenuDetailState();
}

class _RestaurantMenuDetailState extends State<RestaurantMenuDetail>
    with TickerProviderStateMixin {
  TabController _tabController;
  AutoScrollController controller;

  @override
  void initState() {
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getDetailedRestaurantByTitle(widget.title);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        if (provider.getLoadingState)
          return Scaffold(
            body: const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: const Color.fromRGBO(231, 205, 141, 1),
                ),
              ),
            ),
          );
        return Scaffold(
          appBar: buildAppBarFixed(),
          body: CustomScrollView(
            slivers: [
              buildSliverToBoxAdapterHeader(provider),
              buildSliverAppBarCollepse(provider),
              buildSliverGridBody(provider, width, height)
            ],
          ),
        );
      }),
    );
  }

  AppBar buildAppBarFixed() {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actions: [
        IconButton(
            icon: const Icon(
              Icons.favorite_border_rounded,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () {}),
        IconButton(
            icon: const Icon(
              Icons.search_rounded,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () {}),
      ],
    );
  }

  SliverAppBar buildSliverAppBarCollepse(HomeProvider provider) {
    return SliverAppBar(
      pinned: true,
      leading: null,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 0,
      flexibleSpace: Center(
        child: SizedBox(
          height: 40,
          child: TabBar(
            indicator: BoxDecoration(
              color: const Color.fromRGBO(231, 205, 141, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            dragStartBehavior: DragStartBehavior.start,
            indicatorWeight: 0,
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: const Color.fromRGBO(122, 98, 39, 1),
            labelColor: const Color.fromRGBO(122, 98, 39, 1),
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            onTap: (val) => _scrollToIndex(val),
            tabs: provider.getRestaurantMenu.categories.map((category) {
              return SizedBox(
                child: Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      category.name.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            controller: TabController(
                length: provider.getRestaurantMenu.categories.length,
                vsync: this),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter buildSliverToBoxAdapterHeader(HomeProvider provider) {
    return SliverToBoxAdapter(
      child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: provider.getRestaurantMenu.restaurant.logo,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 7,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50),
                      child: Ink(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                offset: Offset(0, 5),
                                color: Colors.grey[200],
                              )
                            ]),
                        child: const Center(
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              offset: Offset(0, 5),
                              color: Colors.grey[200],
                              spreadRadius: 1,
                            )
                          ]),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.black54,
                              ),
                              Text(
                                  ' ${provider.getRestaurantMenu.restaurant.rating == null ? '0.0' : provider.getRestaurantMenu.restaurant.rating}'
                                  ' • '),
                              Text(
                                  '${provider.getRestaurantMenu.restaurant.feedbacksAmount} отзывов '),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              spreadRadius: 1,
                              offset: Offset(0, 5),
                              color: Colors.grey[200],
                            )
                          ]),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                            child: Text(
                                'Заказ от ${provider.getRestaurantMenu.restaurant.minOrder} ₽')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  SliverToBoxAdapter buildSliverGridBody(
      HomeProvider provider, double width, double height) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              controller: controller,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: provider.getRestaurantMenu.categories.length,
              itemBuilder: (BuildContext context, int j) {
                return AutoScrollTag(
                    key: ValueKey(j),
                    controller: controller,
                    index: j,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            provider.getRestaurantMenu.categories[j].name,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GridView.builder(
                          itemCount: provider
                              .getRestaurantMenu.categories[j].dishes.length,
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: width / (height / 1.4),
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: MenuFoodCard(
                                dish: provider.getRestaurantMenu.categories[j]
                                    .dishes[index],
                                isPrice: index % 2 == 0 ? true : false,
                              ),
                            );
                          },
                        ),
                      ],
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _scrollToIndex(int val) async {
    await controller.scrollToIndex(val,
        preferPosition: AutoScrollPosition.begin);
  }
}
