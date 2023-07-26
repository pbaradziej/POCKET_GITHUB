import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_repository_card.dart';
import 'package:pocket_github/cubits/git_hub/git_hub_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/widgets/empty_screen.dart';
import 'package:pocket_github/widgets/loading_screen.dart';

class GitHubRepositoriesListView extends StatefulWidget {
  const GitHubRepositoriesListView({Key? key}) : super(key: key);

  @override
  State<GitHubRepositoriesListView> createState() => _GitHubRepositoriesListViewState();
}

class _GitHubRepositoriesListViewState extends State<GitHubRepositoriesListView> {
  late GitHubCubit gitHubCubit;

  @override
  void initState() {
    super.initState();
    gitHubCubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    final GitHubState state = context.select<GitHubCubit, GitHubState>(getGitHubState);
    final GitHubStatus status = state.status;
    final List<GitHubRepositoryItem> items = state.items;
    if (status == GitHubStatus.initial) {
      return showEmptyScreen('Search for repositories');
    } else if (status == GitHubStatus.loading) {
      return showLoadingScreen();
    } else if (items.isEmpty) {
      return showEmptyScreen('No repositories found');
    }

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => repositoriesDetails(items, index),
      ),
    );
  }

  Widget showEmptyScreen(String message) {
    return Expanded(
      child: EmptyScreen(
        message: message,
      ),
    );
  }

  Widget showLoadingScreen() {
    return const Expanded(
      child: LoadingScreen(),
    );
  }

  GitHubState getGitHubState(GitHubCubit cubit) {
    return cubit.state;
  }

  Widget repositoriesDetails(List<GitHubRepositoryItem> items, int index) {
    final GitHubRepositoryItem gitHubRepositoryItem = items[index];
    return GitHubRepositoryCard(item: gitHubRepositoryItem);
  }
}
