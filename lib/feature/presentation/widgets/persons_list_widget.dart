import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonsList extends StatelessWidget {
  List<PersonEntity>? persons;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        }
        return ListView.separated(
          itemBuilder: (context, index) => Text('$persons'),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[400],
          ),
          itemCount: persons!.length,
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
