import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog_model.dart';
import '../models/user_model.dart';
import '../utils/api_endpoints.dart';
import '../utils/app_constants.dart';

class ApiService {
  String get usersUrl => '${AppConstants.baseUrl}${ApiEndpoints.users}';
  String get blogsUrl => '${AppConstants.baseUrl}${ApiEndpoints.blogs}';

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final response = await http.get(
      Uri.parse(usersUrl),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      final List<UserModel> users = data.map((item) {
        return UserModel.fromJson(item);
      }).toList();

      try {
        final UserModel user = users.firstWhere(
              (user) =>
          user.email.toLowerCase().trim() == email.toLowerCase().trim() &&
              user.password.trim() == password.trim(),
        );

        return user;
      } catch (error) {
        return null;
      }
    }

    throw Exception('Unable to login. Please try again.');
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final checkUserUri = Uri.parse(usersUrl).replace(
      queryParameters: {
        'email': email.trim(),
      },
    );

    final checkResponse = await http.get(checkUserUri);

    if (checkResponse.statusCode == 200) {
      final List<dynamic> existingUsers = jsonDecode(checkResponse.body);

      if (existingUsers.isNotEmpty) {
        throw Exception('Email already registered.');
      }
    }

    final response = await http.post(
      Uri.parse(usersUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name.trim(),
        'email': email.trim(),
        'password': password.trim(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Unable to register. Please try again.');
  }

  Future<List<BlogModel>> fetchBlogs() async {
    final response = await http.get(Uri.parse(blogsUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      final blogs = data.map((item) {
        return BlogModel.fromJson(item);
      }).toList();

      blogs.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return blogs;
    }

    throw Exception('Unable to fetch blogs.');
  }

  Future<BlogModel> addBlog({
    required String title,
    required String content,
    required String author,
  }) async {
    final response = await http.post(
      Uri.parse(blogsUrl),
      headers: {
        'Content-Type': 'application/json',
      },
        body: jsonEncode({
          'blog_name': title.trim(),
          'content': content.trim(),
          'Author_name': author.trim(),
          'createdAt': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return BlogModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Unable to add blog.');
  }

  Future<BlogModel> updateBlog({
    required String id,
    required String title,
    required String content,
    required String author,
    required DateTime createdAt,
  }) async {
    final response = await http.put(
      Uri.parse('$blogsUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
        body: jsonEncode({
          'blog_name': title.trim(),
          'content': content.trim(),
          'Author_name': author.trim(),
          'createdAt': createdAt.toIso8601String(),

      }),
    );

    if (response.statusCode == 200) {
      return BlogModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Unable to update blog.');
  }

  Future<void> deleteBlog(String id) async {
    final response = await http.delete(
      Uri.parse('$blogsUrl/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    }

    throw Exception('Unable to delete blog.');
  }
}