import 'dart:convert';

Account accountFromMap(String str) => Account.fromMap(json.decode(str));

String accountToMap(Account data) => json.encode(data.toMap());

class Account {
    Account({
        this.id,
        this.name,
        this.username,
        this.email,
        this.phoneNumber,
        this.balance,
        this.contactPerson,
        this.accessToken,
        this.consultation,
        this.consultationPrice,
        this.consultationCp,
        this.liveTrading,
        this.liveTradingPrice,
        this.liveTradingCp,
    });

    int id;
    String name;
    String username;
    dynamic email;
    String phoneNumber;
    String balance;
    String contactPerson;
    String accessToken;
    bool consultation;
    int consultationPrice;
    String consultationCp;
    bool liveTrading;
    int liveTradingPrice;
    String liveTradingCp;

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        balance: json["balance"],
        contactPerson: json["contact_person"],
        accessToken: json["access_token"],
        consultation: json["consultation"],
        consultationPrice: json["consultation_price"],
        consultationCp: json["consultation_cp"],
        liveTrading: json["live_trading"],
        liveTradingPrice: json["live_trading_price"],
        liveTradingCp: json["live_trading_cp"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "balance": balance,
        "contact_person": contactPerson,
        "access_token": accessToken,
        "consultation": consultation,
        "consultation_price": consultationPrice,
        "consultation_cp": consultationCp,
        "live_trading": liveTrading,
        "live_trading_price": liveTradingPrice,
        "live_trading_cp": liveTradingCp,
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