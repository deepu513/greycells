// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) {
  return Registration()
    ..firstName = json['FirstName'] as String
    ..lastName = json['LastName'] as String
    ..mobileNumber = json['MobileNumber'] as String
    ..email = json['Email'] as String
    ..password = json['Password'] as String
    ..deviceId = json['DeviceId'] as String
    ..userType = _$enumDecodeNullable(_$UserTypeEnumMap, json['UserType']);
}

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MobileNumber': instance.mobileNumber,
      'Email': instance.email,
      'Password': instance.password,
      'DeviceId': instance.deviceId,
      'UserType': _$UserTypeEnumMap[instance.userType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumMap = {
  UserType.PATIENT: 0,
  UserType.THERAPIST: 1,
};
