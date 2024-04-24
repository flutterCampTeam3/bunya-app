import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../data/service/supabase_services.dart';

part 'support_event.dart';
part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportInitial()) {
    on<SendMassageEvent>(sendMassage);
  }

  FutureOr<void> sendMassage(
      SendMassageEvent event, Emitter<SupportState> emit) async {
        
    try {
             await GetIt.I.get<DBService>().addProblemMassage(massage:event.massage );
             emit(SuccessSendState(msg: "قد تم ارسال مشكلتك سيتم التواصل معك قريبا"));
    }catch (e){
      emit(ErrorSendState(msg: "لقد حصل خطاء فالارسال"));
    }

  }
}
