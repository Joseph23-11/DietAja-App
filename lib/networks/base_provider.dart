import 'package:diet_app/networks/api_constans.dart';
import 'package:diet_app/networks/interceptors/request_interceptors.dart';
import 'package:diet_app/networks/interceptors/response_interceptors.dart';
import 'package:get/get.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = ApiConstant.apiUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
    httpClient.timeout = const Duration(seconds: 30);
  }
}
