import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';


class Bebek {

  final String? bebek_id;
  final String? foto;
  final String? parent_id;
  final String? anne_mail;
  final String? ad_soyad;
  final String? tc_kimlik;
  final String? dogustan_gelen_hastalik;
  final String? cinsiyet;
  final String? dogum_sekli;
  final String? dogum_tarihi;
  final String? dogum_yeri;
  final String? gebelikte_sorun_oldu_mu;
  final String? kronik_hastalik_var_mi;
  final String? annenin_kacinci_dogumu;
  final String? yapilan_asilar;
  final String? topuk_kani_problem;
  final String? kalca_cikigi_taramasi_yapildi_mi;
  final String? duyma_testi_yapildi_mi;
  final String? dogumdaki_bas_cevresi;
  final String? dogumdaki_boy;
  final String? dogumdaki_kilo;
  final Map<String, double> persentil;



  Bebek({
    this.bebek_id,
    this.foto,
    this.parent_id,
    this.anne_mail,
    this.ad_soyad,
    this.tc_kimlik,
    this.dogustan_gelen_hastalik,
    this.cinsiyet,
    this.dogum_sekli,
    this.dogum_tarihi,
    this.dogum_yeri,
    this.gebelikte_sorun_oldu_mu,
    this.kronik_hastalik_var_mi,
    this.annenin_kacinci_dogumu,
    this.yapilan_asilar,
    this.topuk_kani_problem,
    this.kalca_cikigi_taramasi_yapildi_mi,
    this.duyma_testi_yapildi_mi,
    this.dogumdaki_bas_cevresi,
    this.dogumdaki_boy,
    this.dogumdaki_kilo,
    this.persentil = const {},

  });

  Map<String, dynamic> toJsonPersentil() {
    return persentil.map((key, value) => MapEntry(key, value.toDouble()));
  }

  Map<String, double> fromJsonPersentil(Map<String, dynamic> json) {
    return json.map((key, value) => MapEntry(key, value.toDouble()));
  }


  factory Bebek.fromJson(Map<String, dynamic> data) {
    return Bebek(
      bebek_id: data['bebek_id']?? "",
      foto: data['foto']?? "",
      dogum_tarihi: data['dogum_tarihi']?? "",
      parent_id: data['parent_id'] ?? "",
      anne_mail: data['anne_mail']?? "",
      ad_soyad: data['ad_soyad']?? "",
      tc_kimlik: data['tc']?? "",
      dogustan_gelen_hastalik: data['dogustan_gelen_hastalik']?? "",
      cinsiyet: data['cinsiyet']?? "",
      dogum_sekli: data['dogum_sekli']?? "",
      dogum_yeri: data['dogum_yeri']?? "",
      gebelikte_sorun_oldu_mu: data['gebelikte_sorun_oldu_mu']?? "",
      kronik_hastalik_var_mi: data['kronik_hastalik_var_mi']?? "",
      annenin_kacinci_dogumu: data['annenin_kacinci_dogumu']?? "",
      yapilan_asilar: data['yapilan_asilar']??  "",
      topuk_kani_problem: data['topuk_kani_problem']?? "",
      kalca_cikigi_taramasi_yapildi_mi: data['kalca_cikigi_taramasi_yapildi_mi']?? "",
      duyma_testi_yapildi_mi: data['duyma_testi_yapildi_mi']?? "",
      dogumdaki_bas_cevresi: data['dogumdaki_bas_cevresi'],
      dogumdaki_boy: data['dogumdaki_boy'],
      dogumdaki_kilo: data['dogumdaki_kilo'],
      persentil: Bebek().fromJsonPersentil(data['persentil'] ?? {}),

    );
  }
  Map<String, dynamic> toJson(){
    return {
      "foto": foto??"",
      if (anne_mail != null) "anne_mail": anne_mail,
      if (ad_soyad != null) "ad_soyad": ad_soyad,
      if (tc_kimlik != null) "tc": tc_kimlik,
      if (dogum_tarihi != null) "dogum_tarihi": dogum_tarihi,
      if (dogustan_gelen_hastalik != null) "dogustan_gelen_hastalik": dogustan_gelen_hastalik,
      if (cinsiyet != null) "cinsiyet": cinsiyet ,
      if (dogum_sekli != null) "dogum_sekli": dogum_sekli ,
      if ( dogum_yeri != null) "dogum_yeri": dogum_yeri,
      if ( gebelikte_sorun_oldu_mu!= null) "gebelikte_sorun_oldu_mu": gebelikte_sorun_oldu_mu,
      if ( kronik_hastalik_var_mi!= null) "kronik_hastalik_var_mi": kronik_hastalik_var_mi ,
      if ( annenin_kacinci_dogumu!= null) "annenin_kacinci_dogumu": annenin_kacinci_dogumu,
      if ( yapilan_asilar!= null) "yapilan_asilar": yapilan_asilar,
      if ( topuk_kani_problem!= null) "topuk_kani_problem": topuk_kani_problem,
      if ( kalca_cikigi_taramasi_yapildi_mi!= null) "kalca_cikigi_taramasi_yapildi_mi": kalca_cikigi_taramasi_yapildi_mi,
      if ( duyma_testi_yapildi_mi!= null) "duyma_testi_yapildi_mi": duyma_testi_yapildi_mi,
      if ( dogumdaki_bas_cevresi != null) "dogumdaki_bas_cevresi" : dogumdaki_bas_cevresi,
      if ( dogumdaki_boy != null) "dogumdaki_boy" : dogumdaki_boy,
      if ( dogumdaki_kilo != null) "dogumdaki_kilo" : dogumdaki_kilo,
      if ( persentil != null) "persentil": toJsonPersentil(),
    };
  }
}


class AnneUser {
  final String? id;
  final String? isim;
  final String? soyisim;
  final String? mail;
  final String? sifre;
  List<Bebek> bebekler = [];

  AnneUser({
    required this.id,
    required this.isim,
    required this.soyisim,
    required this.mail,
    required this.sifre,
    required this.bebekler,

  });

  factory AnneUser.fromJson(Map<String, dynamic> json) {
    List<Bebek> bebekler = [];
    if (json['bebekler'] != null) {
      for (var bebek in json['bebekler']) {
        Bebek newBebek = Bebek.fromJson(bebek);
        bebekler.add(newBebek);
      }
    }

    return AnneUser(
        id: json['mail'],
        isim: json['isim'],
        soyisim: json['soyisim'],
        mail: json['mail'],
        sifre: json['sifre'],
        bebekler: bebekler
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> bebeklerMap = [];
    for (var bebek in bebekler) {
      bebeklerMap.add(bebek.toJson());
    }
    print("AnneUser içindeki bebekler list length:");
    print(bebekler.length);
    return {
      if (id != null) "id": id,
      if (isim != null) "isim": isim,
      if (soyisim != null) "soyisim": soyisim,
      if (mail != null) "mail": mail,
      if (sifre != null) "sifre": sifre,
      if (bebekler != null) "bebekler": bebeklerMap,
    };

  }

}