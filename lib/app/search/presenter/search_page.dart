import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../search/domain/entities/result.dart';
import '../domain/errors/errors.dart';
import 'search_store.dart';
import 'states/search_state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {
  Widget _buildList(List<Result> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(item.nickname),
        );
      },
    );
  }

  Widget _buildError(Failure error) {
    if (error is EmptyList) {
      return Center(
        child: Text('Nada encontrado'),
      );
    } else if (error is ErrorSearch) {
      return Center(
        child: Text('Erro no github'),
      );
    } else {
      return Center(
        child: Text('Erro interno'),
      );
    }
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
          child: TextField(
            onChanged: controller.setSearchText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Pesquise...",
            ),
          ),
        ),
        Expanded(
          child: Observer(builder: (_) {
            var state = controller.state;

            if (state is ErrorState) {
              return _buildError(state.error);
            }

            if (state is StartState) {
              return Center(
                child: Text('Digite alguma coisa...'),
              );
            } else if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessState) {
              return _buildList(state.list);
            } else {
              return Container();
            }
          }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
      ),
      body: _buildBody(),
    );
  }
}
