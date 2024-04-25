part of 'services.dart';

extension CustomerUserServices on DBService {
  //---costumer SignUp func
  Future signUpC({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required String image,
  }) async {
    final respons = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    await supabase.from('Customer').insert(
      {
        'email': email,
        'name': userName,
        'phoneNumber': int.parse(phoneNumber),
        'customerId': respons.user!.id,
        'image': image
      },
    );

    print("in the signup: ${respons.hashCode}");
    // Send email verification
    // await supabase.auth.resetPasswordForEmail(email);
  }

  // Get Customer Profile
  Future getUser() async {
    final response = await supabase
        .from('Customer')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id)
        .single();
    return ProfileModel.fromJson(response);
  }

  // Edit Customer Profile
  Future editUpdate(
      {required String name, required String email, required int phone}) async {
    await supabase.from('Customer').update(
      {
        'name': name,
        'email': email,
        'phoneNumber': phone,
      },
    ).match({'customerId': supabase.auth.currentUser!.id});
  }

  // get Followers
  Future getFollowers() async {
    final followerNumber = await supabase
        .from('office_followers')
        .select('*')
        .eq('customerId', supabase.auth.currentUser!.id);

    if (followerNumber.isNotEmpty) {
      final List<ProfileOfficeFollowModel> follower = [];
      for (var element in followerNumber) {
        follower.add(ProfileOfficeFollowModel.fromJson(element));
      }
      final List<OfficesModel> followers = [];
      for (var element in follower) {
        final follow = await supabase
            .from('Offices')
            .select('*')
            .eq('officeId', element.officeId);
        for (var element in follow) {
          followers.add(OfficesModel.fromJson(element));
        }
      }
      return followers;
    } else {
      final List<OfficesModel> followers = [];
      return followers;
    }
  }
}
