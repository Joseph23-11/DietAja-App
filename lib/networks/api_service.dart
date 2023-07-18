import 'package:diet_app/networks/base_provider.dart';
import 'package:diet_app/utils/typedef.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final BaseProvider _baseProvider;

  ApiService(this._baseProvider);

  String? token;

  Future getToken() async {
    SharedPreferences tokenPrefs = await SharedPreferences.getInstance();

    token = tokenPrefs.getString('token');

    print('GetToken: $token');
  }

  get<T>({
    required String endpoint,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    if (requiresAuthToken) {
      await getToken();
    }

    var customHeaders = requiresAuthToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response =
        await _baseProvider.get(endpoint, headers: customHeaders, query: query);

    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      throw Exception('No Connection');
    }
  }

  post<T>({
    required String endpoint,
    dynamic body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    if (requiresAuthToken) {
      await getToken();
    }

    var customHeaders = requiresAuthToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.post(endpoint, body,
        headers: customHeaders, query: query);

    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      print('error ${response.statusText}');
      throw Exception(response.statusCode);
    }
  }

  put<T>({
    required String endpoint,
    dynamic body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    if (requiresAuthToken) {
      await getToken();
    }

    var customHeaders = requiresAuthToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.put(endpoint, body,
        headers: customHeaders, query: query);

    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      throw Exception('No Connection');
    }
  }

  delete<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    if (requiresAuthToken) {
      await getToken();
    }

    var customHeaders = requiresAuthToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.delete(endpoint,
        headers: customHeaders, query: query);

    if (!response.hasError) {
      return _returnResponse(response);
    } else {
      throw Exception('No Connection');
    }
  }
}

dynamic _returnResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response.body;
    case 201:
      return response.body;
    case 400:
      throw BadRequestException(response.body['message']);
    case 401:
      throw UnauthorizedException(response.bodyString);
    case 403:
      throw ForbiddenException(response.bodyString);
    case 404:
      throw BadRequestException(response.bodyString);
    case 500:
      throw FetchDataException('Internal Server Error');
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}

class AppException implements Exception {
  final String? code;
  final String? message;
  final String? details;

  AppException({this.code, this.message, this.details});

  @override
  String toString() {
    return '$details';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String? details)
      : super(
          code: "unauthorized",
          message: "Unauthorized",
          details: details,
        );
}

class ForbiddenException extends AppException {
  ForbiddenException(String? details)
      : super(
          code: "Forbidden",
          message: "forbidden",
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
