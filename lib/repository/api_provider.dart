import 'package:imageflip/offline/SQLiteDbProvider.dart';

import '../model/mems_dto.dart';
import '../network/http_client.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */

class ApiProvider {
  Future<MemesDTO> getMemesList() async {
    try {
      var response = await HttpObj.instance.getClient().getMemes();
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MemesDTO.withError("Data not found / Connection issue");
    }
  }


}
