import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'models/product.dart';
import 'services/http_service.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  final HttpService httpService = HttpService();

  final String baseUrl = 'https://itpart.net/mobile/api/products.php';
  final String baseImgUrl = 'https://itpart.net/mobile/images/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('My Product List'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: httpService.fetchData(strUrl: baseUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } 
            
         
            else if (snapshot.hasError) {
              return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
            } 
            
            
            else if (snapshot.hasData && snapshot.data != null) {
              List<Product> products = snapshot.data!;
              
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: products.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final product = products[index];
                  
                  return ListTile(
                    
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '$baseImgUrl/${product.imageURL}',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
                    
                    title: Text(
                      product.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    
                    subtitle: Text(
                      product.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                         builder: (context) => DetailPage(product: product), 
                         
                        ),
                      );
                    },
                  );
                },
              );
            } 
            
            
            else {
              return const Text('ไม่พบข้อมูลสินค้า');
            }
          },
        ),
      ),
    );
  }
}