part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState{}

class PaymentLoaded extends PaymentState{
  final List<PaymentModel>payment;

  PaymentLoaded(this.payment);
}

class PaymentSuccess extends PaymentState{
  final String message;
  PaymentSuccess(this.message);
}

class PaymentFailure extends PaymentState{
  final String error;

  PaymentFailure(this.error);
}


class PaymentEmpty extends PaymentState {}
