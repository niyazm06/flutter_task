import 'package:dio/dio.dart';
import 'dart:developer' as developer;

import 'package:untitled/model/ship_data.dart';

class ApiRepository {
  late Dio dio;

  ApiRepository() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.spacexdata.com/v3/',
      ),
    );
    interceptors();
  }

  Future<List<ShipsData>> getAllShips() async {
    List<ShipsData> shipList = [];

    final response = await dio.get('ships');
    if (response.statusCode == 200) {
      List<dynamic> list = response.data;

      for (var data in list) {
        final shipData = ShipsData.fromJson(data);
        shipList.add(shipData);
      }
    }
    return shipList;
  }

  Future<ShipsData> getShipDetails(String shipId) async {
    late ShipsData shipsData;
    final response = await dio.get('ships/$shipId');
    if (response.statusCode == 200) {
      shipsData = ShipsData.fromJson(response.data);
    }
    return shipsData;
  }

  interceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions? options, RequestInterceptorHandler? handler) {
          console(options!, '');
          return handler?.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          developer.log('${response.statusCode}', name: 'STATUS-CODE');
          developer.log('$response', name: 'RESULT');
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode != 200) {
            RequestOptions options = error.response!.requestOptions;
            developer.log('${error.response?.statusCode}', name: 'ERROR-CODE');
            developer.log('${error.response?.statusMessage}',
                name: 'ERROR-MESSAGE');
            console(options, 'onError-Retry');

            return handler.next(error);
          }
        },
      ),
    );
  }
}

void console(RequestOptions options, String label) {
  developer.log('$label: ${options.path}', name: 'PATH');
  developer.log('${options.headers}', name: 'HEADER');
  developer.log('${options.queryParameters}', name: 'QUERY PARAMETERS');

  if (options.data != null) {
    String data = '{';
    for (MapEntry field in options.data.fields) {
      data = '$data${field.key}: ${field.value},';
    }
    developer.log(data, name: 'BODY');
  }
}
