import 'package:better_self/model/ilham_noktasi_model.dart';
import 'package:better_self/services/ilham_noktasi_services.dart';
import 'package:better_self/status/ilham_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IlhamNoktasiCubit extends Cubit<IlhamState>{
  IlhamNoktasiCubit(): super(IlhamInitialState());

  final IlhamNoktasiService ilhamService = IlhamNoktasiService();

  void getIlhamlar() async {
    emit(IlhamLoadingState());
    try {
      List<IlhamNoktasiModel> ilhamList = await ilhamService.ilhamVeriAlma();
     // emit(IlhamLoadedState(ilhamList));
      emit(IlhamLoadedState(ilhamList.map((ilham) => ilham.toMap()).toList()));
    } catch (e) {
      emit(IlhamErrorState('Veri alınamadı.'));
    }
  }

  void getFavIlhamlar() async {
    emit(IlhamLoadingState());
    try {
      List<IlhamNoktasiModel> ilhamList = await ilhamService.favoriIlhamVeriAlma();
      // emit(IlhamLoadedState(ilhamList));
      emit(IlhamLoadedState(ilhamList.map((ilham) => ilham.toMap()).toList()));
    } catch (e) {
      emit(IlhamErrorState('Veri alınamadı.'));
    }
  }

  void updateIlham(String docId, bool favori) async {
    try {
      await ilhamService.ilhamFavGuncelleme(docId, favori);
      emit(IlhamSuccessState());
    } catch (e) {
      emit(IlhamErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }
}
