// Mocks generated by Mockito 5.4.4 from annotations
// in search/test/presentation/pages/search_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i8;

import 'package:core/core.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:search/domain/entities/search.dart' as _i5;
import 'package:search/domain/usecases/search_usecase.dart' as _i2;
import 'package:search/presentation/provider/search_notifier.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSearchUseCase_0 extends _i1.SmartFake implements _i2.SearchUseCase {
  _FakeSearchUseCase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchNotifier extends _i1.Mock implements _i3.SearchNotifier {
  MockSearchNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchUseCase get searchUsecase => (super.noSuchMethod(
        Invocation.getter(#searchUsecase),
        returnValue: _FakeSearchUseCase_0(
          this,
          Invocation.getter(#searchUsecase),
        ),
      ) as _i2.SearchUseCase);

  @override
  _i4.RequestState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i4.RequestState.Empty,
      ) as _i4.RequestState);

  @override
  List<_i5.Search> get searchResult => (super.noSuchMethod(
        Invocation.getter(#searchResult),
        returnValue: <_i5.Search>[],
      ) as List<_i5.Search>);

  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.getter(#message),
        ),
      ) as String);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i7.Future<void> fetchSearch(String? query) => (super.noSuchMethod(
        Invocation.method(
          #fetchSearch,
          [query],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}