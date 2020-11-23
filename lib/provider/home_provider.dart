import 'package:flutter/material.dart';
import 'package:test_task_project/core/models/menus.dart';
import 'package:test_task_project/core/models/restaurants.dart';
import 'package:test_task_project/core/network/repository/api_repository.dart';

class HomeProvider extends ChangeNotifier {
  AppAPI _appAPI = AppAPI();

  Restaurant _restaurant;
  Restaurant get getRestaurantList => _restaurant;

  MenuRestaurant _restaurantMenu;
  MenuRestaurant get getRestaurantMenu => _restaurantMenu;

  bool _isLoading = false;
  bool get getLoadingState => _isLoading;

  int _lengthList = 0;
  int get getLengthList => _lengthList;

  int _lengthDishes = 0;
  int get getLengthDisshes => _lengthDishes;

  setLoadingState(bool val) {
    this._isLoading = val;
  }

  getRestaurants() {
    setLoadingState(true);
    _appAPI.getRestaurantsList().then((value) {
      this._restaurant = restaurantFromJson(value);
      this._lengthList = this._restaurant.closed.toList().length +
          this._restaurant.open.toList().length;

      notifyListeners();
    }).whenComplete(() => setLoadingState(false));
  }

  getDetailedRestaurantByTitle(String _title) {
    setLoadingState(true);
    _appAPI.getMenuByRestaurant(_title).then((value) {
      this._restaurantMenu = menuRestaurantFromJson(value);
      _restaurantMenu.categories.map((e) {
        _lengthDishes = e.dishes.length;
        notifyListeners();
      });
      notifyListeners();
    }).whenComplete(() => setLoadingState(false));
  }
}
