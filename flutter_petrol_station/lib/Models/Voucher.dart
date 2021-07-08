class Voucher{
  final int Voucher_Id;
  final int Customer_Id;
  final int Fuel_Type_Id;
  final double Voucher_Value;
  final DateTime Voucher_Date;
  final String Note;

  Voucher(this.Voucher_Id, this.Customer_Id, this.Fuel_Type_Id, this.Voucher_Value, this.Voucher_Date, this.Note);

}