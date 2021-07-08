class Container{
  final int Container_Id;
  final int Fuel_Type_Id;
  final String Container_Name;
  final double Capacity;
  final double Volume;

  Container(this.Container_Id, this.Fuel_Type_Id, this.Container_Name, this.Capacity, this.Volume);


  int get_container_id(){return this.Container_Id;}

}
