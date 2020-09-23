import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_event.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';

abstract class ModuleDemostrationEvent extends TakeOperation{

}
class LikeInfoChange extends ModuleDemostrationEvent{
}
class CommentInfoChange extends ModuleDemostrationEvent{
}
class AddToLikes extends ModuleDemostrationEvent{
}