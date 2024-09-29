import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> searchForImages(String searchTerm) async {
  // Replace with your Pixabay API key
  const pixabayApiKey = 'YOUR_PIXABAY_API_KEY'; // Replace with your actual key

  final url = Uri.parse(
      'https://pixabay.com/api/?key=$pixabayApiKey&q=$searchTerm&image_type=photo&per_page=20');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final imageUrls = data['hits'].map<String>((hit) => hit['webformatURL']).toList();
      return imageUrls;
    } else {
      throw Exception('Failed to fetch images from Pixabay (status code: ${response.statusCode})');
    }
  } catch (error) {
    throw Exception('Error fetching images: $error');
  }
}