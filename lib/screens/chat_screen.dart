import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String user1Id;
  final String user2Id;

  ChatScreen({required this.user1Id, required this.user2Id});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  CollectionReference<Map<String, dynamic>>? _chatRef;
  bool _isChatInitialized = false;

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

    setState(() {
      _isChatInitialized = true;
    });
  }

  void _sendMessage() {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty && _chatRef != null) {
      try {
        _chatRef!.add({
          'senderId': widget.user1Id,
          'text': messageText,
          'timestamp': FieldValue.serverTimestamp(),
        }).then((value) {
          _controller.clear();

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
      emojiShowing = !emojiShowing;
    });
  }

  void _selectEmoji(String emoji) {
    _controller.text += emoji;
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: !_isChatInitialized
            ? Center(child: CircularProgressIndicator())
            : Column(
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

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                    color:
                                        isUser1 ? Colors.blue : Colors.yellow,
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
                    height: 66.0,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: _toggleEmojiPicker,
                            icon: Icon(
                              Icons.emoji_emotions,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                  left: 16.0,
                                  bottom: 8.0,
                                  top: 8.0,
                                  right: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: _sendMessage,
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: !emojiShowing,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        textEditingController: _controller,
                        onBackspacePressed: _onBackspacePressed,
                        config: Config(
                          columns: 7,
                          // Issue: https://github.com/flutter/flutter/issues/28894
                          emojiSizeMax: 32 *
                              (foundation.defaultTargetPlatform ==
                                      TargetPlatform.iOS
                                  ? 1.30
                                  : 1.0),
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          initCategory: Category.RECENT,
                          bgColor: const Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          backspaceColor: Colors.blue,
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          recentTabBehavior: RecentTabBehavior.RECENT,
                          recentsLimit: 28,
                          replaceEmojiOnLimitExceed: false,
                          noRecents: const Text(
                            'No Recents',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                          loadingIndicator: const SizedBox.shrink(),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                          checkPlatformCompatibility: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
