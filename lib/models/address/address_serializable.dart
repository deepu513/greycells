import 'package:greycells/models/address/address.dart';
import 'package:greycells/networking/serializable.dart';

class AddressSerializable implements Serializable<Address> {
  @override
  Address fromJson(Map<String, dynamic> json) {
    return Address.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Address address) {
    return address.toJson();
  }

  @override
  List<Address> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((addressMap) =>
    addressMap == null ? null : fromJson(addressMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Address> addressList) {
    return addressList?.map((address) => address?.toJson())?.toList();
  }
}