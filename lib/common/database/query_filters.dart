abstract class QueryFilter {
  const QueryFilter();
}

enum WhereCondition { equalsTo, arrayContains, whereIn }

class Where extends QueryFilter {
  final String key;
  final WhereCondition condition;
  final dynamic value;

  const Where({
    required this.key,
    required this.condition,
    required this.value,
  });

  bool get equalsTo => condition == WhereCondition.equalsTo;
  bool get arrayContains => condition == WhereCondition.arrayContains;
  bool get whereIn => condition == WhereCondition.whereIn;
}

enum OrderRule { asc, desc }

class OrderBy extends QueryFilter {
  final String key;
  final OrderRule rule;

  const OrderBy({required this.key, required this.rule});

  bool get asc => rule == OrderRule.asc;
  bool get desc => rule == OrderRule.desc;
}
