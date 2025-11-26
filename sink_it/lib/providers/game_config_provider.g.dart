// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GameConfigController)
const gameConfigControllerProvider = GameConfigControllerProvider._();

final class GameConfigControllerProvider
    extends $NotifierProvider<GameConfigController, GameConfig> {
  const GameConfigControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameConfigControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameConfigControllerHash();

  @$internal
  @override
  GameConfigController create() => GameConfigController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameConfig>(value),
    );
  }
}

String _$gameConfigControllerHash() =>
    r'a0892a62cb0b53ab7bbe698b22715dc76288d3b9';

abstract class _$GameConfigController extends $Notifier<GameConfig> {
  GameConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GameConfig, GameConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GameConfig, GameConfig>,
              GameConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(boardSize)
const boardSizeProvider = BoardSizeProvider._();

final class BoardSizeProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const BoardSizeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardSizeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardSizeHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return boardSize(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$boardSizeHash() => r'5e1cdb89e01882457ecd83b726a44062410b1e03';

@ProviderFor(soundEnabled)
const soundEnabledProvider = SoundEnabledProvider._();

final class SoundEnabledProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const SoundEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soundEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soundEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return soundEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$soundEnabledHash() => r'36c1958a8f2a63c968126de1e6d119753cbb65ba';

@ProviderFor(animationsEnabled)
const animationsEnabledProvider = AnimationsEnabledProvider._();

final class AnimationsEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const AnimationsEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animationsEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animationsEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return animationsEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$animationsEnabledHash() => r'3f2ffb4298a37da5b626f613f89ff2d5be82428d';

@ProviderFor(fleetInfo)
const fleetInfoProvider = FleetInfoProvider._();

final class FleetInfoProvider
    extends
        $FunctionalProvider<
          List<Map<String, dynamic>>,
          List<Map<String, dynamic>>,
          List<Map<String, dynamic>>
        >
    with $Provider<List<Map<String, dynamic>>> {
  const FleetInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fleetInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fleetInfoHash();

  @$internal
  @override
  $ProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<Map<String, dynamic>> create(Ref ref) {
    return fleetInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Map<String, dynamic>>>(value),
    );
  }
}

String _$fleetInfoHash() => r'2f933bb71cb7d7c424d58d9a331b26fe471abb2e';
