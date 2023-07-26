part of 'git_hub_cubit.dart';

enum GitHubStatus {
  initial,
  loading,
  loaded,
}

@immutable
class GitHubState extends Equatable {
  final GitHubStatus status;
  final List<GitHubRepositoryItem> items;

  const GitHubState({
    required this.status,
    this.items = const <GitHubRepositoryItem>[],
  });

  @override
  List<Object> get props => <Object>[
        status,
        items,
      ];
}
