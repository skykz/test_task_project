import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const BASE_URL = "http://185.125.56.240:8080/api/v1/";

class NetworkCall {
  static NetworkCall _instance = NetworkCall.internal();

  NetworkCall.internal();
  factory NetworkCall() => _instance;

  Future<dynamic> doRequestMain(
      {@required String path,
      @required String method,
      @required BuildContext context,
      Map<String, dynamic> requestParams,
      Map<String, dynamic> body,
      FormData formData}) async {
    BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        method: method,
        contentType: ContentType.parse("application/json").value);

    Dio dio = Dio(options);
    Response response;

    try {
      response =
          await dio.request(path, queryParameters: requestParams, data: body);

      log(" - Response - ", name: " api route -- $path");
      return response.toString();
    } on DioError catch (error) {
      handleError(error, context);
    }
  }

  /// handling avaiable cases from server
  void handleError(DioError error, BuildContext context) {
    String errorDescription;

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = error.message;
          print(errorDescription);

          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = error.message;
          print(errorDescription);

          break;
        case DioErrorType.DEFAULT:
          errorDescription = error.message;
          print(errorDescription);

          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = error.message;
          print(errorDescription);

          break;
        case DioErrorType.RESPONSE:
          errorDescription = error.message;
          print(errorDescription);

          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = error.message;
          print(errorDescription);
          break;
      }
    }

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 20),
          backgroundColor: Colors.red[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          action: SnackBarAction(
            label: 'ОК',
            textColor: Colors.white,
            onPressed: () {},
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.info_outline, color: Colors.white),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    errorDescription,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
