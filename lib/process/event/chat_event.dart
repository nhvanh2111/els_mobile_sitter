abstract class ChatEvent{}
class OtherChatEvent extends ChatEvent{}
class SendMsgChatEvent extends ChatEvent{
  SendMsgChatEvent({required this.otherID});
  final String otherID;
}