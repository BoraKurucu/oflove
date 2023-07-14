import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String user1Id;
  final String user2Id;

  ChatScreen({required this.user1Id, required this.user2Id});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  CollectionReference<Map<String, dynamic>>? _chatRef;
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('user1Id', isEqualTo: widget.user1Id)
        .where('user2Id', isEqualTo: widget.user2Id)
        .get();

    if (querySnapshot.size > 0) {
      final chatDoc = querySnapshot.docs[0];
      _chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatDoc.id)
          .collection('messages');
    } else {
      final chatDoc = await FirebaseFirestore.instance.collection('chats').add({
        'user1Id': widget.user1Id,
        'user2Id': widget.user2Id,
      });
      _chatRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(chatDoc.id)
          .collection('messages');
    }
    setState(() {}); // Trigger a rebuild after initialization
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty && _chatRef != null) {
      try {
        _chatRef!.add({
          'senderId': widget.user1Id,
          'text': messageText,
          'timestamp': FieldValue.serverTimestamp(),
        }).then((value) {
          _messageController.clear();

          // Scroll to the last message after sending the message
          Future.delayed(Duration(milliseconds: 300), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        });
      } catch (e) {
        // Handle any exceptions here
        print('Error sending message: $e');
      }
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formatter = DateFormat.Hm(); // Hour and minute format
    return formatter.format(dateTime);
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _selectEmoji(String emoji) {
    _messageController.text += emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _chatRef != null
          ? Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _chatRef!
                        .orderBy('timestamp', descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('No messages found.');
                      }

                      final messages = snapshot.data!.docs;

                      return ListView.builder(
                        controller: _scrollController,
                        reverse: false,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final message = messages[index];
                          final messageText = message['text'];
                          final senderId = message['senderId'];
                          final timestamp = message['timestamp'] as Timestamp;

                          final isUser1 = senderId == widget.user1Id;

                          return ListTile(
                            title: Align(
                              alignment: isUser1
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: isUser1 ? Colors.blue : Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  messageText,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            subtitle: Text(
                              _formatTimestamp(timestamp),
                              textAlign:
                                  isUser1 ? TextAlign.left : TextAlign.right,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
