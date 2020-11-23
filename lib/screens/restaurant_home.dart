import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_project/provider/home_provider.dart';
import 'package:test_task_project/resources/components/restaurant_card.dart';
import 'package:test_task_project/screens/restaurant_menu_detail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Рядом с вами',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    if (provider.getLoadingState)
                      return const Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor:
                                const Color.fromRGBO(231, 205, 141, 1),
                          ),
                        ),
                      );
                    log("++++++++++ ${provider.getLengthList}");
                    return Column(
                      children: [
                        ListView.builder(
                            itemCount: provider.getRestaurantList.open.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RestaurantCard(
                                  closed: provider.getRestaurantList.open,
                                  index: index,
                                  isOpen: true,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantMenuDetail(
                                          title: provider.getRestaurantList
                                              .open[index].title,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                        ListView.builder(
                            itemCount: provider.getRestaurantList.closed.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RestaurantCard(
                                  closed: provider.getRestaurantList.closed,
                                  index: index,
                                  isOpen: false,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantMenuDetail(
                                          title: provider.getRestaurantList
                                              .open[index].title,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
