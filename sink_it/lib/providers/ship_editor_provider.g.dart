// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_editor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShipEditor)
const shipEditorProvider = ShipEditorProvider._();

final class ShipEditorProvider extends $NotifierProvider<ShipEditor, Ship?> {
  const ShipEditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipEditorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipEditorHash();

  @$internal
  @override
  ShipEditor create() => ShipEditor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Ship? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Ship?>(value),
    );
  }
}

String _$shipEditorHash() => r'3bfcf3389ebdad4261d90bdc63a4b33649a1bc6a';

abstract class _$ShipEditor extends $Notifier<Ship?> {
  Ship? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Ship?, Ship?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Ship?, Ship?>,
              Ship?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
