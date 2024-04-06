import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/home/data/models/outage_model.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/data/repositories/outage_repository.dart';
import 'package:meta/meta.dart';

part 'eneo_outage_event.dart';
part 'eneo_outage_state.dart';

class EneoOutageBloc extends Bloc<EneoOutageEvent, EneoOutageState> {
  final OutageRepository _outageRepository;
  List<EneoOutageModel> outages = [];

  // List<EneoOutageModel> outages = List.generate(10, (index) {
  //   Faker faker = Faker();
  //   return EneoOutageModel(
  //     observations: faker.address.city(),
  //     quartier: faker.address.city(),
  //     region: faker.address.city(),
  //     ville: faker.address.city(),
  //     progDate: faker.lorem.sentence(),
  //     progHeureDebut: "https://picsum.photos/id/3${index}/800/1200",
  //     progHeureFin: faker.lorem.sentence(),
  //   );
  // });

  EneoOutageBloc(this._outageRepository) : super(EneoOutageInitial()) {
    on<EneoOutageEvent>((event, emit) {});

    on<GetOutEneoOutageEvent>((event, emit) async {
      emit(EneoOutageFetchLoading());
      try {
        List<EneoOutageModel> new_outages = await _outageRepository.getOutages(data: {"region": event.regionId});
        // emit(EneoOutageFetchLoaded(outages: outages));
        outages = new_outages;
        emit(EneoOutageFetchLoaded(outages: new_outages));
      } catch (e) {
        emit(EneoOutageFetchError(message: e.toString()));
      }
    });
  }
}
