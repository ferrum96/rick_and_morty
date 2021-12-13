import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<PersonModel>> getPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  List<String> cashedPersonsList = <String>[];

  PersonLocalDataSourceImpl();

  @override
  Future<List<PersonModel>> getPersonsFromCache() async {
    await Hive.openBox<String>('persons');
    final Box<String> box = Hive.box<String>('persons');
    cashedPersonsList = box.values.toList();

    try {
      print(
          'Кол-во персонажей полученных из кэша: ${cashedPersonsList.length}');
      cashedPersonsList.map((person) => print(person));
      return Future.value(cashedPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final Box<String> box = await Hive.openBox<String>('persons');
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    jsonPersonsList.forEach((person) {
      if (!box.values.contains(person)) {
        box.add(person);
      }
    });

    print('Кол-во персонажей записанных в кэш: ${box.values.length}');
    return Future.value(jsonPersonsList);
  }
}
