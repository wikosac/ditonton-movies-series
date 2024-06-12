import 'package:dartz/dartz.dart';
import 'package:ditonton/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;
