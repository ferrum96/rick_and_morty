import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    List<String>? jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList != null) {
      print('Кол-во персонажей полученных из кэша: ${jsonPersonsList.length}');
      jsonPersonsList.map((person) => print(person));
      print('Персонажи из кэша: ${jsonPersonsList.toList()}');
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    print('Кол-во персонажей записанных в кэш: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
