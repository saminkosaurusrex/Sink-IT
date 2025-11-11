// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$player1ShipsHash() => r'8d5cc0b9778f13f69761869c04f5850bf14221fa';

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

String _$player2ShipsHash() => r'f9904a2deb8b4368bf19a7f96b0b0cc539482dbb';

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
