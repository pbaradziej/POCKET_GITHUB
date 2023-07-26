part of 'git_hub_issues_cubit.dart';

enum GitHubIssuesStatus {
  loading,
  loaded,
}

@immutable
class GitHubIssuesState extends Equatable {
  final GitHubIssuesStatus status;
  final List<GitHubRepositoryIssue> issues;

  const GitHubIssuesState({
    required this.status,
    this.issues = const <GitHubRepositoryIssue>[],
  });

  @override
  List<Object> get props => <Object>[
        status,
        issues,
      ];
}
