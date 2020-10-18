import 'dart:convert';

import 'package:trikcuan_app/core/model/topup_model.dart';

Account accountFromMap(String str) => Account.fromMap(json.decode(str));

String accountToMap(Account data) => json.encode(data.toMap());

class Account {
    Account({
        this.id,
        this.roleId,
        this.name,
        this.username,
        this.email,
        this.phoneNumber,
        this.balance,
        this.balanceTopup,
        this.contactPerson,
        this.accessToken,
        this.consultation,
        this.consultationPrice,
        this.consultationCp,
        this.liveTrading,
        this.liveTradingPrice,
        this.liveTradingCp,
        this.catatanIndex,
        this.catatanKomoditas
    });

    int id;
    String roleId;
    String name;
    String username;
    String email;
    String phoneNumber;
    String balance;
    List<TopupModel> balanceTopup;
    String contactPerson;
    String accessToken;
    bool consultation;
    int consultationPrice;
    String consultationCp;
    bool liveTrading;
    int liveTradingPrice;
    String liveTradingCp;
    String catatanIndex;
    String catatanKomoditas;

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        roleId: json["role_id"]?.toString(),
        name: json["name"]?.toString(),
        username: json["username"]?.toString(),
        email: json["email"]?.toString(),
        phoneNumber: json["phone_number"]?.toString(),
        balance: json["balance"]?.toString(),
        balanceTopup: json["balance_topup"] != null ? List<TopupModel>.from(json["balance_topup"].map((x) => TopupModel.fromMap(x))) : [],
        contactPerson: json["contact_person"]?.toString(),
        accessToken: json["access_token"]?.toString(),
        consultation: json["consultation"],
        consultationPrice: json["consultation_price"],
        consultationCp: json["consultation_cp"]?.toString(),
        liveTrading: json["live_trading"],
        liveTradingPrice: json["live_trading_price"],
        liveTradingCp: json["live_trading_cp"]?.toString(),
        catatanIndex: json["catatan_index"]?.toString(),
        catatanKomoditas: json["catatan_komoditas"]?.toString(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "role_id": roleId,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "balance": balance,
        "balance_topup": List<dynamic>.from(balanceTopup.map((x) => x.toMap())),
        "contact_person": contactPerson,
        "access_token": accessToken,
        "consultation": consultation,
        "consultation_price": consultationPrice,
        "consultation_cp": consultationCp,
        "live_trading": liveTrading,
        "live_trading_price": liveTradingPrice,
        "live_trading_cp": liveTradingCp,
        "catatan_index": catatanIndex,
        "catatan_komoditas": catatanKomoditas,
    };
}

class RegisterAccount {
    RegisterAccount({
        this.name,
        this.username,
        this.email,
        this.phoneNumber,
        this.password,
    });

    String name;
    String username;
    String email;
    String phoneNumber;
    String password;
    
    Map<String, dynamic> toMap() => {
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "password": password
    };
}