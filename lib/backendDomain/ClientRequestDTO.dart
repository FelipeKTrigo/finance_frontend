
class ClientRequestDTO{
  String name;
  double salary;
  ClientRequestDTO(this.name,this.salary);
  Map<String,dynamic> serial(){
    return {'name':this.name,'salary': this.salary};
  }
}