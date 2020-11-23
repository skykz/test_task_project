import 'dart:core';

import 'package:flutter/material.dart';
import 'package:test_task_project/core/network/api/network_call.dart';

class AppAPI {
  static AppAPI _instance = AppAPI.internal();
  AppAPI.internal();
  factory AppAPI() => _instance;

  NetworkCall _networkCall = NetworkCall();

  static const GET_LIST_RESTAURANT = 'catalog/restaurants/';
  static const GET_MENU_BY_RESTAURANT = 'catalog/restaurants/menu/';

  Future<dynamic> getRestaurantsList([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_LIST_RESTAURANT,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getMenuByRestaurant(String _title,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_MENU_BY_RESTAURANT,
      method: 'GET',
      context: context,
      requestParams: {'title': _title},
    );
    return response;
  }
}
