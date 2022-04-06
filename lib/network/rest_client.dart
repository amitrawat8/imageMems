import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import '../constant/rest_path.dart';
import '../model/mems_dto.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */
part 'rest_client.g.dart';

@RestApi(baseUrl: RestPath.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(RestPath.getmemes)
  Future<MemesDTO> getMemes();
}
