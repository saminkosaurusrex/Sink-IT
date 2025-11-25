//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/services/api_service.dart';

part 'api_service_provider.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return ApiService(baseUrl: 'http://10.193.174.137:8000');
}
