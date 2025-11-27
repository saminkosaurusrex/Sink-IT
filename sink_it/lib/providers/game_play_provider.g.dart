// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_play_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GamePlay)
const gamePlayProvider = GamePlayProvider._();

final class GamePlayProvider
    extends $NotifierProvider<GamePlay, GamePlayState> {
  const GamePlayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamePlayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamePlayHash();

  @$internal
  @override
  GamePlay create() => GamePlay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GamePlayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GamePlayState>(value),
    );
  }
}

String _$gamePlayHash() => r'fee4444797a682a8c1671ad10f9cff2353d53812';

abstract class _$GamePlay extends $Notifier<GamePlayState> {
  GamePlayState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GamePlayState, GamePlayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GamePlayState, GamePlayState>,
              GamePlayState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(lastAttackResult)
const lastAttackResultProvider = LastAttackResultProvider._();

final class LastAttackResultProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const LastAttackResultProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastAttackResultProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastAttackResultHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return lastAttackResult(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$lastAttackResultHash() => r'98b56b6bbc0092255a961868a8bd7a4ff3a8777a';

@ProviderFor(isAttacking)
const isAttackingProvider = IsAttackingProvider._();

final class IsAttackingProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsAttackingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAttackingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAttackingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAttacking(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAttackingHash() => r'd9efc276fa56caaaea175f91413a3409f97ad38c';

@ProviderFor(remainingEnemyShips)
const remainingEnemyShipsProvider = RemainingEnemyShipsProvider._();

final class RemainingEnemyShipsProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const RemainingEnemyShipsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remainingEnemyShipsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remainingEnemyShipsHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return remainingEnemyShips(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$remainingEnemyShipsHash() =>
    r'91ec7cd03093cb3693da7c4e35d69049e7dbda40';
