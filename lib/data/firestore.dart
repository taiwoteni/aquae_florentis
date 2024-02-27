import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/domain/models/rating.dart';
import 'package:aquae_florentis/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppFireStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference<Map<dynamic, dynamic>> _usersRef =
      _firestore.collection("users");
  static final CollectionReference<Map<dynamic, dynamic>> _communityRef =
      _firestore.collection("communities");
  static CollectionReference<Map<dynamic, dynamic>> _membersRef(
      {required final String id}) {
    return _communityRef.doc(id).collection("members");
  }
  static CollectionReference<Map<dynamic, dynamic>> _ratingsRef(
      {required final String id}) {
    return _communityRef.doc(id).collection("ratings");
  }

  static CollectionReference<Map<dynamic, dynamic>> _announcementsRef(
      {required final String id}) {
    return _communityRef.doc(id).collection("announcements");
  }

  static Future<List<User>> allUsers() async {
    final snapshot = await _usersRef.get();
    final jsonList =
        snapshot.docs.map((quearyDocSnap) => quearyDocSnap.data()).toList();
    return jsonList.map((json) => User.fromJson(json: json)).toList();
  }

  static Future<List<User>> allMembers(
      {required final Community community}) async {
    final snapshot = await _membersRef(id: community.id).get();
    final jsonList =
        snapshot.docs.map((quearyDocSnap) => quearyDocSnap.data()).toList();
    return jsonList.map((json) => User.fromJson(json: json)).toList();
  }

  static Future<List<Rating>> allRatings(
      {required final Community community}) async {
    final snapshot = await _ratingsRef(id: community.id).get();
    final jsonList =
        snapshot.docs.map((quearyDocSnap) => quearyDocSnap.data()).toList();
    return jsonList.map((json) => Rating(id: json["id"], rating: json["rating"])).toList();
  }

  static Future<List<Community>> allCommunities() async {
    List<Community> communities = [];
    final snapshot = await _communityRef.get();
    final jsonList =
        snapshot.docs.map((quearyDocSnap) => quearyDocSnap.data()).toList();
    // We get the original list of communities from firestore
    final rawCommunities =
        jsonList.map((json) => Community.fromJson(json: json)).toList();

    // We edit each community and add it to the mao
    for (final community in rawCommunities) {
      final membersSnapshot = await _membersRef(id: community.id).get();
      final size = membersSnapshot.size;
      Map<dynamic, dynamic> communityJson = community.toJson();
      communityJson["community size"] = size;

      communities.add(Community.fromJson(json: communityJson));
    }
    return communities;
  }

  static Future<void> addUser({required final User user}) async {
    final map = user.toJson();
    final Map<String, dynamic> json = {};
    map.forEach((key, value) {
      json[key.toString()] = value;
    });
    await _usersRef.doc(user.id).set(json);
  }

  static Future<void> addCommunity({required final Community community}) async {
    final map = community.toJson();
    final Map<String, dynamic> json = {};
    map.forEach((key, value) {
      json[key.toString()] = value;
    });
    await _communityRef.doc(community.id).set(json);
  }

  static Future<void> addMember(
      {required final Community community, required final User user}) async {
    final map = user.toJson();
    final Map<String, dynamic> json = {};
    map.forEach((key, value) {
      json[key.toString()] = value;
    });
    await _membersRef(id: community.id).doc(user.id).set(json);
  }
  static Future<void> addRating(
      {required final Community community, required final Rating rating, required double newRating, required int newRatedCount}) async {
    await _ratingsRef(id: community.id).doc(rating.id).set(rating.toJson());
    await _communityRef.doc(community.id).update({"rating":newRating, "rated count":newRatedCount});
  }
}
