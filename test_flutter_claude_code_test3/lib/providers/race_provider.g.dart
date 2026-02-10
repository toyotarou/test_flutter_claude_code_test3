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

/// 全レース結果を一括取得（SELECT * FROM t_hourse_race_result）

@ProviderFor(allRaceResults)
final allRaceResultsProvider = AllRaceResultsProvider._();

/// 全レース結果を一括取得（SELECT * FROM t_hourse_race_result）

final class AllRaceResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HourseRaceResult>>,
          List<HourseRaceResult>,
          FutureOr<List<HourseRaceResult>>
        >
    with
        $FutureModifier<List<HourseRaceResult>>,
        $FutureProvider<List<HourseRaceResult>> {
  /// 全レース結果を一括取得（SELECT * FROM t_hourse_race_result）
  AllRaceResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allRaceResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allRaceResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<HourseRaceResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HourseRaceResult>> create(Ref ref) {
    return allRaceResults(ref);
  }
}

String _$allRaceResultsHash() => r'3d0e32f0791ee1bfb6208d9997f1575b85e05460';

/// 馬名一覧（不要になったAPIコールをローカル集計に置き換え）

@ProviderFor(allHourseNames)
final allHourseNamesProvider = AllHourseNamesProvider._();

/// 馬名一覧（不要になったAPIコールをローカル集計に置き換え）

final class AllHourseNamesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// 馬名一覧（不要になったAPIコールをローカル集計に置き換え）
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

String _$allHourseNamesHash() => r'55a25acd01093e72cc59043ca4e424bc1d91b599';

/// 特定レースの結果（ローカルフィルタリング）

@ProviderFor(selectedResult)
final selectedResultProvider = SelectedResultFamily._();

/// 特定レースの結果（ローカルフィルタリング）

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
  /// 特定レースの結果（ローカルフィルタリング）
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

String _$selectedResultHash() => r'92fdda54ccb68dd760ea6fcae1c73e0f400c6ed2';

/// 特定レースの結果（ローカルフィルタリング）

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

  /// 特定レースの結果（ローカルフィルタリング）

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

/// 馬名で検索（ローカル完全一致フィルタリング、LIKE問題解消）

@ProviderFor(resultByHourseName)
final resultByHourseNameProvider = ResultByHourseNameFamily._();

/// 馬名で検索（ローカル完全一致フィルタリング、LIKE問題解消）

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
  /// 馬名で検索（ローカル完全一致フィルタリング、LIKE問題解消）
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
    r'5c630085cecc9bf4e4e0146cd84cce348bd293e2';

/// 馬名で検索（ローカル完全一致フィルタリング、LIKE問題解消）

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

  /// 馬名で検索（ローカル完全一致フィルタリング、LIKE問題解消）

  ResultByHourseNameProvider call({required String hourseName}) =>
      ResultByHourseNameProvider._(argument: hourseName, from: this);

  @override
  String toString() => r'resultByHourseNameProvider';
}

/// 馬名統計（ローカル集計に置き換え）

@ProviderFor(allHourseNamesWithStats)
final allHourseNamesWithStatsProvider = AllHourseNamesWithStatsProvider._();

/// 馬名統計（ローカル集計に置き換え）

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
  /// 馬名統計（ローカル集計に置き換え）
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
    r'99896a0cabdf5c1634b4e2e4e4f2d95af1c8d4ea';

/// アクティブ馬の結果Map（ローカルフィルタリング、個別APIコール不要）

@ProviderFor(activeHorseResults)
final activeHorseResultsProvider = ActiveHorseResultsProvider._();

/// アクティブ馬の結果Map（ローカルフィルタリング、個別APIコール不要）

final class ActiveHorseResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<HourseRaceResult>>>,
          Map<String, List<HourseRaceResult>>,
          FutureOr<Map<String, List<HourseRaceResult>>>
        >
    with
        $FutureModifier<Map<String, List<HourseRaceResult>>>,
        $FutureProvider<Map<String, List<HourseRaceResult>>> {
  /// アクティブ馬の結果Map（ローカルフィルタリング、個別APIコール不要）
  ActiveHorseResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeHorseResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeHorseResultsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<HourseRaceResult>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<HourseRaceResult>>> create(Ref ref) {
    return activeHorseResults(ref);
  }
}

String _$activeHorseResultsHash() =>
    r'8bd3d2ae1b969be541e13fa330c97d8b16df06f4';

@ProviderFor(raceMap)
final raceMapProvider = RaceMapProvider._();

final class RaceMapProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, HourseRaceList>>,
          Map<String, HourseRaceList>,
          FutureOr<Map<String, HourseRaceList>>
        >
    with
        $FutureModifier<Map<String, HourseRaceList>>,
        $FutureProvider<Map<String, HourseRaceList>> {
  RaceMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'raceMapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$raceMapHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, HourseRaceList>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, HourseRaceList>> create(Ref ref) {
    return raceMap(ref);
  }
}

String _$raceMapHash() => r'0f920000cfbf6209f04f414feb7f5b03cad8e55a';
