import 'package:equatable/equatable.dart';

import '../../model/mems_dto.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

abstract class OfflineState extends Equatable {
  const OfflineState();

  @override
  List<Object?> get props => [];
}

class OfflineInitial extends OfflineState {}

class OfflineLoading extends OfflineState {}

class OfflineLoaded extends OfflineState {
  final List<Memes>? memesDto;

  const OfflineLoaded(this.memesDto);
}

class OfflineError extends OfflineState {
  final String? message;

  const OfflineError(this.message);
}
