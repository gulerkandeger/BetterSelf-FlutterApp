import 'package:better_self/model/pariltili_degisim_model.dart';
import 'package:better_self/services/pariltili_degisim_services.dart';
import 'package:better_self/status/parilti_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PariltiliDegisimCubit extends Cubit<PariltiState>{
  PariltiliDegisimCubit(): super(PariltiInitialState());

  final PariltiliDegisimService pariltiService = PariltiliDegisimService();

  void getKendiniSevChallenges() async {
    emit(PariltiLoadingState());
    try {
      List<PariltiliDegisimModel> challengeList = await pariltiService.kendiniSevVeriAlma();
      emit(PariltiLoadedState(challengeList.map((challenge) => challenge.toMap()).toList()));
    } catch (e) {
      emit(PariltiErrorState('Veri alınamadı.'));
    }
  }

  void updateKendiniSevCheck(String docId, bool check) async {
    try {
      await pariltiService.kendiniSevCheckUpdate(docId, check);
      List<PariltiliDegisimModel> challengeList = await pariltiService.kendiniSevVeriAlma();
      emit(PariltiLoadedState(challengeList.map((challenge) => challenge.toMap()).toList()));
    } catch (e) {
      emit(PariltiErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }

  void getOzguvenChallenges() async {
    emit(PariltiLoadingState());
    try {
      List<PariltiliDegisimModel> challengeList = await pariltiService.ozguvenVeriAlma();
      emit(PariltiLoadedState(challengeList.map((challenge) => challenge.toMap()).toList()));
    } catch (e) {
      emit(PariltiErrorState('Veri alınamadı.'));
    }
  }

  void updateOzguvenCheck(String docId, bool check) async {
    try {
      await pariltiService.kendiniSevCheckUpdate(docId, check);
      emit(PariltiSuccessState());
    } catch (e) {
      emit(PariltiErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }

  void getMentalChallenges() async {
    emit(PariltiLoadingState());
    try {
      List<PariltiliDegisimModel> challengeList = await pariltiService.mentalVeriAlma();
      emit(PariltiLoadedState(challengeList.map((challenge) => challenge.toMap()).toList()));
    } catch (e) {
      emit(PariltiErrorState('Veri alınamadı.'));
    }
  }

  void updateMentalCheck(String docId, bool check) async {
    try {
      await pariltiService.kendiniSevCheckUpdate(docId, check);
      emit(PariltiSuccessState());
    } catch (e) {
      emit(PariltiErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }

  void getUretkenlikChallenges() async {
    emit(PariltiLoadingState());
    try {
      List<PariltiliDegisimModel> challengeList = await pariltiService.uretkenlikVeriAlma();
      emit(PariltiLoadedState(challengeList.map((challenge) => challenge.toMap()).toList()));
    } catch (e) {
      emit(PariltiErrorState('Veri alınamadı.'));
    }
  }

  void updateUretkenlikCheck(String docId, bool check) async {
    try {
      await pariltiService.kendiniSevCheckUpdate(docId, check);
      emit(PariltiSuccessState());
    } catch (e) {
      emit(PariltiErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }

  void getKisiselGelisimChallenges() async {
    emit(PariltiLoadingState());
    try {
      List<PariltiliDegisimModel> challengeList = await pariltiService.kisiselGelisimVeriAlma();
      emit(PariltiLoadedState(challengeList.map((challenge) => challenge.toMap()).toList()));
    } catch (e) {
      emit(PariltiErrorState('Veri alınamadı.'));
    }
  }

  void updateKisiselGelisimCheck(String docId, bool check) async {
    try {
      await pariltiService.kendiniSevCheckUpdate(docId, check);
      emit(PariltiSuccessState());
    } catch (e) {
      emit(PariltiErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }

}
