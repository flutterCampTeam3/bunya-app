part of 'services.dart';

extension OfficeUserServices on DBService {
//--- Office SignUp func
  Future<void> signUpO({
    required String email,
    required String password,
    required String userName,
  }) async {
    final respons = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    id = respons.user!.id;
    // Send email verification
    await supabase.auth.resetPasswordForEmail(email);
  }

  //--- Office SignUp func
  Future createProfileOffice({
    required String email,
    required String userName,
    required String departmentId,
    required String phoneNumber,
    required String cr,
    required String disc,
    required String image,
  }) async {
    await supabase.from('Offices').insert(
      {
        'departmentId': departmentId,
        'name': userName,
        'officeId': supabase.auth.currentUser!.id,
        'cr': cr,
        'disc': disc,
        'phoneNumber': int.parse(phoneNumber),
        'email': email,
        'image': image,
      },
    );
  }

  // Get Office Profile
  Future getOffice() async {
    final response = await supabase
        .from('Offices')
        .select('*')
        .eq('officeId', supabase.auth.currentUser!.id)
        .single();
    ProfileOfficeModel profileoffice = ProfileOfficeModel.fromJson(response);
    return profileoffice;
  }

  //  edit office profile
  Future editUpdateOffice(
      {required String name,
      required int phone,
      required String description}) async {
    await supabase.from('Offices').update(
      {
        'name': name,
        'disc': description,
        'phoneNumber': phone,
      },
    ).match({'officeId': supabase.auth.currentUser!.id});
  }

  // office post like number
  Future getOfficeLikeOfficeNumber() async {
    final postLikeNumber = await supabase
        .from('post_likes')
        .select('*')
        .eq('postOfficeId', supabase.auth.currentUser!.id);
    if (postLikeNumber.isNotEmpty) {
      final List<postLikeModel> likes = [];
      for (var element in postLikeNumber) {
        likes.add(postLikeModel.fromJson(element));
      }
      return likes.length;
    } else {
      return 0;
    }
  }

  // office follower number
  Future followerOfficeNumber() async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('officeId', supabase.auth.currentUser!.id);
    if (followerNumber.isNotEmpty) {
      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
      return follower.length;
    } else {
      return 0;
    }
  }

  // office following number
  Future followingOfficeNumber() async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id);
    if (followerNumber.isNotEmpty) {
      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
      return follower.length;
    } else {
      return 0;
    }
  }

  // Get posts
  Future<List<postModel>> getPostsOffficeId() async {
    final postData = await supabase
        .from('post')
        .select('*')
        .match({'ofiiceId': supabase.auth.currentUser!.id});
    final List<postModel> classposts = [];
    for (var element in postData) {
      classposts.add(postModel.fromJson(element));
    }
    return classposts;
  }

  // Add post
  Future addPost({
    required String desc,
  }) async {
    await supabase.from('post').insert(
      {
        'ofiiceId': supabase.auth.currentUser!.id,
        'desc': desc,
        'image': imageId
      },
    );
  }
}
