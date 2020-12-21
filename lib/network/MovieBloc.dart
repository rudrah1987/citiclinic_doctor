import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/network/ApiRepository.dart';
import 'package:city_clinic_doctor/network/ApiResult.dart';
import 'package:city_clinic_doctor/network/NetworkExceptions.dart';
import 'package:city_clinic_doctor/network/movie_event.dart';
import 'package:city_clinic_doctor/network/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, ResultState<SignUpResponse>> {
  final APIRepository apiRepository;

  MovieBloc({this.apiRepository})
      : assert(apiRepository != null),
        super(Idle());

  @override
  Stream<ResultState<SignUpResponse>> mapEventToState(MovieEvent event) async* {

    yield ResultState.loading();

   /* if (event is LoadMovies) {

      ApiResult<SignUpResponse> apiResult = await apiRepository.signUp(name, phone, email,
          password, fb_token, longitude, latitude);

      yield* apiResult.when(success: (SignUpResponse data) async* {

        yield ResultState.data(data: data);

      }, failure: (NetworkExceptions error) async* {

        yield ResultState.error(error: error);

      });
    }*/
  }
}
