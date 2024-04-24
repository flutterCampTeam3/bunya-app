part of 'support_bloc.dart';

@immutable
sealed class SupportEvent {}


class SendMassageEvent extends SupportEvent {
  final String massage;

  

  SendMassageEvent({
    required this.massage,

    
  });
}
