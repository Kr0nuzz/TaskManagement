// timer_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _ticker;

  TimerBloc() : super(TimerState.initial()) {
    on<TimerSetting>(_onSetting);
    on<TimerTicked>(_onTicked);
    on<HandleButtonPress>(_onHandleButtonPress);
    on<HandleResetPress>(_onHandleResetPress);

    on<SesIncrement>(_sesIncrement);
    on<SesDecrement>((event, emit) {
      if (state.totalSession > 1) {
        emit(state.copyWith(totalSession: state.totalSession - 1));
      }
    });
    on<FocIncrement>((event, emit) {
      emit(state.copyWith(focusDuration: state.focusDuration + 5));
    });
    on<FocDecrement>((event, emit) {
      if (state.focusDuration > 1) {
        emit(state.copyWith(focusDuration: state.focusDuration - 5));
      }
    });
    on<RestIncrement>((event, emit) {
      emit(state.copyWith(restDuration: state.restDuration + 5));
    });
    on<RestDecrement>((event, emit) {
      if (state.restDuration > 1) {
        emit(state.copyWith(restDuration: state.restDuration - 5));
      }
    });
  }

  void _sesIncrement(SesIncrement event, Emitter<TimerState> emit) {
    emit(state.copyWith(totalSession: state.totalSession + 1));
  }

  void _onSetting(TimerSetting event, Emitter<TimerState> emit) {
    emit(state.copyWith(
      focusDuration: event.focusDuration,
      restDuration: event.restDuration,
      totalSession: event.totalSession,
      isFocusTime: true,
      remainingTime: event.focusDuration,
      status: TimerStatus.initial,
    ));
  }

  void _onHandleButtonPress(HandleButtonPress event, Emitter<TimerState> emit) {
    switch (state.status) {
      case TimerStatus.initial:
        _startTimer(emit);
        break;
      case TimerStatus.running:
        _pauseTimer();
        emit(state.copyWith(status: TimerStatus.paused));
        break;
      case TimerStatus.paused:
        _resumeTimer(emit);
        break;
      case TimerStatus.completed:
        break;
    }
  }

  void _onHandleResetPress(HandleResetPress event, Emitter<TimerState> emit) {
    if (_ticker != null) {
      _ticker?.cancel();
      emit(TimerState.initial());
    }
  }

  void _startTimer(Emitter<TimerState> emit) {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      add(TimerTicked());
    });
    emit(state.copyWith(status: TimerStatus.running, isFocusTime: true, remainingTime: state.focusDuration *60));
  }

  void _pauseTimer() {
    _ticker?.cancel();
  }

  void _resumeTimer(Emitter<TimerState> emit) {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      add(TimerTicked());
    });
    emit(state.copyWith(status: TimerStatus.running));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    print(state.remainingTime);
    if (state.remainingTime > 0) {
      emit(state.copyWith(remainingTime: state.remainingTime - 1));
      return;
    }
    if (state.isFocusTime == true) {
      // switch to rest
      emit(state.copyWith(
        isFocusTime: false,
        remainingTime: state.restDuration * 60,
      ));
      return;
    }

    final nextSession = state.totalSession - 1;

    // selesai satu sesi
    if (nextSession > 0) {
      emit(state.copyWith(
        totalSession: nextSession,
        isFocusTime: true,
        remainingTime: state.focusDuration * 60,
      ));
      return;
    }

    _ticker?.cancel();
    emit(state.copyWith(status: TimerStatus.completed));
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
