import 'package:better_self/model/gunluk_hedefler_model.dart';
import 'package:better_self/services/gunluk_hedefler_services.dart';
import 'package:better_self/status/gunluk_hedef_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GunlukHedeflerCubit extends Cubit<GunlukHedefState>{
  GunlukHedeflerCubit(): super(GunlukHedefInitialState());

  final GunlukHedeflerService gunlukHedefService = GunlukHedeflerService();

  void getGunlukHedefler() async {
    emit(GunlukHedefLoadingState());
    try {
      List<GunlukHedeflerModel> gorevList = await gunlukHedefService.gunlukHedefVeriAlma();
      emit(GunlukHedefLoadedState(gorevList.map((gorev) => gorev.toMap()).toList()));
    } catch (e) {
      emit(GunlukHedefErrorState('Veriler alınamadı.'));
    }
  }

  void updateGunlukHedefler(String id, String yeniGorev, bool yeniCheck) async {
    try {
      await gunlukHedefService.gunlukHedefGuncelleme(id, yeniGorev, yeniCheck);
      List<GunlukHedeflerModel> gorevList = await gunlukHedefService.gunlukHedefVeriAlma();
      emit(GunlukHedefLoadedState(gorevList.map((gorev) => gorev.toMap()).toList()));
    } catch (e) {
      emit(GunlukHedefErrorState('Güncellenirken bir hata oluştu.'));
    }
  }

  void addGunlukHedefler(String gorev, bool check, String oncelik, DateTime tarih) async{
    try{
      await gunlukHedefService.gunlukHedefVeriEkleme(gorev, check, oncelik, tarih);
      List<GunlukHedeflerModel> gorevList = await gunlukHedefService.gunlukHedefVeriAlma();
      emit(GunlukHedefLoadedState(gorevList.map((gorev) => gorev.toMap()).toList()));
    }catch(e){
      emit(GunlukHedefErrorState('Veri eklenemedi.'));
    }
  }

  void deleteGunlukHedefler(String id) async {
    try{
      await gunlukHedefService.gunlukHedefSilme(id);
      List<GunlukHedeflerModel> gorevList = await gunlukHedefService.gunlukHedefVeriAlma();
      emit(GunlukHedefLoadedState(gorevList.map((gorev) => gorev.toMap()).toList()));
    }catch(e){
      emit(GunlukHedefErrorState('Veri silinemedi.'));
    }
  }
}
