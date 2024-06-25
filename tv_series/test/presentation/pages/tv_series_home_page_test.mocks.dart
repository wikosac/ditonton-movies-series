// Mocks generated by Mockito 5.4.4 from annotations
// in tv_series/test/presentation/pages/tv_series_home_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_bloc/flutter_bloc.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/tv_series.dart' as _i2;

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

class _FakeNowPlayingTvState_0 extends _i1.SmartFake
    implements _i2.NowPlayingTvState {
  _FakeNowPlayingTvState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePopularTvState_1 extends _i1.SmartFake
    implements _i2.PopularTvState {
  _FakePopularTvState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTopRatedTvState_2 extends _i1.SmartFake
    implements _i2.TopRatedTvState {
  _FakeTopRatedTvState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NowPlayingTvCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockNowPlayingTvCubit extends _i1.Mock implements _i2.NowPlayingTvCubit {
  MockNowPlayingTvCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NowPlayingTvState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeNowPlayingTvState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.NowPlayingTvState);

  @override
  _i3.Stream<_i2.NowPlayingTvState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.NowPlayingTvState>.empty(),
      ) as _i3.Stream<_i2.NowPlayingTvState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void fetchNowPlayingTvSeries() => super.noSuchMethod(
        Invocation.method(
          #fetchNowPlayingTvSeries,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i2.NowPlayingTvState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i4.Change<_i2.NowPlayingTvState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [PopularTvCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularTvCubit extends _i1.Mock implements _i2.PopularTvCubit {
  MockPopularTvCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PopularTvState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakePopularTvState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.PopularTvState);

  @override
  _i3.Stream<_i2.PopularTvState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.PopularTvState>.empty(),
      ) as _i3.Stream<_i2.PopularTvState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void fetchPopularTvSeries() => super.noSuchMethod(
        Invocation.method(
          #fetchPopularTvSeries,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i2.PopularTvState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i4.Change<_i2.PopularTvState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [TopRatedTvCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTvCubit extends _i1.Mock implements _i2.TopRatedTvCubit {
  MockTopRatedTvCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TopRatedTvState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTopRatedTvState_2(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.TopRatedTvState);

  @override
  _i3.Stream<_i2.TopRatedTvState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i2.TopRatedTvState>.empty(),
      ) as _i3.Stream<_i2.TopRatedTvState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void fetchTopRatedTvSeries() => super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedTvSeries,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i2.TopRatedTvState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i4.Change<_i2.TopRatedTvState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
