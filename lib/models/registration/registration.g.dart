// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['DeviceId', 'UserType']);
  return Registration()
    ..firstName = json['FirstName'] as String
    ..lastName = json['LastName'] as String
    ..mobileNumber = json['MobileNumber'] as String
    ..email = json['Email'] as String
    ..password = json['Password'] as String
    ..deviceId = json['DeviceId'] as String
    ..userType = _$enumDecodeNullable(_$UserTypeEnumMap, json['UserType']);
}

Map<String, dynamic> _$RegistrationToJson(Registration instance) {
  final val = <String, dynamic>{
    'FirstName': instance.firstName,
    'LastName': instance.lastName,
    'MobileNumber': instance.mobileNumber,
    'Email': instance.email,
    'Password': instance.password,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DeviceId', instance.deviceId);
  writeNotNull('UserType', _$UserTypeEnumMap[instance.userType]);
  return val;
}

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
  UserType.patient: 0,
  UserType.therapist: 1,
};
