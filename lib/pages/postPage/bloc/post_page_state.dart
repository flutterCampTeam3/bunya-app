part of 'post_page_bloc.dart';

@immutable
sealed class PostPageState {}

final class PostPageInitial extends PostPageState {}

class PostsSuccesState extends PostPageState {
  // final List<postModel> classPostId;
  // PostsSuccesState({required this.classPostId});
}

final class LoadingPostState extends PostPageState {}

final class CheckPostFollow extends PostPageState {}

final class ErrorPostShowpostState extends PostPageState {
  final String msg;

  ErrorPostShowpostState({required this.msg});
}

final class LaudLikePostState extends PostPageState {}

final class AddLikePostState extends PostPageState {}

final class DeleteLikePostState extends PostPageState {}

final class CheckLikePostState extends PostPageState {}

 final class AddFollowPostState extends PostPageState {
  final String msg;
  AddFollowPostState({required this.msg});
 }

 final class DeleteFollowPostState extends PostPageState {
  final String msg;
  DeleteFollowPostState({required this.msg});
 }
