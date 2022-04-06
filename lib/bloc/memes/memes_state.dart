import 'package:equatable/equatable.dart';

import '../../model/mems_dto.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

abstract class MemeState extends Equatable {
  const MemeState();

  @override
  List<Object?> get props => [];
}

class MemeInitial extends MemeState {}

class MemeLoading extends MemeState {}

class MemeLoaded extends MemeState {
  final MemesDTO? memesDto;

  const MemeLoaded(this.memesDto);
}

class MemeError extends MemeState {
  final String? message;

  const MemeError(this.message);
}
