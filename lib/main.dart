import 'dart:async';
import 'package:capital_wave/nfts/domain/model/topnft_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../import.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
      [VNotesIssarSchema, NFTModelSchema, TopNFTModelSchema],
      directory: appDir.path);
  final StreamController<String> errorController = StreamController();
  final error = ErrorBloc(errorController: errorController);
  final NoteRepository noteRepository =
      NoteRepository(errorController: errorController, isar: isar);
  final LessonsRepo lessonRepository =
      LessonsRepo(errorController: errorController);
  final NFTRepository nftRepository =
      NFTRepository(errorController: errorController, isar: isar);
  final TopNFTRepository topNftRepository =
      TopNFTRepository(errorController: errorController, isar: isar);
  final VServices services = VServices();
  final MyCheckRepo checkRepo = MyCheckRepo(errorController: errorController);
  final LoadingRepo onbordRepo = LoadingRepo(errorController: errorController);
  final FirebaseRemote firebaseRemote =
      FirebaseRemote(errorController: errorController);
  final navi = MyNavigatorManager.instance;
  final load = LoadBloc(
    servicesRepo: services,
    noteRepository: noteRepository,
    loadingRepo: onbordRepo,
    checkRepo: checkRepo,
    nftRepository: nftRepository,
    firebaseRemote: firebaseRemote,
    topNftRepository: topNftRepository,
    lessonRepository: lessonRepository,
  )
    ..add(NoteRepoInitEvent())
    ..add(NFTRepoInitEvent())
    ..add(LessonRepoInitEvent())
    ..add(TopNFTRepoInitEvent())
    ..add(FirebaseRemoteInitEvent());
  runApp(
    MyApp(
      navi: navi,
      lessonRepository: lessonRepository,
      load: load,
      topNftRepository: topNftRepository,
      nftRepository: nftRepository,
      noteRepository: noteRepository,
      checkRepo: checkRepo,
      firebaseRemote: firebaseRemote,
      onbordRepo: onbordRepo,
      error: error,
    ),
  );
}

class MyApp extends StatelessWidget {
  final MyCheckRepo checkRepo;
  final LoadingRepo onbordRepo;
  final FirebaseRemote firebaseRemote;
  final MyNavigatorManager navi;
  final NFTRepository nftRepository;
  final TopNFTRepository topNftRepository;
  final NoteRepository noteRepository;
  final LoadBloc load;
  final LessonsRepo lessonRepository;
  final ErrorBloc error;
  const MyApp({
    super.key,
    required this.navi,
    required this.topNftRepository,
    required this.load,
    required this.lessonRepository,
    required this.nftRepository,
    required this.noteRepository,
    required this.error,
    required this.checkRepo,
    required this.onbordRepo,
    required this.firebaseRemote,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => checkRepo,
        ),
        RepositoryProvider(
          create: (context) => onbordRepo,
        ),
        RepositoryProvider(
          create: (context) => firebaseRemote,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoadBloc>(
            create: (context) => load,
          ),
          BlocProvider<ErrorBloc>(
            create: (context) => error,
          ),
          BlocProvider<NoteBloc>(
            create: (context) =>
                NoteBloc(noteRepo: noteRepository)..add(GetNotesEvent()),
          ),
          BlocProvider<NftBloc>(
            lazy: false,
            create: (context) => NftBloc(nftRepository: nftRepository),
          ),
          BlocProvider<TopNftBloc>(
            lazy: false,
            create: (context) => TopNftBloc(nftRepository: topNftRepository),
          ),
          BlocProvider<LessonBloc>(
            create: (context) => LessonBloc(repository: lessonRepository),
          ),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navi.key,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: backgroundColor, elevation: 0),
            scaffoldBackgroundColor: backgroundColor,
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
              bodySmall: TextStyle(fontSize: 10),
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              labelSmall: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              displaySmall: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
              labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          onGenerateRoute: navi.onGenerateRoute,
          initialRoute: SplashPage.routeName,
        ),
      ),
    );
  }
}
