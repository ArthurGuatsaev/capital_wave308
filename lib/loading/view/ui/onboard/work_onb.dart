import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../../import.dart';

class VWorkOnb extends StatefulWidget {
  final String tg;
  static const String routeName = '/work';

  get finArt => null;
  static Route route(String tg) {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return VWorkOnb(tg: tg);
        });
  }

  const VWorkOnb({super.key, required this.tg});

  @override
  State<VWorkOnb> createState() => _VWorkOnbState();
}

class _VWorkOnbState extends State<VWorkOnb> {
  final InAppReview inAppReview = InAppReview.instance;

  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadBloc, LoadState>(
      listenWhen: (previous, current) =>
          previous.onboardIndex != current.onboardIndex,
      listener: (context, state) {
        if (state.onboardIndex == 0) {
          controller.animateToPage(0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 1) {
          controller.animateToPage(1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
          inAppReview.requestReview();
        }
        if (state.onboardIndex == 2) {
          controller.animateToPage(2,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 3) {
          controller.animateToPage(3,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
      },
      child: PageView(
        padEnds: false,
        pageSnapping: false,
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          VBaseBoard(
            entity: 2,
            boardParam: VBoardParam(
              image: 'assets/images/work_1.png',
              title: 'Open the market',
              body: 'Become a professional in the world of trading',
              tg: '',
              buttonText: 'Continue',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 1),
                  ),
            ),
          ),
          VBaseBoard(
            entity: 2,
            boardParam: VBoardParam(
              image: 'assets/images/work_2.png',
              title: 'Your feedback is very important',
              body: 'Rate us in the AppStore',
              buttonText: 'Continue',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 2),
                  ),
            ),
          ),
          VBoardTelega(
            boardParam: VBoardParam(
              image: 'assets/images/telega.png',
              title: 'Join our Telegram Channel',
              body: 'And trade with our team',
              buttonText: 'Skip',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 3),
                  ),
            ),
          ),
          const VBoardPush(
            image: 'assets/images/push.png',
            title: "Don't miss anything",
            body: "Don't miss the most userful information",
            buttonText: 'Skip',
          ),
        ],
      ),
    );
  }
}
