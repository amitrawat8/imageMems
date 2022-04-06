import 'dart:io';

import 'package:imageflip/model/mems_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../offline/SQLiteDbProvider.dart';
import '../../repository/api_repository.dart';
import '../../utility/internet_util.dart';
import 'offine_state.dart';
import 'offline_event.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  OfflineBloc() : super(OfflineInitial()) {
    on<GetOfflineMemesList>((event, emit) async {
      try {
        emit(OfflineLoading());

        var responses = await Future.wait([
          InternetUtil.check(),
          SQLiteDbProvider.db.getAllMemesData(),
        ]);

        var response1 = responses.first;
        if (response1 == false) {
          emit(const OfflineError("Check your Internet Connection"));
        } else {
          var mList = responses[1] as List<Memes>;
          emit(OfflineLoaded(mList));
        }
      } on NetworkError {
        emit(const OfflineError("Failed to fetch data. is your device online?"));
      } on SocketException {
        emit(
          const OfflineError('No Internet'),
        );
      } on HttpException {
        emit(
          const OfflineError('No Service Found'),
        );
      } on FormatException {
        emit(
          const OfflineError('Invalid Response format'),
        );
      } catch (e) {
        emit(
          const OfflineError('Something Went Wrong'),
        );
      }
    });
  }
}
