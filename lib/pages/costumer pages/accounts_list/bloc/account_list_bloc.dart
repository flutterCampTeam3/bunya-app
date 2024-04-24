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
  List<OfficesModel> SearchofficeAccountData = [];
  int followerNumber = 0;

  AccountListBloc() : super(AccountListInitial()) {
    on<AccountListEvent>((event, emit) {});
    on<GetAccountEvent>(getAccountList);
    on<SearchWord>(getSearchAccountList);
    on<ShowFollowersEvent>(ShowFollowers);

    // on<SearchWord>((event, emit) {
    //   List<OfficesModel> SearchofficeAccountData = [];
    //   for (var element in officeAccountData) {
    //     if (element.contains(event.word)) {
    //       SearchofficeAccountData.add(element);
    //     }
    //   }
    //   emit(
    //     LoadeWords(words: SearchofficeAccountData
    //     ));
    // });
  }
//---- get Search office account list

  FutureOr<void> getSearchAccountList(
      SearchWord event, Emitter<AccountListState> emit) async {
    try {
      emit(LoadingHomeState());
      SearchofficeAccountData.clear();

      officeAccountData = await locator.getSearchOfficeAccount(event.word);
      final String search = event.word;
      print(search);
      print("==============================================");
      if (search.trim().isEmpty) {
        officeAccountData = await locator.getOfficeAccount(event.type);
        officeAccountData = await locator.getOfficeAccount(event.type);
      } else if (search.startsWith(event.word)) {
        for (var e in officeAccountData) {
          // search.startsWith(SearchofficeAccountData.add(e));
          SearchofficeAccountData.add(e);
          // SearchofficeAccountData.add(e);
        }
      }
      emit(SuccessHomeState());
    }
//------------------------------------------------------

    // FutureOr<void> getSearchAccountList(
    //     SearchWord event, Emitter<AccountListState> emit) async {
    //   try {
    //     emit(LoadingHomeState());
    //     SearchofficeAccountData.clear();

    //     officeAccountData = await locator.getSearchOfficeAccount(event.word);
    //     final String search = event.word;
    //     print(search);
    //     print("==============================================");
    //     for (var e in officeAccountData) {
    //       if (e.name == search) {
    //         SearchofficeAccountData.add(e);
    //       }
    //     }
    //     emit(SuccessHomeState(
    //         officeAccounte:
    //             search.isEmpty ? officeAccountData : SearchofficeAccountData));
    //   }
    //   emit(SuccessHomeState(officeAccounte: SearchofficeAccountData));
    // }
    catch (error) {
      emit(ErrorHomeState(msg: 'حدث خطا اثناء محاولة جلب البيانات'));
    }
  }

  //---- get office account list
  FutureOr<void> getAccountList(
      GetAccountEvent event, Emitter<AccountListState> emit) async {
    try {
      emit(LoadingHomeState());
      print("------------------------");
      officeAccountData = await locator.getOfficeAccount(event.type);
      print("-------------------------------------u--------------------");
      emit(SuccessHomeState());
    } catch (error) {
      emit(ErrorHomeState(msg: 'حدث خطا اثناء محاولة جلب البيانات'));
    }
  }

  //--------ShowFollowersEvent
  FutureOr<void> ShowFollowers(
      ShowFollowersEvent event, Emitter<AccountListState> emit) async {
    try {
      emit(LoadingHomeState());
      print("---------------out----");
      followerNumber = await DBService().followerNumber(officeId: event.id);
      print("---------------in----");
      emit(SuccessHomeState());
    } catch (error) {
      emit(ErrorHomeState(msg: 'حدث خطا اثناء محاولة جلب البيانات'));
    }
  }
}
