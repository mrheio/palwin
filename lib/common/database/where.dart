enum WhereCondition { equalsTo, arrayContains }

class Where {
  final String key;
  final WhereCondition condition;
  final dynamic value;

  Where({
    required this.key,
    required this.condition,
    required this.value,
  });

  bool get equalsTo => condition == WhereCondition.equalsTo;
  bool get arrayContains => condition == WhereCondition.arrayContains;
}
