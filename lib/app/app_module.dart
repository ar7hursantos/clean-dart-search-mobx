import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';
import 'search/domain/usecases/search_by_text.dart';
import 'search/external/github/github_search_datasource.dart';
import 'search/infra/repositories/search_repository_impl.dart';
import 'search/presenter/search_page.dart';
import 'search/presenter/search_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GithubSearchDatasource(i())),
        Bind((i) => SearchStore(i())),

        // $SearchByTextImpl,
        // $SearchRepositoryImpl,
        // $GithubSearchDatasource,
        // $SearchStore,
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, __) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
