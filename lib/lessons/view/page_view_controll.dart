import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../import.dart';

class PageViewControll extends StatefulWidget {
  static const String routeName = '/less';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => BlocBuilder<LessonBloc, LessonState>(
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return PageViewControll(
                  index: state.lessons[state.index].index,
                );
              },
            ));
  }

  final int index;
  const PageViewControll({super.key, required this.index});

  @override
  State<PageViewControll> createState() => _PageViewControllState();
}

class _PageViewControllState extends State<PageViewControll> {
  late final PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: widget.index - 1);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<LessonBloc, LessonState>(
        listener: (context, state) {},
        builder: (context, state) {
          final les = state.lessons[state.index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/docs.png',
                    color: primary,
                  ),
                  Text(
                    '${les.index}/${les.abc.length}',
                    style: twentyWhiteStyle,
                  ),
                  const Spacer(),
                  const CloseButton(),
                ],
              ),
              Expanded(
                child: Center(
                  child: LessonItemPageView(
                    les: les,
                    pageController: controller,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => controller.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.linear),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.06),
                      radius: 35,
                      child: const Center(
                          child: Icon(
                        Icons.navigate_before,
                        size: 50,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      if (state.lessons[state.index].index + 1 >
                          state.lessons[state.index].abc.length) {
                        MyNavMan.instance.winPush();
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.06),
                      radius: 35,
                      child: const Center(
                          child: Icon(
                        Icons.navigate_next,
                        size: 50,
                        color: Colors.white,
                      )),
                    ),
                  )
                ],
              )
            ],
          );
        },
      )),
    );
  }
}
