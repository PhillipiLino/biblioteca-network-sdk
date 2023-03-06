import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:equatable/equatable.dart';

import 'google_book_model.dart';

class GoogleSearchModel extends Equatable {
  final String? kind;
  final int? totalItems;
  final List<GoogleBookModel>? items;

  static const String _kind = 'kind';
  static const String _totalItems = 'totalItems';
  static const String _items = 'items';

  const GoogleSearchModel({
    required this.kind,
    required this.totalItems,
    required this.items,
  });

  GoogleSearchModel.fromJson(Map<String, dynamic> json)
      : kind = castOrNull(json[_kind]),
        totalItems = castOrNull(json[_totalItems]),
        items = (json[_items] as List?)
            ?.map((e) => GoogleBookModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        _kind: kind,
        _totalItems: totalItems,
        _items: items?.map((e) => e.toJson()),
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
