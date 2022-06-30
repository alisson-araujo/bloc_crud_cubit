part of 'update_cubit.dart';

@freezed
class ContactUpdateState with _$ContactUpdateState {
  factory ContactUpdateState.initial() = _Initial;
  factory ContactUpdateState.loading() = _Loading;
  factory ContactUpdateState.error({required String erro}) = _Error;
  factory ContactUpdateState.success() = _Success;
}
