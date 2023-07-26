import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';

part 'git_hub_state.dart';

class GitHubCubit extends Cubit<GitHubState> {
  final GitHubRepository repository;

  GitHubCubit({
    GitHubRepository? repository,
  })  : repository = repository ?? GitHubRepository(),
        super(const GitHubState(status: GitHubStatus.initial));

  Future<void> searchForGitHubRepositories(String search) async {
    _emitGitHubState(status: GitHubStatus.loading);
    final List<GitHubRepositoryItem> items = await repository.searchForGitHubRepositories(search);
    _emitGitHubState(items: items);
  }

  void _emitGitHubState({
    GitHubStatus? status,
    List<GitHubRepositoryItem> items = const <GitHubRepositoryItem>[],
  }) {
    final GitHubState state = GitHubState(
      status: status ?? GitHubStatus.loaded,
      items: items,
    );
    emit(state);
  }
}
