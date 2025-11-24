// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pro ApiService
/// DŮLEŽITÉ: Změň baseUrl na IP tvého počítače!

@ProviderFor(apiService)
const apiServiceProvider = ApiServiceProvider._();

/// Provider pro ApiService
/// DŮLEŽITÉ: Změň baseUrl na IP tvého počítače!

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  /// Provider pro ApiService
  /// DŮLEŽITÉ: Změň baseUrl na IP tvého počítače!
  const ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return apiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$apiServiceHash() => r'37e249d41b07c7351750f859373f503968c6661a';
