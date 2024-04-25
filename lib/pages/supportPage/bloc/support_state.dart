part of 'support_bloc.dart';

@immutable
sealed class SupportState {}

final class SupportInitial extends SupportState {}

final class SuccessSendState extends SupportState {
  final String msg;

  SuccessSendState({required this.msg});
}

final class ErrorSendState extends SupportState {
  final String msg;

  ErrorSendState({required this.msg});
}
final class LoadingSendState extends SupportState {



}

