part of 'contacts_cubit.dart';

@freezed
class ContactsCubitState with _$ContactsCubitState {
  factory ContactsCubitState.initial() = _Initial;
  factory ContactsCubitState.loading() = _Loading;
  factory ContactsCubitState.data({required List<ContactModel> contacts}) =
      _Data;
  factory ContactsCubitState.error({required String error}) = _Error;
}
