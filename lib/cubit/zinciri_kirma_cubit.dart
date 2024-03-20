import 'package:better_self/model/zinciri_kirma_model.dart';
import 'package:better_self/services/zinciri_kirma_services.dart';
import 'package:better_self/status/zinciri_kirma_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZinciriKirmaCubit extends Cubit<ZincirState>{
  ZinciriKirmaCubit(): super(ZincirInitialState());

  final ZinciriKirmaService zincirService = ZinciriKirmaService();

  void getHabits() async {
    emit(ZincirLoadingState());
    try {
      List<ZinciriKirmaModel> challengeList = await zincirService.zinciriKirmaVeriAl();
      emit(ZincirLoadedState(challengeList.map((habit) => habit.toMap()).toList()));
    } catch (e) {
      emit(ZincirErrorState('Veri alınamadı.'));
    }
  }

  void addHabits(String habitName, String habitDesc, DateTime startDate, int habitTime) async{
    try{
      await zincirService.zinciriKirmaVeriEkle(habitName, habitDesc, startDate, habitTime);
      List<ZinciriKirmaModel> gorevList = await zincirService.zinciriKirmaVeriAl();
      emit(ZincirLoadedState(gorevList.map((gorev) => gorev.toMap()).toList()));
    }catch(e){
      emit(ZincirErrorState('Veri eklenemedi.'));
    }
  }

  void updateHabits(String id, String habitName, String habitDesc) async {
    try {
      await zincirService.zinciriKirmaVeriGuncelle(id, habitName,habitDesc);
      List<ZinciriKirmaModel> challengeList = await zincirService.zinciriKirmaVeriAl();
      emit(ZincirLoadedState(challengeList.map((habit) => habit.toMap()).toList()));
    } catch (e) {
      emit(ZincirErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }

  void deleteHabits(String id) async {
    try{
      await zincirService.zinciriKirmaVeriSil(id);
      List<ZinciriKirmaModel> gorevList = await zincirService.zinciriKirmaVeriAl();
      emit(ZincirLoadedState(gorevList.map((habit) => habit.toMap()).toList()));
    }catch(e){
      emit(ZincirErrorState('Veri silinemedi.'));
    }
  }

}
