// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/checkout_repo.dart';
import 'package:petspot_admin_side/infrastructure/models/payment_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {

final CheckoutRepository repository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    on<AddPayment>((event, emit)async {
     emit(PaymentLoading());
     try{
      await repository.addPayment(event.payment);
      emit(PaymentSuccess('Payment Success'));
     }catch(e){
      emit(PaymentFailure(e.toString()));
     }
    });
  }
}
