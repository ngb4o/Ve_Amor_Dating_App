import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ve_amor_app/features/main/models/message_model.dart';
import 'package:ve_amor_app/data/repositories/chat/message_repository.dart';

class MessageController extends GetxController {
  final MessageRepository _messageRepository = Get.put(MessageRepository());

  // Rx variables for UI state management
  RxList<MessageModel> messages = <MessageModel>[].obs;
  final messageTextController = TextEditingController();
  RxBool isLoading = false.obs;

  // Send a message
  Future<void> sendMessage(String receiverID) async {
    String message = messageTextController.text.trim();
    if (message.isNotEmpty) {
      try {
        await _messageRepository.sendMessage(receiverID, message);
        messageTextController.clear();
      } catch (e) {
        Get.snackbar('Error', 'Failed to send message: $e');
      }
    }
  }

  // Stream messages
  Stream<List<MessageModel>> streamMessages(String userID, String otherUserID) {
    return _messageRepository.getMessage(userID, otherUserID).map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Load messages and update RxList
  void loadMessages(String userID, String otherUserID) {
    isLoading.value = true; // Bật trạng thái loading
    try {
      streamMessages(userID, otherUserID).listen((messageList) {
        messages.value = messageList;
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages: $e');
    } finally {
      isLoading.value = false; // Tắt trạng thái loading
    }
  }
}
