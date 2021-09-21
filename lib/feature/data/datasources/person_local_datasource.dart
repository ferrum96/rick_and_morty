import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>>? getPersonsFromCache();

  Future personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>>? getPersonsFromCache() {
    final List<String>? jsonPersonList = sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonList!.isNotEmpty) {
      return Future.value(jsonPersonList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      CacheException();
    }
  }

  @override
  Future personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonList);
    print('Persons to write Cache: ${jsonPersonList.length}');
    return Future.value(jsonPersonList);
  }
}
