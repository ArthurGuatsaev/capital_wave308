import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../import.dart';
part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonsRepo repository;
  LessonBloc({required this.repository}) : super(const LessonState()) {
    on<GetLessonsEvent>(getLessons);
    on<ChangeLessonsIndexEvent>(changeIndex);
    on<ChangeStudiedLessonsEvent>(changeStudied);
    on<UpdateLessonsEvent>(updateLessons);
    on<ResetLessonEvent>(resetLesson);
  }
  getLessons(GetLessonsEvent event, Emitter<LessonState> emit) {
    final lesson = repository.lessons;
    emit(state.copyWith(lessons: lesson));
  }

  updateLessons(UpdateLessonsEvent event, Emitter<LessonState> emit) async {
    await repository.getLessons();
    final lesson = repository.lessons;
    emit(state.copyWith(lessons: lesson));
  }

  changeIndex(ChangeLessonsIndexEvent event, Emitter<LessonState> emit) {
    emit(state.copyWith(index: event.index));
  }

  resetLesson(ResetLessonEvent event, Emitter<LessonState> emit) async {
    await repository.resetLesson();
    add(UpdateLessonsEvent());
  }

  // изменяет индекс прогресса урока, а также текущие открытые позиции уроков
  changeStudied(
      ChangeStudiedLessonsEvent event, Emitter<LessonState> emit) async {
    if (event.number > state.lessons[state.index].studied) {
      await repository.changeStudied(
          number: event.number, id: state.lessons[state.index].id);
      final lessons = [...state.lessons];
      final les = lessons
          .map((e) => e.id == state.lessons[state.index].id
              ? e.copyWith(studied: event.number, index: event.number)
              : e)
          .toList();
      emit(
        state.copyWith(lessons: les),
      );
    } else {
      final lessons = [...state.lessons];
      final les = lessons
          .map((e) => e.id == state.lessons[state.index].id
              ? e.copyWith(index: event.number)
              : e)
          .toList();
      emit(
        state.copyWith(lessons: les),
      );
    }
  }
}
