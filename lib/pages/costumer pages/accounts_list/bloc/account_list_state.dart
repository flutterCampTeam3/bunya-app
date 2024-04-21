part of 'account_list_bloc.dart';

@immutable
sealed class AccountListState {}

final class AccountListInitial extends AccountListState {}

final class LoadingHomeState extends AccountListState {}

final class ChangeState extends AccountListState {}

final class ErrorHomeState extends AccountListState {
  final String msg;
  ErrorHomeState({required this.msg});
}

final class SuccessHomeState extends AccountListState {
  final List<OfficesModel> officeAccounte;
  SuccessHomeState({required this.officeAccounte});
}

class LoadeWords extends AccountListState {
  final List<String> words;

  LoadeWords({required this.words});
}

class Search extends AccountListState {
  final List<OfficesModel> Listaccount;

  Search({required this.Listaccount});

}
