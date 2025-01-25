import 'package:cloud_firestore/cloud_firestore.dart';
import 'question.dart';

class QuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Question>> getQuestionsForLesson(String lessonId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('questions')
        .where('lessonId', isEqualTo: lessonId)
        .get();

    return snapshot.docs.map((doc) {

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['documentId'] = doc.id;
      return Question.fromMap(data);
    }).toList();
  }


  Future<Question?> getQuestionById(String documentId) async {
    DocumentSnapshot snapshot = await _firestore.collection('questions').doc(documentId).get();

    if (snapshot.exists) {
      return Question.fromMap(snapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }


  Future<void> createQuestion(Question question) async {
    await _firestore.collection('questions').add(question.toMap());
  }


  Future<void> updateQuestion(String documentId, Question question) async {
    await _firestore.collection('questions').doc(documentId).update(question.toMap());
  }


  Future<void> deleteQuestion(String documentId) async {
    await _firestore.collection('questions').doc(documentId).delete();
  }
}