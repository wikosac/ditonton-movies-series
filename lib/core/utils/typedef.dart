import 'package:dartz/dartz.dart';
import 'package:ditonton/core/utils/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;
