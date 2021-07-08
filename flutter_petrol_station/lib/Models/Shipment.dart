class Shipment{
  final int Shipment_Id;
  final int Provider_Id;
  final int Container_Id;
  final double Shipment_Volume;
  final double Shipment_Value;
  final bool IsPadi;
  final DateTime Shipment_Date;
  final DateTime Paid_Date;
  final String Comment;

  Shipment(this.Shipment_Id, this.Provider_Id, this.Container_Id, this.Shipment_Volume, this.Shipment_Value, this.IsPadi, this.Shipment_Date, this.Paid_Date, this.Comment);

}