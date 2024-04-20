part of 'post_page_bloc.dart';

@immutable
sealed class PostPageEvent {}

class ShowPostDataIdEvent extends PostPageEvent {
  final String id;
  ShowPostDataIdEvent({required this.id});
}

class CheckPostFollowEvent extends PostPageEvent {
  final String id;
  CheckPostFollowEvent({required this.id});
}
