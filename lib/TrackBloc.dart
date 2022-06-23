import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/models/trackModel.dart';
import 'package:music_player/services/connectivityservice.dart';
import 'package:music_player/services/newtorkservices.dart';

class TrackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchList extends TrackEvent {}

class FetchDetail extends TrackEvent {
  int _id;

  FetchDetail(this._id);

  @override
  List<Object> get props => [_id];
}

class TrackListLoading extends TrackState {}

class TrackListLoaded extends TrackState {
  final _tracklist;

  TrackListLoaded(this._tracklist);

  List<Track> get tracks => _tracklist;

  @override
  List<Object> get props => [_tracklist];
}

class TrackDetailLoading extends TrackState {}

class NoInternetState extends TrackState{

}

class NoInternetEvent extends TrackEvent{}

class TrackDetailLoaded extends TrackState {
  final _detail;

  TrackDetailLoaded(this._detail);

  @override
  List<Object> get props => [_detail];
}

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  API api;
  ConnectivityService _connectivityService;


  TrackBloc(this.api,this._connectivityService) : super(TrackListLoading()) {

    _connectivityService.connectivityStream.stream.listen((event){
      if(event == ConnectivityResult.none)
      {
        add(NoInternetEvent());
      }
      else
        {
          add(FetchList());
          }
    });

    on<FetchList>(((event, emit) async{
      emit(TrackListLoading());

      List<Track> tracks = await api.getTracks(); 

      emit(TrackListLoaded(tracks));
    }));

    on<FetchDetail>((event,emit) async{

      final detail= await api.getDetails(event._id);

      emit(TrackDetailLoaded(detail));
    });

    on<NoInternetEvent>(((event, emit) {
      emit(NoInternetState());
    }));

  }

}
