import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatOneToOne extends StatefulWidget {
  final String otherUid;
  final String otherName;
  final String uId;
  const ChatOneToOne(
      {super.key,
      required this.otherUid,
      required this.otherName,
      required this.uId});

  @override
  State<ChatOneToOne> createState() => _ChatOneToOneState();
}

class _ChatOneToOneState extends State<ChatOneToOne> {
  final _msgCtl = TextEditingController();
  final _scroll = ScrollController();
  int _lastMessagesCount = 0; // لمراقبة عدد الرسائل

  String _chatIdFor(String a, String b) {
    final ids = [a, b]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  bool _firstLoad = true;

  Future<void> _send() async {
    final text = _msgCtl.text.trim();
    if (text.isEmpty) return;
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatIdFor(widget.uId, widget.otherUid))
        .collection('messages')
        .add({
      'text': text,
      'from': widget.uId,
      'last_seen': FieldValue.serverTimestamp(),
      'to': widget.otherUid,
      'createdAt': FieldValue.serverTimestamp(),
    });
    _msgCtl.clear();
    await Future.delayed(const Duration(milliseconds: 100));
    _scroll.jumpTo(_scroll.position.maxScrollExtent);
  }

  Future<void> _playNotificationSound() async {
    try {
      final AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(AssetSource('sounds/sound.mp3'));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final me = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(_chatIdFor(widget.uId, widget.otherUid))
                  .collection('messages')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final msgs = snap.data!.docs;

                // 🔔 اكتشاف الرسائل الجديدة
                if (_lastMessagesCount != msgs.length) {
                  final last = msgs.isNotEmpty ? msgs.last.data() : null;

                  // لو دي أول مرة نعمل load للـ messages، مش نشغل الصوت
                  if (!_firstLoad) {
                    if (last != null && last['from'] != me.uid) {
                      _playNotificationSound();
                    }
                  }

                  _lastMessagesCount = msgs.length;

                  // بعد أول load نضع flag false
                  _firstLoad = false;

                  // Scroll للآخر
                  Future.microtask(() {
                    if (_scroll.hasClients) {
                      _scroll.jumpTo(_scroll.position.maxScrollExtent);
                    }
                  });
                }

                return ListView.builder(
                  controller: _scroll,
                  itemCount: msgs.length,
                  itemBuilder: (context, i) {
                    final m = msgs[i].data();
                    final isMe = m['from'] == me.uid;
                    final time = (m['createdAt'] as Timestamp?)?.toDate();
                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(m['text'] ?? ''),
                            if (time != null)
                              Text(
                                DateFormat('hh:mm a').format(time),
                                style: const TextStyle(fontSize: 10),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                        controller: _msgCtl,
                        decoration:
                            const InputDecoration(hintText: 'Type a message')),
                  ),
                ),
                IconButton(onPressed: _send, icon: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
