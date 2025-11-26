// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GameState)
const gameStateProvider = GameStateProvider._();

final class GameStateProvider extends $NotifierProvider<GameState, Game?> {
  const GameStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameStateHash();

  @$internal
  @override
  GameState create() => GameState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Game? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Game?>(value),
    );
  }
}

String _$gameStateHash() => r'2d1fa274634c3c53d9171d672acabbfc6fb54fa7';

abstract class _$GameState extends $Notifier<Game?> {
  Game? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Game?, Game?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Game?, Game?>,
              Game?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentGame)
const currentGameProvider = CurrentGameProvider._();

final class CurrentGameProvider extends $FunctionalProvider<Game?, Game?, Game?>
    with $Provider<Game?> {
  const CurrentGameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentGameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentGameHash();

  @$internal
  @override
  $ProviderElement<Game?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Game? create(Ref ref) {
    return currentGame(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Game? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Game?>(value),
    );
  }
}

String _$currentGameHash() => r'4ae19036733c195963563a769622c66f58e69333';

@ProviderFor(currentPLayer)
const currentPLayerProvider = CurrentPLayerProvider._();

final class CurrentPLayerProvider
    extends $FunctionalProvider<Player?, Player?, Player?>
    with $Provider<Player?> {
  const CurrentPLayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPLayerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPLayerHash();

  @$internal
  @override
  $ProviderElement<Player?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Player? create(Ref ref) {
    return currentPLayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Player? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Player?>(value),
    );
  }
}

String _$currentPLayerHash() => r'6a5ec24d63c7dad5faa89243721817524bbfac28';

@ProviderFor(currentOpponent)
const currentOpponentProvider = CurrentOpponentProvider._();

final class CurrentOpponentProvider
    extends $FunctionalProvider<Player?, Player?, Player?>
    with $Provider<Player?> {
  const CurrentOpponentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentOpponentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentOpponentHash();

  @$internal
  @override
  $ProviderElement<Player?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Player? create(Ref ref) {
    return currentOpponent(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Player? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Player?>(value),
    );
  }
}

String _$currentOpponentHash() => r'be16febac49d964bed1394da0424e7bd066cbb3f';

@ProviderFor(currentPlayerName)
const currentPlayerNameProvider = CurrentPlayerNameProvider._();

final class CurrentPlayerNameProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const CurrentPlayerNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPlayerNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPlayerNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentPlayerName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentPlayerNameHash() => r'26e333c38a155438c4d94f3195cd8804da06b805';

@ProviderFor(currentPlayerIndex)
const currentPlayerIndexProvider = CurrentPlayerIndexProvider._();

final class CurrentPlayerIndexProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const CurrentPlayerIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPlayerIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPlayerIndexHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return currentPlayerIndex(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$currentPlayerIndexHash() =>
    r'36f520970aa37d7fd1f847871c00cd30aaf65c61';

@ProviderFor(allPLayersReady)
const allPLayersReadyProvider = AllPLayersReadyProvider._();

final class AllPLayersReadyProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const AllPLayersReadyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allPLayersReadyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allPLayersReadyHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return allPLayersReady(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$allPLayersReadyHash() => r'e56ae9b896f879ffb18288f596ac052d3d6ccdf8';

@ProviderFor(isSetupState)
const isSetupStateProvider = IsSetupStateProvider._();

final class IsSetupStateProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsSetupStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSetupStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSetupStateHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSetupState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSetupStateHash() => r'e98d996720726f339dabbfa9b1f3386d3c657f7d';

@ProviderFor(isProgressState)
const isProgressStateProvider = IsProgressStateProvider._();

final class IsProgressStateProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsProgressStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isProgressStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isProgressStateHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isProgressState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isProgressStateHash() => r'cc7d4a27c74f9d908c0216ceea36ba69d62131d9';

@ProviderFor(isEndState)
const isEndStateProvider = IsEndStateProvider._();

final class IsEndStateProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsEndStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isEndStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isEndStateHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isEndState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isEndStateHash() => r'e966e7b140ccd49600158ac48206f874bfc9b184';

@ProviderFor(winnerID)
const winnerIDProvider = WinnerIDProvider._();

final class WinnerIDProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const WinnerIDProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'winnerIDProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$winnerIDHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return winnerID(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$winnerIDHash() => r'5290004c6c9b9fab9e98de64acd396daea0f328c';

@ProviderFor(player1)
const player1Provider = Player1Provider._();

final class Player1Provider
    extends $FunctionalProvider<Player?, Player?, Player?>
    with $Provider<Player?> {
  const Player1Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'player1Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$player1Hash();

  @$internal
  @override
  $ProviderElement<Player?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Player? create(Ref ref) {
    return player1(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Player? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Player?>(value),
    );
  }
}

String _$player1Hash() => r'8925378ded86719ea36a03e9f8f5895905941e0f';

@ProviderFor(player2)
const player2Provider = Player2Provider._();

final class Player2Provider
    extends $FunctionalProvider<Player?, Player?, Player?>
    with $Provider<Player?> {
  const Player2Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'player2Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$player2Hash();

  @$internal
  @override
  $ProviderElement<Player?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Player? create(Ref ref) {
    return player2(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Player? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Player?>(value),
    );
  }
}

String _$player2Hash() => r'a5a793c357eabdb80ef0faff3039254e0c894468';

@ProviderFor(gameConfigFromGame)
const gameConfigFromGameProvider = GameConfigFromGameProvider._();

final class GameConfigFromGameProvider
    extends $FunctionalProvider<GameConfig?, GameConfig?, GameConfig?>
    with $Provider<GameConfig?> {
  const GameConfigFromGameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameConfigFromGameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameConfigFromGameHash();

  @$internal
  @override
  $ProviderElement<GameConfig?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GameConfig? create(Ref ref) {
    return gameConfigFromGame(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameConfig? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameConfig?>(value),
    );
  }
}

String _$gameConfigFromGameHash() =>
    r'f9da027ca54d5a3de66d9c3818de3cacadb70e51';

@ProviderFor(gameStatus)
const gameStatusProvider = GameStatusProvider._();

final class GameStatusProvider
    extends $FunctionalProvider<GameStatus?, GameStatus?, GameStatus?>
    with $Provider<GameStatus?> {
  const GameStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameStatusHash();

  @$internal
  @override
  $ProviderElement<GameStatus?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GameStatus? create(Ref ref) {
    return gameStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameStatus? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameStatus?>(value),
    );
  }
}

String _$gameStatusHash() => r'a61259101367b4bb9d9563f34d0c391f4189d577';
