import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/services/api_service.dart';

part 'api_service_provider.g.dart';

/// Provider pro ApiService
/// DŮLEŽITÉ: Změň baseUrl na IP tvého počítače!
@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  // Pro iOS simulator: http://localhost:8000
  // Pro Android emulator: http://10.0.2.2:8000
  // Pro reálné zařízení: http://192.168.X.X:8000 (IP tvého počítače)

  return ApiService(
    baseUrl: 'http://10.193.174.137:8000', // ← ZMĚŇ NA SVOU IP!
  );
}
