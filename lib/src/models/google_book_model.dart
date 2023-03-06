import 'package:equatable/equatable.dart';

class GoogleBookModel extends Equatable {
  final String? id;
  final String? title;
  final List<String>? authors;
  final int? pageCount;
  final String? imagePath;

  static const String _id = 'id';
  static const String _title = 'title';
  static const String _authors = 'authors';
  static const String _pageCount = 'pageCount';
  static const String _imagePath = 'imagePath';

  static const String _volumeInfo = 'volumeInfo';
  static const String _imageLinks = 'imageLinks';
  static const String _thumbnail = 'thumbnail';

  const GoogleBookModel({
    this.id,
    this.title,
    this.authors,
    this.pageCount,
    this.imagePath,
  });

  GoogleBookModel.fromJson(Map<String, dynamic> json)
      : id = json[_id],
        title = json[_volumeInfo][_title],
        pageCount = json[_volumeInfo]?[_pageCount] ?? 0,
        imagePath = _getImageURL(json),
        authors = (json[_volumeInfo][_authors] as List?)
            ?.map((e) => e as String)
            .toList();

  static String _getImageURL(Map<String, dynamic> json) {
    const imageSize = '&fife=w400-h600';
    const edge = '&edge=curl';
    final String url =
        json[_volumeInfo][_imageLinks]?[_thumbnail].toString() ?? '';

    final formattedUrl = '${url.replaceFirst(edge, '')}$imageSize';
    return formattedUrl;
  }

  Map<String, dynamic> toJson() => {
        _id: id,
        _title: title,
        _authors: authors,
        _pageCount: pageCount,
        _imagePath: imagePath,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        pageCount,
        imagePath,
      ];
}
