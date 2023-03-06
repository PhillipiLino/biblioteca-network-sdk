import 'package:equatable/equatable.dart';

enum EnvironmentType { production, staging, hml }

class Environment extends Equatable {
  final String name;
  final String prefix;
  final String apiKey;
  final EnvironmentType type;

  const Environment({
    required this.name,
    required this.prefix,
    required this.apiKey,
    required this.type,
  });

  @override
  List<Object?> get props => [
        name,
        prefix,
        apiKey,
      ];
}
