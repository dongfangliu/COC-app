import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';

enum RequestType { SAVE, DELETE, UPDATE, QUERY, QUERIES }
class Request<T extends BmobObject> {
  RequestType _type;
  T _data;
  BmobQuery<T> _query;
  Request.querySingle(this._query) {
    this._type = RequestType.QUERY;
  }
  Request.queryObjects(this._query) {
    this._type = RequestType.QUERIES;
  }
  Request.Object(this._type, this._data);

  Future execute() {
    try {
      if (_type == RequestType.SAVE) {
        return _data.save();
      }
      if (_type == RequestType.DELETE) {
        return _data.delete();
      }
      if (_type == RequestType.UPDATE) {
        return _data.update();
      }
      if (_type == RequestType.QUERIES) {
        return _query.queryObjects();
      }
    } catch (e) {
      throw e;
    }
  }
}