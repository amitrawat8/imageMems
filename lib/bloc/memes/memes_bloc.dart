import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:imageflip/model/mems_dto.dart';
import 'package:imageflip/utility/internet_util.dart';

import '../../repository/api_repository.dart';
import 'memes_event.dart';
import 'memes_state.dart';

class MemesBloc extends Bloc<MemesEvent, MemeState> {
  MemesBloc() : super(MemeInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetMemesList>((event, emit) async {
      try {
        emit(MemeLoading());

        var responses = await Future.wait([
          InternetUtil.check(),
          // make sure return type of these functions as Future.
          _apiRepository.getMemesList(),
        ]);
        var response1 = responses.first;
        if (response1 == false) {
          emit(const MemeError("Check Internet Connection"));
        } else {
          var mList = responses[1] as MemesDTO;
          emit(MemeLoaded(mList));
          if (mList.error != null) {
            emit(MemeError(mList.error));
          }
        }
      } on NetworkError {
        emit(const MemeError("Failed to fetch data. is your device online?"));
      } on SocketException {
        emit(
          const MemeError('No Internet'),
        );
      } on HttpException {
        emit(
          const MemeError('No Service Found'),
        );
      } on FormatException {
        emit(
          const MemeError('Invalid Response format'),
        );
      } catch (e) {
        emit(
          const MemeError('Unknown Error'),
        );
      }
    });
  }
}
