// Mocks generated by Mockito 5.4.4 from annotations
// in watchlist/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:convert' as _i16;
import 'dart:typed_data' as _i17;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/src/base_request.dart' as _i15;
import 'package:http/src/io_client.dart' as _i14;
import 'package:http/src/io_streamed_response.dart' as _i3;
import 'package:http/src/response.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i11;
import 'package:sqflite/sqflite.dart' as _i13;
import 'package:watchlist/data/models/watchlist_table.dart' as _i10;
import 'package:watchlist/data/sources/database_helper.dart' as _i12;
import 'package:watchlist/data/sources/watchlist_data_source.dart' as _i9;
import 'package:watchlist/domain/entities/watchlist.dart' as _i8;
import 'package:watchlist/domain/repositories/watchlist_repository.dart' as _i5;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIOStreamedResponse_1 extends _i1.SmartFake
    implements _i3.IOStreamedResponse {
  _FakeIOStreamedResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WatchlistRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistRepository extends _i1.Mock
    implements _i5.WatchlistRepository {
  MockWatchlistRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i8.Watchlist? watchlist) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [watchlist],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [watchlist],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [id],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);

  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Watchlist>>> getWatchlist() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.Watchlist>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.Watchlist>>(
          this,
          Invocation.method(
            #getWatchlist,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Watchlist>>>);
}

/// A class which mocks [WatchlistDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistDataSource extends _i1.Mock
    implements _i9.WatchlistDataSource {
  MockWatchlistDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i10.WatchlistTable? watchlist) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchlist],
        ),
        returnValue: _i6.Future<String>.value(_i11.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlist,
            [watchlist],
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<String> removeWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [id],
        ),
        returnValue: _i6.Future<String>.value(_i11.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [id],
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i10.WatchlistTable?> getWatchlistById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistById,
          [id],
        ),
        returnValue: _i6.Future<_i10.WatchlistTable?>.value(),
      ) as _i6.Future<_i10.WatchlistTable?>);

  @override
  _i6.Future<List<_i10.WatchlistTable>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i6.Future<List<_i10.WatchlistTable>>.value(
            <_i10.WatchlistTable>[]),
      ) as _i6.Future<List<_i10.WatchlistTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i12.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i13.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i6.Future<_i13.Database?>.value(),
      ) as _i6.Future<_i13.Database?>);

  @override
  _i6.Future<int> insertWatchlist(_i10.WatchlistTable? watchlistTable) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchlistTable],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<int> removeWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [id],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<Map<String, dynamic>?> getWatchlistById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);

  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i14.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.IOStreamedResponse> send(_i15.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i6.Future<_i3.IOStreamedResponse>.value(_FakeIOStreamedResponse_1(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i6.Future<_i3.IOStreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i16.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i16.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i16.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i16.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i6.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response>);

  @override
  _i6.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<String>.value(_i11.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i17.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i6.Future<_i17.Uint8List>.value(_i17.Uint8List(0)),
      ) as _i6.Future<_i17.Uint8List>);
}
