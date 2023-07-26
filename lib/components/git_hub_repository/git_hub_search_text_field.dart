import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_github/cubits/git_hub/git_hub_cubit.dart';

class GitHubSearchTextField extends StatefulWidget {
  const GitHubSearchTextField({Key? key}) : super(key: key);

  @override
  State<GitHubSearchTextField> createState() => _GitHubSearchTextFieldState();
}

class _GitHubSearchTextFieldState extends State<GitHubSearchTextField> {
  late GitHubCubit gitHubCubit;
  late TextEditingController searchTextController;

  @override
  void initState() {
    super.initState();
    gitHubCubit = context.read();
    searchTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: 'Search repository...',
        suffixIcon: InkWell(
          onTap: onSubmitted,
          child: const Icon(
            Icons.search,
          ),
        ),
      ),
      onSubmitted: (_) => onSubmitted(),
    );
  }

  void onSubmitted() {
    final String text = searchTextController.text;
    gitHubCubit.searchForGitHubRepositories(text);
    searchTextController.clear();
  }
}
