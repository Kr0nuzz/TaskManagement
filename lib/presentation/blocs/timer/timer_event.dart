// timer_event.dart
part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerSetting extends TimerEvent {
  final int focusDuration;
  final int restDuration;
  final int totalSession;

  const TimerSetting({
    required this.focusDuration,
    required this.restDuration,
    required this.totalSession,
  });

  @override
  List<Object?> get props => [focusDuration, restDuration, totalSession];
}


class TimerTicked extends TimerEvent {}

class HandleButtonPress extends TimerEvent {}
class HandleResetPress extends TimerEvent {}

class SesIncrement extends TimerEvent {}
class SesDecrement extends TimerEvent {}

class FocIncrement extends TimerEvent {}
class FocDecrement extends TimerEvent {}

class RestIncrement extends TimerEvent {}
class RestDecrement extends TimerEvent {}
