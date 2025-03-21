import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class EventPref {
  static Future<UserModel?> getUser() async {
    UserModel? user;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = UserModel.fromJson(mapUser);
    }
    return user;
  }

  static Future<void> saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user.toJson());
    print('stringUser');
    print(stringUser);
    await pref.setString('user', stringUser);
  }

  static Future<void> deleteUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('user');
  }

  // static Future<ShopModel?> getShop() async {
  //   ShopModel? shop;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? stringShop = pref.getString('shop');
  //   if (stringShop != null) {
  //     Map<String, dynamic> mapShop = jsonDecode(stringShop);
  //     shop = ShopModel.fromJson(mapShop);
  //   }
  //   return shop;
  // }

  // static Future<void> saveShop(ShopModel shop) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String stringShop = jsonEncode(shop.toJson());
  //   await pref.setString('shop', stringShop);
  // }

  // static Future<void> deleteShop() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.remove('shop');
  // }

  // static Future<BalanceModel?> getBalance() async {
  //   BalanceModel? balance;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? stringBalance = pref.getString('balance');
  //   if (stringBalance != null) {
  //     Map<String, dynamic> mapBalance = jsonDecode(stringBalance);
  //     balance = BalanceModel.fromJson(mapBalance);
  //   }
  //   return balance;
  // }

  // static Future<void> saveBalance(BalanceModel balance) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String stringBalance = jsonEncode(balance.toJson());
  //   await pref.setString('balance', stringBalance);
  // }

  // static Future<void> deleteBalance() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.remove('balance');
  // }

  // static Future<CustomerModel?> getCustomer() async {
  //   CustomerModel? customer;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? stringCustomer = pref.getString('customer');
  //   if (stringCustomer != null) {
  //     Map<String, dynamic> mapCustomer = jsonDecode(stringCustomer);
  //     customer = CustomerModel.fromJson(mapCustomer);
  //   }
  //   return customer;
  // }

  // static Future<void> saveCustomer(CustomerModel customer) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String stringCustomer = jsonEncode(customer.toJson());
  //   await pref.setString('customer', stringCustomer);
  // }

  // static Future<void> deleteCustomer() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.remove('customer');
  // }

  // static Future<RulesModel?> getRules() async {
  //   RulesModel? rules;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? stringRules = pref.getString('rules');
  //   if (stringRules != null) {
  //     Map<String, dynamic> mapRules = jsonDecode(stringRules);
  //     rules = RulesModel.fromJson(mapRules);
  //   }
  //   return rules;
  // }

  // static Future<void> saveRules(RulesModel rules) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String stringRules = jsonEncode(rules.toJson());
  //   await pref.setString('rules', stringRules);
  // }

  // static Future<void> deleteRules() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.remove('rules');
  // }

  // static Future<LicenseModel?> getLicense() async {
  //   LicenseModel? license;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? stringLicense = pref.getString('license');
  //   if (stringLicense != null) {
  //     Map<String, dynamic> mapLicense = jsonDecode(stringLicense);
  //     license = LicenseModel.fromJson(mapLicense);
  //   }
  //   return license;
  // }

  // static Future<void> saveLicense(LicenseModel license) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String stringLicense = jsonEncode(license.toJson());
  //   await pref.setString('license', stringLicense);
  // }

  // static Future<void> deleteLicense() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.remove('license');
  // }

  // static Future<ClientModel?> getClient() async {
  //   ClientModel? client;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? stringClient = pref.getString('client');
  //   if (stringClient != null) {
  //     Map<String, dynamic> mapClient = jsonDecode(stringClient);
  //     client = ClientModel.fromJson(mapClient);
  //   }
  //   return client;
  // }

  // static Future<void> saveClient(ClientModel client) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String stringUser = jsonEncode(client.toJson());
  //   await pref.setString('client', stringUser);
  // }

  // static Future<void> deleteClient() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.remove('client');
  // }
}