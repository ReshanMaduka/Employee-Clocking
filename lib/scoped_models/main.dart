import 'package:scoped_model/scoped_model.dart';
import './connected-schedules.dart';

class MainModel extends Model with ConnectedScheduleModel,UserModel,UtilityModel,ShiftModel{


}