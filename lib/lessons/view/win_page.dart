import 'package:flutter_bloc/flutter_bloc.dart';

import '../import.dart';
import 'package:flutter/material.dart';

class WinPage extends StatelessWidget {
  static const String routeName = '/win';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const WinPage());
  }

  const WinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: Align(alignment: Alignment.topRight, child: CloseButton()),
            ),
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/win.png'),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                    child: Text(
                  'Lesson successfully completed',
                  textAlign: TextAlign.center,
                  style: thirtyFourStyte,
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Great! Lesson completed! Keep up the good work',
                  textAlign: TextAlign.center,
                  style: fifteenStyle,
                )),
              ],
            ),
            const Spacer(),
            BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                return CalcButton(
                  text: 'Next Lesson',
                  function: () {
                    if (state.index == state.lessons.length - 1) {
                      context
                          .read<LessonBloc>()
                          .add(const ChangeLessonsIndexEvent(index: 0));
                      MyNavMan.instance.nextLessonPush();
                    } else {
                      context
                          .read<LessonBloc>()
                          .add(ChangeLessonsIndexEvent(index: state.index + 1));
                      MyNavMan.instance.nextLessonPush();
                    }
                  },
                  gradic: gradientButton,
                );
              },
            ),
            const SizedBox(height: 10),
            CalcButton(
              text: 'To main',
              function: () => MyNavMan.instance.simulatorPop(),
              gradic: gradientButtonOff,
            ),
          ]),
        ),
      ),
    );
  }
}
