import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../search/domain/entities/result.dart';
import '../errors/errors.dart';
import '../repositories/i_search_repository.dart';

part 'search_by_text.g.dart';

mixin ISearchByText {
  Future<Either<Failure, List<Result>>> call(String textSearch);
}

@Injectable(singleton: false)
class SearchByTextImpl implements ISearchByText {
  final ISearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<Failure, List<Result>>> call(String textSearch) async {
    var option = optionOf(textSearch);

    return option.fold(() => Left(InvalidSearchText()), (text) async {
      if (text.isNotEmpty) {
        var result = await repository.getUsers(text);
        return result.fold(
            (l) => left(l), (r) => r.isEmpty ? left(EmptyList()) : right(r));
      } else {
        return left(EmptyList());
      }
    });
  }
}
