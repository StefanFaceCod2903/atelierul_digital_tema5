// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Movie$ _$$Movie$FromJson(Map<String, dynamic> json) => _$Movie$(
      title: json['title'] as String,
      year: json['year'] as int,
      rating: (json['rating'] as num).toDouble(),
      descriptionFull: json['description_full'] as String,
      image: json['medium_cover_image'] as String,
      torrents: (json['torrents'] as List<dynamic>)
          .map((dynamic e) => Torrent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Movie$ToJson(_$Movie$ instance) => <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'rating': instance.rating,
      'description_full': instance.descriptionFull,
      'medium_cover_image': instance.image,
      'torrents': instance.torrents,
    };

_$Torrent$ _$$Torrent$FromJson(Map<String, dynamic> json) => _$Torrent$(
      url: json['url'] as String,
      hash: json['hash'] as String,
      quality: json['quality'] as String,
    );

Map<String, dynamic> _$$Torrent$ToJson(_$Torrent$ instance) =>
    <String, dynamic>{
      'url': instance.url,
      'hash': instance.hash,
      'quality': instance.quality,
    };

_$AppState$ _$$AppState$FromJson(Map<String, dynamic> json) => _$AppState$(
      movies: (json['movies'] as List<dynamic>?)
              ?.map((dynamic e) => Movie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Movie>[],
      isLoading: json['isLoading'] as bool? ?? true,
      currentPage: json['currentPage'] as int? ?? 1,
      selectedMovie: json['selectedMovie'] == null
          ? null
          : Movie.fromJson(json['selectedMovie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppState$ToJson(_$AppState$ instance) =>
    <String, dynamic>{
      'movies': instance.movies,
      'isLoading': instance.isLoading,
      'currentPage': instance.currentPage,
      'selectedMovie': instance.selectedMovie,
    };
