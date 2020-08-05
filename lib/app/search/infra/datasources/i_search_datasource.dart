import '../models/result_model.dart';

abstract class ISearchDatasource {
  Future<List<ResultModel>> searchText(String textSearch);
}
