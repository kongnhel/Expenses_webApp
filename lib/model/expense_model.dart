class ExpenseModel {
  final String? id; 
  final String categories;
  final String amount;
  final String date;
  final String? note;

  ExpenseModel({
    this.id,
    required this.categories,
    required this.amount,
    required this.date,
    this.note,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id']?.toString(),
      categories: json['categories'].toString(),
      amount: json['amount'].toString(),
      date: json['date'].toString(),
      note: json['note']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'categories': categories,
      'amount': amount,
      'date': date,
      'note': note,
    };
    if (id != null && id!.isNotEmpty) {
      data['id'] = id;
    }
    return data;
  }
}
