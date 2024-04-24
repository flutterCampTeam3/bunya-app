part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class SuccessState extends ChatState {}

final class ErrorState extends ChatState {
  final String massage;
  ErrorState({required this.massage});
}

