import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crud_bloc_vls/app/models/contact_model.dart';
import 'package:crud_bloc_vls/repositories/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterState> {
  final ContactsRepository _contactsRepository;
  ContactRegisterCubit({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(ContactRegisterState.initial());

  Future<void> register(ContactModel model) async {
    try {
      emit(ContactRegisterState.loading());
      await _contactsRepository.create(model);
      emit(ContactRegisterState.success());
    } catch (e, s) {
      log('Erro ao cadastrar contato', error: e, stackTrace: s);
      emit(ContactRegisterState.error(erro: 'Erro ao cadastrar contato'));
    }
  }
}
