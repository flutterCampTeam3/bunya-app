part of 'post_page_bloc.dart';

@immutable
sealed class PostPageEvent {}

class CheckPostFollowEvent extends PostPageEvent {
  final String id;
  CheckPostFollowEvent({required this.id});
}


final class AddLikePostEvent extends PostPageEvent {
  final postModel post;
  AddLikePostEvent({required this.post});
}

final class CheckLikePostEvent extends PostPageEvent {
  final String id;
  CheckLikePostEvent({required this.id});
}

final class DeleteLikePostEvent extends PostPageEvent {
  final String id;
  DeleteLikePostEvent({required this.id});
}


final class GetLikeNumberPostEvent extends PostPageEvent {
  final String id;
  GetLikeNumberPostEvent({required this.id});
}


class AddFollowPostEvent extends PostPageEvent {
  final String id;
  AddFollowPostEvent({required this.id});
}

class DeleteFollowPostEvent extends PostPageEvent {
  final String id;
  DeleteFollowPostEvent({required this.id});
}
