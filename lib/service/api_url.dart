class ApiUrl{

  static const baseUrl= "http://103.161.9.133:3030";

  //===================== Auth ====================

  static const login= "/user/login";
  static const signUp= "/user/register";
  static const varifyOTP= "/user/activate-user";

//===================== Home ====================
  static const getTask= "/task/get-all-task";
  static const createTask= " /task/create-task";

  //===================== Profile ====================
  static const getProfile= "/user/my-profile";
  static const editProfile= "/user/update-profile";



}