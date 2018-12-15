import 'package:gsy_github_app_flutter/common/model/Account.dart';
import 'package:redux/redux.dart';

/**
 * Account Redux
 */

final AccountReducer = combineReducers<List<Account>>([
  TypedReducer<List<Account>, RefreshAccountAction>(_refresh),
  TypedReducer<List<Account>, LoadMoreAccountAction>(_loadMore),
]);

List<Account> _refresh(List<Account> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}

List<Account> _loadMore(List<Account> list, action) {
  if (action.list != null) {
    list.addAll(action.list);
  }
  return list;
}

class RefreshAccountAction {
  final List<Account> list;

  RefreshAccountAction(this.list);
}

class LoadMoreAccountAction {
  final List<Account> list;

  LoadMoreAccountAction(this.list);
}
