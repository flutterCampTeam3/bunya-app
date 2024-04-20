part of 'post_page_bloc.dart';

@immutable
sealed class PostPageState {}

final class PostPageInitial extends PostPageState {}

class PostsSuccesState extends PostPageState {
  final List<postModel> classPostId;
  PostsSuccesState({required this.classPostId});
}

final class LoadingPostState extends PostPageState {}

final class CheckPostFollow extends PostPageState {}

final class ErrorPostShowpostState extends PostPageState {
  final String msg;

  ErrorPostShowpostState({required this.msg});
}
