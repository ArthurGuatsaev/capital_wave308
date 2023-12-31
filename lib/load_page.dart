import 'package:flutter/material.dart';

class LoadPage extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const LoadPage());
  }

  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  double loadProgress = 0;
  late final double width;
  late double pading;
  @override
  void didChangeDependencies() {
    pading = MediaQuery.of(context).size.width / 3.5;
    width = MediaQuery.of(context).size.width - pading * 2;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                Image.asset('assets/images/loading.png', fit: BoxFit.fitWidth),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 120),
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// const _loadingColor = Colors.white;
// final _loadingBackColor = Colors.white.withOpacity(0.12);
