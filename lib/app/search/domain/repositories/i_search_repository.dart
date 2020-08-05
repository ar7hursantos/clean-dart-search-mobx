import 'package:dartz/dartz.dart';

import '../entities/result.dart';
import '../errors/errors.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<Result>>> getUsers(String searchText);
}
