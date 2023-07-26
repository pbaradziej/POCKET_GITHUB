import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class GitHubRepositoryItem extends Equatable {
  final String url;
  final String fullName;
  final String description;
  final String language;
  final int starGazers;
  final String lastUpdated;

  const GitHubRepositoryItem({
    required this.url,
    required this.fullName,
    required this.description,
    required this.language,
    required this.starGazers,
    required this.lastUpdated,
  });

  factory GitHubRepositoryItem.fromJson(Map<String, Object?> json) {
    return GitHubRepositoryItem(
      url: json['url'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String? ?? '',
      language: json['language'] as String? ?? '',
      starGazers: json['stargazers_count'] as int,
      lastUpdated: formattedDate(json),
    );
  }

  static String formattedDate(Map<String, Object?> json) {
    final String lastUpdated = json['updated_at'] as String;
    final DateTime parsedDate = DateTime.parse(lastUpdated);
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return dateFormat.format(parsedDate);
  }

  @override
  List<Object?> get props => <Object?>[
        url,
        fullName,
        description,
        language,
        starGazers,
        lastUpdated,
      ];
}
