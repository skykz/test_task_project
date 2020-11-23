import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_project/provider/home_provider.dart';
import 'package:test_task_project/screens/restaurant_home.dart';

import 'provider/home_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Task Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: const Color.fromRGBO(242, 242, 242, 1),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
