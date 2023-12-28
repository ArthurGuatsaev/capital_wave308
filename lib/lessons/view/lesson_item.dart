import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../import.dart';

class LessonItem extends StatelessWidget {
  final int index;
  final Lesson les;
  const LessonItem({super.key, required this.les, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context
                .read<LessonBloc>()
                .add(ChangeLessonsIndexEvent(index: index));
            MyNavMan.instance.lessonPush();
          },
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                les.image,
                width: 90,
                height: 90,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/docs.png'),
                        Text(
                          '${les.abc.length}',
                          style: thirdteenStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      les.title,
                      maxLines: 1,
                      style: fifteenWhiteStyle,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Progress',
                          style: thirdteenStyle,
                        ),
                        const Spacer(),
                        les.progress
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: les.progressValue,
                        color: primary,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
