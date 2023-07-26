import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';

part 'git_hub_issues_state.dart';

class GitHubIssuesCubit extends Cubit<GitHubIssuesState> {
  final GitHubRepository repository;

  GitHubIssuesCubit({
    GitHubRepository? repository,
  })  : repository = repository ?? GitHubRepository(),
        super(const GitHubIssuesState(status: GitHubIssuesStatus.loading));

  Future<void> initializeIssuesOfRepository(String url) async {
    final List<GitHubRepositoryIssue> issues = await repository.getIssuesOfRepository(url);
    final GitHubIssuesState state = GitHubIssuesState(
      status: GitHubIssuesStatus.loaded,
      issues: issues,
    );
    emit(state);
  }
}
