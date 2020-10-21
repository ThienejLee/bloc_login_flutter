import 'package:bloc/bloc.dart';
import 'package:logregwithbloc/blocs/regBloc/user_reg_event.dart';
import 'package:logregwithbloc/blocs/regBloc/user_reg_state.dart';
import 'package:logregwithbloc/repositories/user_repository.dart';

class UserRegBloc extends Bloc<UserRegEvent, UserRegState> {
  UserRepository userRepository;

  UserRegBloc() {
    userRepository = UserRepository();
  }

  @override
  // TODO: implement initialState
  UserRegState get initialState => UserRegInitial();

  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if (event is SignUpButtonPressedEvent) {
      try {
        yield UserLoadingState();
        var user = await userRepository.createUser(event.email, event.password);
        yield UserRegSuccessful(user: user);
      } catch (e) {
        yield UserRegFailure(message: e.toString());
      }
    }
  }
}
