part of 'register_cubit.dart';

@freezed
class ContactRegisterState with _$ContactRegisterState {
  factory ContactRegisterState.initial() = _Initial;
  factory ContactRegisterState.loading() = _Loading;
  factory ContactRegisterState.error({required String erro}) = _Erro;
  factory ContactRegisterState.success() = _Success;
}
