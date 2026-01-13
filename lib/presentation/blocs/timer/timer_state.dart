// timer_state.dart
part of 'timer_bloc.dart';

enum TimerStatus { initial, running, paused, completed }

class TimerState extends Equatable {
  final int focusDuration;
  final int restDuration;
  final int totalSession;
  final bool isFocusTime;
  final int remainingTime;
  final TimerStatus status;

  const TimerState({
    required this.focusDuration,
    required this.restDuration,
    required this.totalSession,
    required this.isFocusTime,
    required this.remainingTime,
    required this.status,
  });

  factory TimerState.initial(){
    return const TimerState(
      focusDuration: 0,
      restDuration: 0,
      totalSession: 0,
      isFocusTime: true,
      remainingTime: 0,
      status: TimerStatus.initial,
      
    );
  }

  TimerState copyWith({
    int? focusDuration,
    int? restDuration,
    int? totalSession,
    bool? isFocusTime,
    int? remainingTime,
    TimerStatus? status,
  }) {
    return TimerState(
      focusDuration: focusDuration ?? this.focusDuration,
      restDuration: restDuration ?? this.restDuration,
      totalSession: totalSession ?? this.totalSession,
      isFocusTime: isFocusTime ?? this.isFocusTime,
      remainingTime: remainingTime ?? this.remainingTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        focusDuration,
        restDuration,
        totalSession,
        isFocusTime,
        remainingTime,
        status,
      ];
}
