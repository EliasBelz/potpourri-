// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      abbr: json['abbr'] as String,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      rating: (json['rating'] as num).toInt(),
      ratingCount: (json['ratings'] as num).toInt(),
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'abbr': instance.abbr,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'rating': instance.rating,
      'ratings': instance.ratingCount,
    };
