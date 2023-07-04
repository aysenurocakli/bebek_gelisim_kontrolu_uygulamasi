class DoktorUser {
  final String? isim;
  final String? soyisim;
  final String? email;
  final String? sifre;
  final String? id;

  DoktorUser({
    required this.isim,
    required this.soyisim,
    required this.email,
    required this.sifre,
    required this.id,
  });

  factory DoktorUser.fromJson(Map<String, dynamic> json) {
    return DoktorUser(
      isim: json['isim'] as String,
      soyisim: json['soyisim'] as String,
      email: json['mail'] as String,
      sifre: json['sifre'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isim': isim,
      'soyisim': soyisim,
      'mail': email,
      'sifre': sifre,
      'id': id,
    };
  }
}
