import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/models/user_model.dart';

class FireBaseFunctions {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<TaskModel?> taskMainFireStore() {
    return firestore.collection("Tasks").withConverter(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value!.toJson();
      },
    );
  }

  static CollectionReference<UserModel?> userMainFireStore() {
    return firestore.collection("Users").withConverter(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value!.toJson();
      },
    );
  }

  static addTask(TaskModel task) async {
    var ref = taskMainFireStore();
    var docRef = ref.doc();
    task.id = docRef.id;
    await docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel?>> getTask(int time) {
    var ref = taskMainFireStore();
    var data = ref
        .where("date", isEqualTo: time)
        .where("userId",
            isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? "")
        .snapshots();
    return data;
  }

  static deleteTask(String id) async {
    var ref = taskMainFireStore();
    ref.doc(id).delete();
  }

  static setDone(TaskModel model) async {
    var ref = taskMainFireStore();
    model.isDone = !model.isDone;
    await ref.doc(model.id).update(model.toJson());
  }

  static addUser(UserModel user) async {
    var ref = userMainFireStore();
    await ref.doc(user.id).set(user);
  }

  static Future<UserModel> getUser() async {
    var ref = userMainFireStore();
    var data =
        await ref.doc(FirebaseAuth.instance.currentUser?.uid ?? "").get();
    UserModel userModel = data.data()!;
    return userModel;
  }

  static Future<UserCredential> createAccount(
      String email, String password, String name, String phone) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      addUser(UserModel(
          email: email, name: name, id: credential.user!.uid, phone: phone));
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw e.toString();
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  static Future<UserCredential> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  static logout() {
    FirebaseAuth.instance.signOut();
  }
}
