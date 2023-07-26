import 'package:flutter/material.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_repositories_list_view.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_search_text_field.dart';

class GitHubRepositoriesPage extends StatelessWidget {
  const GitHubRepositoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          GitHubSearchTextField(),
          SizedBox(height: 10),
          GitHubRepositoriesListView(),
        ],
      ),
    );
  }
}
