import 'package:bloc/bloc.dart';
import 'package:logregwithbloc/blocs/homePageBloc/home_page_event.dart';
import 'package:logregwithbloc/blocs/homePageBloc/home_page_state.dart';
import 'package:logregwithbloc/repositories/user_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  UserRepository userRepository;

  HomePageBloc() {
    this.userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  HomePageState get initialState => LogOutInitial();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LogoutButtonPressedEvent) {
      await userRepository.signOut();
      yield LogOutSuccess();
    }
  }
}
