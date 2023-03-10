import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/language.dart';
import '../../../../utils/datasource/prefs.dart';

part 'language_event.dart';
part 'language_state.dart';

const languagePrefsKey = 'languagePrefs';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    await Prefs()
        .setString(languagePrefsKey, event.selectedLanguage.value.languageCode);
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  onGetLanguage(GetLanguage event, Emitter<LanguageState> emit) async {
    final selectedLanguage = Prefs().getString(languagePrefsKey);
    emit(state.copyWith(
      selectedLanguage: selectedLanguage != null
          ? Language.values
              .where((item) => item.value.languageCode == selectedLanguage)
              .first
          : Language.english,
    ));
  }
}
