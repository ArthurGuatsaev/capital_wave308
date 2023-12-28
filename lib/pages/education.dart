import 'package:flutter_bloc/flutter_bloc.dart';

import '../import.dart';
import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  @override
  void initState() {
    context.read<LessonBloc>().add(GetLessonsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 55),
            const Text(
              'Education',
              style: thirtyFourStyte,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<LessonBloc, LessonState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: state.lessons.length,
                      itemBuilder: (context, index) {
                        final lesson = state.lessons[index];
                        return LessonItem(
                          les: lesson,
                          index: index,
                        );
                      });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
