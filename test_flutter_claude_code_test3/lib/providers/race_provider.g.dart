// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allRace)
final allRaceProvider = AllRaceProvider._();

final class AllRaceProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HourseRaceList>>,
          List<HourseRaceList>,
          FutureOr<List<HourseRaceList>>
        >
    with
        $FutureModifier<List<HourseRaceList>>,
        $FutureProvider<List<HourseRaceList>> {
  AllRaceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allRaceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allRaceHash();

  @$internal
  @override
  $FutureProviderElement<List<HourseRaceList>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourseRaceList>> create(Ref ref) {
    return allRace(ref);
  }
}

String _$allRaceHash() => r'1293f8c593d45df13c3e59acaff964d8f37c307c';

@ProviderFor(SelectedYear)
final selectedYearProvider = SelectedYearProvider._();

final class SelectedYearProvider
    extends $NotifierProvider<SelectedYear, String?> {
  SelectedYearProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedYearProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedYearHash();

  @$internal
  @override
  SelectedYear create() => SelectedYear();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedYearHash() => r'c1b5f555d42612ff879b8b5383161ce2ee8f5fb7';

abstract class _$SelectedYear extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(allHourseNames)
final allHourseNamesProvider = AllHourseNamesProvider._();

final class AllHourseNamesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  AllHourseNamesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allHourseNamesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allHourseNamesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return allHourseNames(ref);
  }
}

String _$allHourseNamesHash() => r'1706c2455910bf433dbd7fc7c169a4414c5fbb30';

@ProviderFor(selectedResult)
final selectedResultProvider = SelectedResultFamily._();

final class SelectedResultProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HourseRaceResult>>,
          List<HourseRaceResult>,
          FutureOr<List<HourseRaceResult>>
        >
    with
        $FutureModifier<List<HourseRaceResult>>,
        $FutureProvider<List<HourseRaceResult>> {
  SelectedResultProvider._({
    required SelectedResultFamily super.from,
    required ({String year, String month, String day, String raceName})
    super.argument,
  }) : super(
         retry: null,
         name: r'selectedResultProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedResultHash();

  @override
  String toString() {
    return r'selectedResultProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<HourseRaceResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourseRaceResult>> create(Ref ref) {
    final argument =
        this.argument
            as ({String year, String month, String day, String raceName});
    return selectedResult(
      ref,
      year: argument.year,
      month: argument.month,
      day: argument.day,
      raceName: argument.raceName,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedResultProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedResultHash() => r'3e7ffa2cac621fb57cca89fa56c6b2e506e2e937';

final class SelectedResultFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<HourseRaceResult>>,
          ({String year, String month, String day, String raceName})
        > {
  SelectedResultFamily._()
    : super(
        retry: null,
        name: r'selectedResultProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedResultProvider call({
    required String year,
    required String month,
    required String day,
    required String raceName,
  }) => SelectedResultProvider._(
    argument: (year: year, month: month, day: day, raceName: raceName),
    from: this,
  );

  @override
  String toString() => r'selectedResultProvider';
}

@ProviderFor(resultByHourseName)
final resultByHourseNameProvider = ResultByHourseNameFamily._();

final class ResultByHourseNameProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HourseRaceResult>>,
          List<HourseRaceResult>,
          FutureOr<List<HourseRaceResult>>
        >
    with
        $FutureModifier<List<HourseRaceResult>>,
        $FutureProvider<List<HourseRaceResult>> {
  ResultByHourseNameProvider._({
    required ResultByHourseNameFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'resultByHourseNameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resultByHourseNameHash();

  @override
  String toString() {
    return r'resultByHourseNameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<HourseRaceResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourseRaceResult>> create(Ref ref) {
    final argument = this.argument as String;
    return resultByHourseName(ref, hourseName: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ResultByHourseNameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resultByHourseNameHash() =>
    r'e93ccc104c0c21b22b00d8aacf6fc2de11bac572';

final class ResultByHourseNameFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<HourseRaceResult>>, String> {
  ResultByHourseNameFamily._()
    : super(
        retry: null,
        name: r'resultByHourseNameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResultByHourseNameProvider call({required String hourseName}) =>
      ResultByHourseNameProvider._(argument: hourseName, from: this);

  @override
  String toString() => r'resultByHourseNameProvider';
}

@ProviderFor(allHourseNamesWithStats)
final allHourseNamesWithStatsProvider = AllHourseNamesWithStatsProvider._();

final class AllHourseNamesWithStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HourseNameStats>>,
          List<HourseNameStats>,
          FutureOr<List<HourseNameStats>>
        >
    with
        $FutureModifier<List<HourseNameStats>>,
        $FutureProvider<List<HourseNameStats>> {
  AllHourseNamesWithStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allHourseNamesWithStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allHourseNamesWithStatsHash();

  @$internal
  @override
  $FutureProviderElement<List<HourseNameStats>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourseNameStats>> create(Ref ref) {
    return allHourseNamesWithStats(ref);
  }
}

String _$allHourseNamesWithStatsHash() =>
    r'f03537325e025e8c123148309242a51e8214018d';
