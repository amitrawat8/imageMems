
import 'package:equatable/equatable.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

abstract class MemesEvent extends Equatable {
  const MemesEvent();

  @override
  List<Object> get props => [];
}

class GetMemesList extends MemesEvent {}
