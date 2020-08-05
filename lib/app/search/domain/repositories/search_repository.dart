import 'package:dartz/dartz.dart';

import '../../../search/domain/entities/result.dart';
import '../errors/errors.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Result>>> getUsers(String searchText);
}
