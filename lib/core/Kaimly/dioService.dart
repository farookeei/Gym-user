import 'dart:convert';

import 'package:dio/dio.dart';

import 'httpException.dart';

class DioServicesAPI {
  BaseOptions? _options;
  //  = new BaseOptions(
  //   baseUrl: StateHandler.serversType,
  //   followRedirects: false,
  //   validateStatus: (status) => true,
  //   receiveDataWhenStatusError: true,
  // )
  // base config options
  DioServicesAPI({BaseOptions? baseOptions}) {
    _options = baseOptions;
  }

  @override
  Future<Map> getAPI({String? authorization, required String url}) async {
    Dio _dio = Dio(_options);

    // for json accept and content type
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';

    //? for jwt authorization
    // print(url);
    // print(authorization);
    if (authorization != null)
      _dio.options.headers['authorization'] = ' $authorization';
    // api response
    Response _response = await _dio
        .request(url, options: Options(method: "GET"))
        .catchError((e) {
      print(e);
      print("Errrrrrrrrrrrrrrrrrrrrrrrrr");
      throw HttpException(500);
    });

    _errorHandler(_response);

    return _response.data;
  }

  @override
  Future<Map> deleteAPI({
    Map<String, String>? addOnHeader,
    Map<String, dynamic>? body,
    required String url,
    int? id,
    String? authorization,
  }) async {
    try {
      final Map<dynamic, dynamic> _responseBody = await _bodyPassRequest(
        methodType: 'DELETE',
        url: url,
        authorization: authorization,
        body: body,
      );

      return _responseBody;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map> patchAPI({
    Map<String, String>? addOnHeader,
    Map<String, dynamic>? body,
    required String url,
    String? authorization,
  }) async {
    try {
      final Map<dynamic, dynamic> _responseBody = await _bodyPassRequest(
        methodType: 'PATCH',
        url: url,
        authorization: authorization,
        body: body,
      );

      return _responseBody;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map> postAPI({
    Map<String, String>? addOnHeader,
    Map<String, dynamic>? body,
    required String url,
    String? authorization,
  }) async {
    final _responseBody = await _bodyPassRequest(
      methodType: 'POST',
      url: url,
      authorization: authorization,
      body: body,
    );

    return _responseBody;
  }

  @override
  Future<void> postAPINoBody({
    Map<String, dynamic>? body,
    required String url,
    String? authorization,
  }) async {
    Dio _dio = Dio(_options);

    // for json accept and content type
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';

    //? for jwt authorization
    if (authorization != null)
      _dio.options.headers['authorization'] = ' $authorization';

    // api response
    await _dio
        .request(url, options: Options(method: "POST"))
        .catchError((e) => throw HttpException(500));
  }

  @override
  Future<Map> putAPI({
    Map<String, String>? addOnHeader,
    Map<String, dynamic>? body,
    required String url,
    int? id,
    String? authorization,
  }) async {
    try {
      final Map<dynamic, dynamic> _responseBody = await _bodyPassRequest(
        methodType: 'PUT',
        url: url,
        authorization: authorization,
        body: body,
      );

      return _responseBody;
    } catch (e) {
      throw e;
    }
  }

  Future<Map> _bodyPassRequest({
    Map<String, dynamic>? body,
    String? authorization,
    required String url,
    required String methodType,
  }) async {
    try {
      // body json encoding
      dynamic _encodeJson = json.encode(body);
      if (body == null) _encodeJson = null;

      Dio _dio = Dio(_options);

      // for json accept and content type
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';

      //? for jwt authorization
      if (authorization != null)
        _dio.options.headers['authorization'] = '$authorization';

      // api response
      Response _response = await _dio
          .request(url, options: Options(method: methodType), data: _encodeJson)
          .catchError((e) {
        throw HttpException(500);
      });

      _errorHandler(_response);

      return _response.data;
    } catch (error) {
      throw error;
    }
  }

  void _errorHandler(Response _response) {
    // try {
    //   // ? when string type is passed in api becuase some kind of error in servers side
    //   if (_response.data is String)
    //     throw HttpException(500, message: 'Error from API with string type');

    //   if (!(_response.data is Map))
    //     throw HttpException(400, message: 'Error from API');

    //   //  for null status code is http services
    //   if (_response.statusCode == null)
    //     throw HttpException(400,
    //         message: 'Something happen to client Services');

    //   // for error from error key
    //   if (_response.data.containsKey('errors')) {
    //     throw HttpException(_response.statusCode!,
    //         message: _response.data['errors'][0]);
    //   }

    //   if (_response.data.containsKey('error')) {
    //     throw HttpException(_response.statusCode!,
    //         message: _response.data['error']);
    //   }

    //   print(_response.statusCode);
    //   // when  other than ok status code comes up  error occred
    //   if (_response.statusCode! < 200 && _response.statusCode! > 226)
    //     throw HttpException(_response.statusCode!);
    // } catch (error) {
    //   throw error;
    // }
  }

  Future<Map> postFormData({
    required String url,
    required FormData data,
    required String authorization,
  }) async {
    try {
      Dio _dio = Dio(_options);

      _dio.options.headers['authorization'] = '$authorization';

      print(data.fields);

      Response _response = await _dio
          .post(url, data: data)
          .catchError((e) => throw HttpException(500));

      print(_response);

      _errorHandler(_response);

      return _response.data;
    } catch (e) {
      throw e;
    }
  }
}
