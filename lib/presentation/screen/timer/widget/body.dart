// body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_Management/core/services/local_notification_services.dart';
import 'package:task_Management/presentation/widget/snackbar.dart';
import 'package:task_Management/core/utils/ukuran_layar.dart';
import '../../../blocs/timer/timer_bloc.dart';

class BodyTimer extends StatelessWidget {
  BodyTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String timeDisplay =
            _formatDuration(Duration(seconds: state.remainingTime));

        String buttonText;
        switch (state.status) {
          case TimerStatus.initial:
            buttonText = 'Start Timer';
            break;
          case TimerStatus.running:
            buttonText = 'Pause Timer';
            break;
          case TimerStatus.paused:
            buttonText = 'Resume Timer';
            break;
          case TimerStatus.completed:
            buttonText = 'Session Completed';
            break;
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: MultiBlocListener(
            listeners: [
              BlocListener<TimerBloc, TimerState>(
                  listenWhen: (pref, curr) =>
                      pref.isFocusTime == false &&
                      curr.isFocusTime == true &&
                      curr.status == TimerStatus.running,
                  listener: (context, state) {
                    LocalNotificationServices.show(title: "Focus Time",body: "Sesi Focus Dimulai");
                  }),
              BlocListener<TimerBloc, TimerState>(
                  listenWhen: (pref, curr) =>
                      pref.isFocusTime == true &&
                      curr.isFocusTime == false,
                  listener: (context, state) {
                    LocalNotificationServices.show(title: "Rest Time",body: "Waktunya Istirahat Sejenak");
                  }),
              BlocListener<TimerBloc, TimerState>(
                  listenWhen: (pref, curr) =>
                      pref.status != curr.status &&
                      curr.status == TimerStatus.completed,
                  listener: (context, state) {
                    LocalNotificationServices.show(title: "Completed",body: "Sesi Sudah Selesai");
                  })
            ],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$timeDisplay', style: const TextStyle(fontSize: 70)),
                const SizedBox(height: 20),
                _buildNumberInput(
                    context,
                    'Focus Time (min)',
                    state.focusDuration,
                    () => context.read<TimerBloc>().add(FocIncrement()),
                    () => context.read<TimerBloc>().add(FocDecrement())),
                _buildNumberInput(
                    context,
                    'Rest Time (min)',
                    state.restDuration,
                    () => context.read<TimerBloc>().add(RestIncrement()),
                    () => context.read<TimerBloc>().add(RestDecrement())),
                _buildNumberInput(
                    context,
                    'Sessions',
                    state.totalSession,
                    () => context.read<TimerBloc>().add(SesIncrement()),
                    () => context.read<TimerBloc>().add(SesDecrement())),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: state.status == TimerStatus.completed
                      ? null
                      : () {
                          if (state.focusDuration <= 0 ||
                              state.restDuration <= 0) {
                            AppSnackBar.show(context,
                                title: "Error",
                                message: "Please fill all values first",
                                type: SnackType.error);
                            return;
                          }
                          context.read<TimerBloc>().add(HandleButtonPress());
                        },
                  child: Text(buttonText),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(HandleResetPress());
                    },
                    child: Text("Reset Timer"))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNumberInput(BuildContext context, String label, int value,
      VoidCallback onAdd, VoidCallback onremove) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
          child: Center(
        child: Text(
          label,
          style: TextStyle(fontSize: screenSize(context).height * 0.02),
        ),
      )),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: onremove,
                icon: Icon(
                  Icons.remove,
                  size: MediaQuery.sizeOf(context).height * 0.03,
                )),
            const SizedBox(
              width: 11,
            ),
            Text(
              "$value",
              style:
                  TextStyle(fontSize: MediaQuery.sizeOf(context).height * 0.03),
            ),
            const SizedBox(
              width: 7,
            ),
            IconButton(
                onPressed: onAdd,
                icon: Icon(
                  Icons.add,
                  size: MediaQuery.sizeOf(context).height * 0.03,
                ))
          ],
        ),
      )
    ]);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
