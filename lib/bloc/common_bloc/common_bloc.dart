import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState());
}
