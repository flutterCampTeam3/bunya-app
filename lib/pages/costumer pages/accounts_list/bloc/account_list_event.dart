part of 'account_list_bloc.dart';

@immutable
sealed class AccountListEvent {}

class GetAccountEvent extends AccountListEvent {
  final String type;


  GetAccountEvent( {  required this.type});
}
class ShowFollowersEvent extends AccountListEvent {

  final String id;

  ShowFollowersEvent({required this.id, });
}


class SearchWord extends AccountListEvent {
  final String word;
  final String type;

  SearchWord({required this.word, required this.type});
  
}
