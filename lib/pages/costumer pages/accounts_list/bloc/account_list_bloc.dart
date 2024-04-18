import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunya_app/data/model/offices_model.dart';
import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  final locator = GetIt.I.get<DBService>();
  List<OfficesModel> officeAccountData = [];
  AccountListBloc() : super(AccountListInitial()) {
    on<AccountListEvent>((event, emit) {});
    on<GetAccountEvent>(getAccountList);
  }

  //---- get office account list
  FutureOr<void> getAccountList(
      GetAccountEvent event, Emitter<AccountListState> emit) async {
    try {
      print('in the bloc');
      emit(LoadingHomeState());
      officeAccountData = await locator.getOfficeAccount(event.type);
      emit(SuccessHomeState(officeAccounte: officeAccountData));
    } catch (error) {
      emit(ErrorHomeState(msg: error.toString()));
    }
  }
}
