import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../search/domain/entities/result.dart';
import '../../../search/infra/models/result_model.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/i_search_repository.dart';
import '../datasources/i_search_datasource.dart';

part 'search_repository_impl.g.dart';

@Injectable(singleton: false)
class SearchRepositoryImpl implements ISearchRepository {
  final ISearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Result>>> getUsers(String searchText) async {
    List<ResultModel> list;

    try {
      list = await datasource.searchText(searchText);
    } on Failure catch (_) {
      return left(ErrorSearch());
    }

    return list == null ? left(DatasourceResultNull()) : right(list);
  }
}
