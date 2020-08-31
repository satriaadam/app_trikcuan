import 'dart:convert';

Account accountFromMap(String str) => Account.fromMap(json.decode(str));

String accountToMap(Account data) => json.encode(data.toMap());

class Account {
    Account({
        this.id,
        this.name,
        this.username,
        this.phoneNumber,
        this.city,
        this.balance,
        this.accessToken,
        this.tokenType,
        this.expiresIn,
    });

    int id;
    String name;
    String username;
    String phoneNumber;
    String city;
    String balance;
    String accessToken;
    String tokenType;
    int expiresIn;

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        city: json["city"],
        balance: json["balance"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "phone_number": phoneNumber,
        "city": city,
        "balance": balance,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
    };
}
