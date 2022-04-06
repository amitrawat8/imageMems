

import '../model/mems_dto.dart';
import 'api_provider.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */

class ApiRepository {
  final _provider = ApiProvider();

  Future<MemesDTO> getMemesList() {
    return _provider.getMemesList();
  }

}

class NetworkError extends Error {}
