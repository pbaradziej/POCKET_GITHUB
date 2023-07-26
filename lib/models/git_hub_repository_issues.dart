import 'package:equatable/equatable.dart';

class GitHubRepositoryIssue extends Equatable {
  final String title;
  final String body;
  final String state;

  const GitHubRepositoryIssue({
    required this.title,
    required this.body,
    required this.state,
  });

  factory GitHubRepositoryIssue.fromJson(final Map<String, Object?> json) {
    return GitHubRepositoryIssue(
      title: json['title'] as String,
      body: json['body'] as String? ?? '',
      state: json['state'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        title,
        body,
        state,
      ];
}
