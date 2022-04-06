// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mems_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemesDTO _$MemesDTOFromJson(Map<String, dynamic> json) => MemesDTO(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    )..error = json['error'] as String?;

Map<String, dynamic> _$MemesDTOToJson(MemesDTO instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'error': instance.error,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      memes: (json['memes'] as List<dynamic>?)
          ?.map((e) => Memes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'memes': instance.memes,
    };

Memes _$MemesFromJson(Map<String, dynamic> json) => Memes(
      id: json['id'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      bookmark: json['bookmark'] as bool? ?? false,
    );

Map<String, dynamic> _$MemesToJson(Memes instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'bookmark': instance.bookmark,
    };
