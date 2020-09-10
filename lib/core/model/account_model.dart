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
        this.consultationPrice,
        this.contactPerson,
        this.accessToken,
        this.consultation,
    });

    int id;
    String name;
    String username;
    dynamic email;
    String phoneNumber;
    String balance;
    int consultationPrice;
    String contactPerson;
    String accessToken;
    bool consultation;

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        balance: json["balance"],
        consultationPrice: json["consultation_price"],
        contactPerson: json["contact_person"],
        accessToken: json["access_token"],
        consultation: json["consultation"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "balance": balance,
        "consultation_price": consultationPrice,
        "contact_person": contactPerson,
        "access_token": accessToken,
        "consultation": consultation,
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