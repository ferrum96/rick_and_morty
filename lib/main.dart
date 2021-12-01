import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/locator_service.dart' as di;

import 'feature/presentation/pages/person_screen.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  //final client = http.Client();
  //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //List<PersonModel> persons = await PersonRemoteDataSourceImpl(client: client).getAllPersons(2);
  //Future<List<PersonModel>> searchPerson = PersonRemoteDataSourceImpl(client: http.Client()).searchPerson('Morty');

  //PersonLocalDataSourceImpl(sharedPreferences: sharedPreferences).personsToCache(persons);
  //List<PersonModel> personsFromCache = await PersonLocalDataSourceImpl(sharedPreferences: sharedPreferences).getLastPersonsFromCache();

  //print(searchPerson.toList());
  //print(personsFromCache.toList());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
          create: (context) => sl<PersonListCubit>()..loadPerson(),
        ),
        BlocProvider<PersonSearchBloc>(
          create: (context) => sl<PersonSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: HomePage(),
      ),
    );
  }
}
