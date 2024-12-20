class UserFee{
  String? amount;
  String? due_date;
  String? status;
  String? name_fee;

  UserFee(this.amount, this.due_date, this.status, this.name_fee);
  UserFee.fromJson(Map<String,dynamic> json){
    amount=json['amount'];
    due_date=json['due_date'];
    status=json['status'];
    name_fee=json['name_fee'];
  }
}