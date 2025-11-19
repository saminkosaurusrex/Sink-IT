// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiService)
const apiServiceProvider = ApiServiceProvider._();

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  const ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: true,
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

String _$apiServiceHash() => r'5c6ea4385db7b77b113c9dc74cddddf572c0018e';

@ProviderFor(BoardSize)
const boardSizeProvider = BoardSizeProvider._();

final class BoardSizeProvider extends $NotifierProvider<BoardSize, int> {
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
  BoardSize create() => BoardSize();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$boardSizeHash() => r'4d2f4b2fea18ace9cc18a0ef880118ef32352c2c';

abstract class _$BoardSize extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CurrentGame)
const currentGameProvider = CurrentGameProvider._();

final class CurrentGameProvider extends $NotifierProvider<CurrentGame, Game?> {
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
  CurrentGame create() => CurrentGame();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Game? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Game?>(value),
    );
  }
}

String _$currentGameHash() => r'78d9934864589b8562d7f7b34fdaca3387e3a760';

abstract class _$CurrentGame extends $Notifier<Game?> {
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

@ProviderFor(CurrentPlayer)
const currentPlayerProvider = CurrentPlayerProvider._();

final class CurrentPlayerProvider
    extends $NotifierProvider<CurrentPlayer, Player?> {
  const CurrentPlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPlayerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPlayerHash();

  @$internal
  @override
  CurrentPlayer create() => CurrentPlayer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Player? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Player?>(value),
    );
  }
}

String _$currentPlayerHash() => r'a4d5480d3eed031c66aa69d1df28d1d8f901c1d3';

abstract class _$CurrentPlayer extends $Notifier<Player?> {
  Player? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Player?, Player?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Player?, Player?>,
              Player?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Player1Ships)
const player1ShipsProvider = Player1ShipsProvider._();

final class Player1ShipsProvider
    extends $NotifierProvider<Player1Ships, List<Ship>> {
  const Player1ShipsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'player1ShipsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$player1ShipsHash();

  @$internal
  @override
  Player1Ships create() => Player1Ships();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Ship> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Ship>>(value),
    );
  }
}

String _$player1ShipsHash() => r'80b477f29eec5b449356926edb3e1827a2b0ade1';

abstract class _$Player1Ships extends $Notifier<List<Ship>> {
  List<Ship> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Ship>, List<Ship>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Ship>, List<Ship>>,
              List<Ship>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Player2Ships)
const player2ShipsProvider = Player2ShipsProvider._();

final class Player2ShipsProvider
    extends $NotifierProvider<Player2Ships, List<Ship>> {
  const Player2ShipsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'player2ShipsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$player2ShipsHash();

  @$internal
  @override
  Player2Ships create() => Player2Ships();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Ship> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Ship>>(value),
    );
  }
}

String _$player2ShipsHash() => r'faa42c9342732dbbd791cb7b7bddb89bacab42b6';

abstract class _$Player2Ships extends $Notifier<List<Ship>> {
  List<Ship> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Ship>, List<Ship>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Ship>, List<Ship>>,
              List<Ship>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Create a new game

@ProviderFor(createGame)
const createGameProvider = CreateGameFamily._();

/// Create a new game

final class CreateGameProvider
    extends $FunctionalProvider<AsyncValue<Game>, Game, FutureOr<Game>>
    with $FutureModifier<Game>, $FutureProvider<Game> {
  /// Create a new game
  const CreateGameProvider._({
    required CreateGameFamily super.from,
    required GameConfig super.argument,
  }) : super(
         retry: null,
         name: r'createGameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createGameHash();

  @override
  String toString() {
    return r'createGameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Game> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Game> create(Ref ref) {
    final argument = this.argument as GameConfig;
    return createGame(ref, config: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateGameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createGameHash() => r'647ed528fe21ef7766331bf694b8313e8ca4ae62';

/// Create a new game

final class CreateGameFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Game>, GameConfig> {
  const CreateGameFamily._()
    : super(
        retry: null,
        name: r'createGameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Create a new game

  CreateGameProvider call({required GameConfig config}) =>
      CreateGameProvider._(argument: config, from: this);

  @override
  String toString() => r'createGameProvider';
}

/// Join an existing game

@ProviderFor(joinGame)
const joinGameProvider = JoinGameFamily._();

/// Join an existing game

final class JoinGameProvider
    extends $FunctionalProvider<AsyncValue<Player>, Player, FutureOr<Player>>
    with $FutureModifier<Player>, $FutureProvider<Player> {
  /// Join an existing game
  const JoinGameProvider._({
    required JoinGameFamily super.from,
    required ({String gameId, String playerName}) super.argument,
  }) : super(
         retry: null,
         name: r'joinGameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$joinGameHash();

  @override
  String toString() {
    return r'joinGameProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Player> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Player> create(Ref ref) {
    final argument = this.argument as ({String gameId, String playerName});
    return joinGame(
      ref,
      gameId: argument.gameId,
      playerName: argument.playerName,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is JoinGameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$joinGameHash() => r'854aae10ab7367f3130402b3860ea6a840ac2702';

/// Join an existing game

final class JoinGameFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Player>,
          ({String gameId, String playerName})
        > {
  const JoinGameFamily._()
    : super(
        retry: null,
        name: r'joinGameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Join an existing game

  JoinGameProvider call({required String gameId, required String playerName}) =>
      JoinGameProvider._(
        argument: (gameId: gameId, playerName: playerName),
        from: this,
      );

  @override
  String toString() => r'joinGameProvider';
}

/// Place ships for a player

@ProviderFor(placeShips)
const placeShipsProvider = PlaceShipsFamily._();

/// Place ships for a player

final class PlaceShipsProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Place ships for a player
  const PlaceShipsProvider._({
    required PlaceShipsFamily super.from,
    required ({String gameId, String playerId, List<Ship> ships})
    super.argument,
  }) : super(
         retry: null,
         name: r'placeShipsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$placeShipsHash();

  @override
  String toString() {
    return r'placeShipsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument =
        this.argument as ({String gameId, String playerId, List<Ship> ships});
    return placeShips(
      ref,
      gameId: argument.gameId,
      playerId: argument.playerId,
      ships: argument.ships,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PlaceShipsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$placeShipsHash() => r'3b8a641e14e1247e1f91376be56c56b8d74fe2df';

/// Place ships for a player

final class PlaceShipsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({String gameId, String playerId, List<Ship> ships})
        > {
  const PlaceShipsFamily._()
    : super(
        retry: null,
        name: r'placeShipsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Place ships for a player

  PlaceShipsProvider call({
    required String gameId,
    required String playerId,
    required List<Ship> ships,
  }) => PlaceShipsProvider._(
    argument: (gameId: gameId, playerId: playerId, ships: ships),
    from: this,
  );

  @override
  String toString() => r'placeShipsProvider';
}

/// Set player as ready

@ProviderFor(setPlayerReady)
const setPlayerReadyProvider = SetPlayerReadyFamily._();

/// Set player as ready

final class SetPlayerReadyProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Set player as ready
  const SetPlayerReadyProvider._({
    required SetPlayerReadyFamily super.from,
    required ({String gameId, String playerId}) super.argument,
  }) : super(
         retry: null,
         name: r'setPlayerReadyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$setPlayerReadyHash();

  @override
  String toString() {
    return r'setPlayerReadyProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as ({String gameId, String playerId});
    return setPlayerReady(
      ref,
      gameId: argument.gameId,
      playerId: argument.playerId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SetPlayerReadyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$setPlayerReadyHash() => r'74af6de446d8c2cf029af1665de0f1af490ea34d';

/// Set player as ready

final class SetPlayerReadyFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({String gameId, String playerId})
        > {
  const SetPlayerReadyFamily._()
    : super(
        retry: null,
        name: r'setPlayerReadyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Set player as ready

  SetPlayerReadyProvider call({
    required String gameId,
    required String playerId,
  }) => SetPlayerReadyProvider._(
    argument: (gameId: gameId, playerId: playerId),
    from: this,
  );

  @override
  String toString() => r'setPlayerReadyProvider';
}
