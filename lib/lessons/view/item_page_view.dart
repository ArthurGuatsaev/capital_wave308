import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../import.dart';

class LessonItemPageView extends StatefulWidget {
  final PageController pageController;
  final Lesson les;
  const LessonItemPageView(
      {super.key, required this.pageController, required this.les});

  @override
  State<LessonItemPageView> createState() => _LessonItemPageViewState();
}

class _LessonItemPageViewState extends State<LessonItemPageView> {
  @override
  void initState() {
    widget.pageController.addListener(() {
      context.read<LessonBloc>().add(ChangeStudiedLessonsEvent(
          number: widget.pageController.page!.toInt() + 1));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: widget.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          widget.les.abc.length,
          (index) => Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(1.7),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: bgSecondColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: bgSecondColor,
                  ),
                  child: Center(
                    child: BlocBuilder<LessonBloc, LessonState>(
                      builder: (context, state) {
                        return Text(
                          widget.les.abc[index],
                          style: fifteenWhiteStyle,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
