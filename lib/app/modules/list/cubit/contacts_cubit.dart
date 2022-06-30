import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crud_bloc_vls/app/models/contact_model.dart';
import 'package:crud_bloc_vls/repositories/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_state.dart';
part 'contacts_cubit.freezed.dart';

class ContactsCubit extends Cubit<ContactsCubitState> {
  final ContactsRepository _repository;

  ContactsCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactsCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(ContactsCubitState.loading());
      final contacts = await _repository.findAll();
      emit(ContactsCubitState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao carregar contatos', error: e, stackTrace: s);
      emit(ContactsCubitState.error(error: 'Erro ao carregar contatos'));
    }
  }

  Future<void> delete(ContactModel model) async {
    try {
      emit(ContactsCubitState.loading());
      await _repository.delete(model);
      findAll();
    } catch (e, s) {
      log('Erro ao deletar contato', error: e, stackTrace: s);
      emit(ContactsCubitState.error(error: 'Erro ao deletar contato'));
    }
  }
}
