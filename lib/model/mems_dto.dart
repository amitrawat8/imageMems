import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */
part 'mems_dto.g.dart';

@JsonSerializable()
class MemesDTO {
  bool? success;
  Data? data;
  String? error;

  MemesDTO.withError(String errorMessage) {
    error = errorMessage;
  }

  MemesDTO({this.success, this.data});

  factory MemesDTO.fromJson(Map<String, dynamic> json) =>
      _$MemesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MemesDTOToJson(this);
}

@JsonSerializable()
class Data {
  List<Memes>? memes;

  Data({this.memes});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Memes {
  String? id;
  String? name;
  String? url;
  bool? bookmark;
  String? error;

  /*int? width;
  int? height;
  int? boxCount;*/
  Memes.withError(String errorMessage) {
    error = errorMessage;
  }

  Memes({this.id, this.name, this.url, this.bookmark = false});

  factory Memes.fromJson(Map<String, dynamic> json) => _$MemesFromJson(json);

  Map<String, dynamic> toJson() => _$MemesToJson(this);

  @override
  String toString() {
    return 'Memes{id: $id, name: $name, url: $url, bookmark: $bookmark}';
  }
}
