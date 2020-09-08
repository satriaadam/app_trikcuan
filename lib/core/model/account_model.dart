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
        this.city,
        this.balance,
        this.accessToken,
        this.contactPerson,
    });

    int id;
    String name;
    String username;
    String email;
    String phoneNumber;
    String city;
    String balance;
    String accessToken;
    String contactPerson;

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"] ?? "",
        phoneNumber: json["phone_number"],
        city: json["city"],
        balance: json["balance"],
        accessToken: json["access_token"] ?? "",
        contactPerson: json["contact_person"] ?? "",
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "city": city,
        "balance": balance,
        "access_token": accessToken,
        "contact_person": contactPerson,
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