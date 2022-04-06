
import 'package:equatable/equatable.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */

abstract class OfflineEvent extends Equatable {
  const OfflineEvent();

  @override
  List<Object> get props => [];
}

class GetOfflineMemesList extends OfflineEvent {}
