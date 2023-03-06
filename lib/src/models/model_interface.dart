abstract class IModel {
  // coverage:ignore-start
  IModel.fromJson(Map<String, dynamic> json);
  // coverage:ignore-end
  Map<String, dynamic> toJson();
}

final factories = <Type, Function>{};

T make<T>(Map<String, dynamic> x) => factories[T]?.call(x);
