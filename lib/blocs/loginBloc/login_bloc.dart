import 'package:bloc/bloc.dart';
import 'package:logregwithbloc/blocs/loginBloc/login_event.dart';
import 'package:logregwithbloc/blocs/loginBloc/login_state.dart';
import 'package:logregwithbloc/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc() {
    this.userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginButtonPressedEvent) {
      try {
        yield LoginLoadingState();
        var user = await userRepository.signInUser(event.email, event.password);
        yield LoginSuccessState(user: user);
      } catch (e) {
        yield LoginFailureState(message: e.toString());
      }
    }
  }
}
