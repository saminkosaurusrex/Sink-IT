// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_placement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShipPlacement)
const shipPlacementProvider = ShipPlacementProvider._();

final class ShipPlacementProvider
    extends $NotifierProvider<ShipPlacement, ShipPlacementState> {
  const ShipPlacementProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipPlacementProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipPlacementHash();

  @$internal
  @override
  ShipPlacement create() => ShipPlacement();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShipPlacementState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShipPlacementState>(value),
    );
  }
}

String _$shipPlacementHash() => r'e22eba0c74d3af075aa8988d4fd40c847f9336ba';

abstract class _$ShipPlacement extends $Notifier<ShipPlacementState> {
  ShipPlacementState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ShipPlacementState, ShipPlacementState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ShipPlacementState, ShipPlacementState>,
              ShipPlacementState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(isSubmitting)
const isSubmittingProvider = IsSubmittingProvider._();

final class IsSubmittingProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsSubmittingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSubmittingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSubmittingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSubmitting(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSubmittingHash() => r'61f69bd2e6070fa90be126e9c96aaaa62bb98878';

@ProviderFor(placedShipsCount)
const placedShipsCountProvider = PlacedShipsCountProvider._();

final class PlacedShipsCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const PlacedShipsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placedShipsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placedShipsCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return placedShipsCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$placedShipsCountHash() => r'75e1676e913c9f295cedc79ff40341eaf93dca5a';

@ProviderFor(selectedShip)
const selectedShipProvider = SelectedShipProvider._();

final class SelectedShipProvider
    extends $FunctionalProvider<Ship?, Ship?, Ship?>
    with $Provider<Ship?> {
  const SelectedShipProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedShipProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedShipHash();

  @$internal
  @override
  $ProviderElement<Ship?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Ship? create(Ref ref) {
    return selectedShip(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Ship? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Ship?>(value),
    );
  }
}

String _$selectedShipHash() => r'5ae6d1444d79b868e8a93d77e2842a25d0297981';
