class Loan {
  String client; // nombre del cliente
  String mount; // monto total a prestar
  double interest; // intereses del prestamo
  int monthlyPayment; // cuotas mensuales
  int totalMonthlyPayment; // total de cuotas mensuales
  int lateFee; // mora a cobrar por si se pasa del limite de pago de una cuota
  String firstPayment; // primer cuota de pago
  String date; // fecha en que se realizo el prestamo
  int paid; // cuotas pagadas

  Loan({required this.client, required this.mount, required this.interest, required this.monthlyPayment, required this.totalMonthlyPayment, 
  required this.lateFee, required this.firstPayment, required this.date, required this.paid});
}