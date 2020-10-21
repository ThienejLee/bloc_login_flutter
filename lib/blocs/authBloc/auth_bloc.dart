import 'package:bloc/bloc.dart';
import 'package:logregwithbloc/blocs/authBloc/auth_event.dart';
import 'package:logregwithbloc/blocs/authBloc/auth_state.dart';
import 'package:logregwithbloc/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;

  AuthBloc() {
    this.userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartEvent) {
      var isSignedIn = await userRepository.isSignedIn();
      try {
        if (isSignedIn) {
          var user = await userRepository.getCurrentUSer();
          yield AuthenticatedState(user: user);
        } else {
          yield UnAuthenticatedState();
        }
      } catch (e) {
        yield UnAuthenticatedState();
      }
    }
  }
}
