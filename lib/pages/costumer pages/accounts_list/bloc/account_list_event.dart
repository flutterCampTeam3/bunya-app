part of 'account_list_bloc.dart';

@immutable
sealed class AccountListEvent {}

class GetAccountEvent extends AccountListEvent {
  final String type;

  GetAccountEvent({required this.type});
}

class SearchWord extends AccountListEvent {
  final String word;
  SearchWord({required this.word});
}
