import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // Convert to a map
  Map<String, dynamic> toMap() {
    return {
      'SenderID': senderID,
      'SenderEmail': senderEmail,
      'ReceiverID': receiverID,
      'Message': message,
      'Timestamp': timestamp,
    };
  }

  // Create from a map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderID: map['SenderID'] ?? '',
      senderEmail: map['SenderEmail'] ?? '',
      receiverID: map['ReceiverID'] ?? '',
      message: map['Message'] ?? '',
      timestamp: map['Timestamp'] ?? Timestamp.now(),
    );
  }
}
