import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/donation/data/repository/donate_repository.dart';
import 'package:flutterwave_standard/flutterwave.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final DonationRepository donateRepository;
  DonationBloc(this.donateRepository) : super(DonationInitial()) {
    on<DonationEvent>((event, emit) {});
    on<DonationDonateEvent>((event, emit) {
      try {
        emit(DonationDonateInitial());
      } catch (e) {}
    });
  }
}
