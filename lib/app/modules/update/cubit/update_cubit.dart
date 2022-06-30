import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crud_bloc_vls/app/models/contact_model.dart';
import 'package:crud_bloc_vls/repositories/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_state.dart';

part 'update_cubit.freezed.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateState> {
  final ContactsRepository _contactsRepository;
  ContactUpdateCubit({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(ContactUpdateState.initial());

  Future<void> update(ContactModel model) async {
    try {
      emit(ContactUpdateState.loading());
      await _contactsRepository.update(model);
      emit(ContactUpdateState.success());
    } catch (e, s) {
      log('Erro ao atualizar contato', error: e, stackTrace: s);
      emit(ContactUpdateState.error(erro: 'Erro ao atualizar contato'));
    }
  }
}
