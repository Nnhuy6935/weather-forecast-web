import 'package:email_repository/email_repository.dart';
import 'package:flutter/material.dart';
import 'package:weather_web/components/exist_email_dialog.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen>{
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late bool isLoading; 
  late EmailRepository _emailRepository;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _cityController = TextEditingController();
    isLoading = false;
    _emailRepository = EmailRepository();
  }

  void updateLoadingState(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE6F0F5),
        body: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF4169E1),
              child: const Center(
                child: Text(
                  'Register Notification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50,),
            // main content 
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   const Text(
                    'Enter your email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'E.g., New York, London, Tokyo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async{
                      if(_emailController.value.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide valid email')));
                        return;
                      }
                      if(_cityController.value.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide city')));
                        return;
                      }
                      updateLoadingState();
                      try{
                        String response = await _emailRepository.registerEmail(_emailController.value.text, _cityController.value.text);
                        if(response.contains('Email have already register')){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) => Dialog(
                              child: ExistEmailDialog(email: _emailController.value.text, emailRepository: _emailRepository,),
                            )
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response}. Please check email to verify.')));
                        }
                      }catch(error){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                      }
                      updateLoadingState();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4169E1),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: !isLoading 
                    ?const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )
                    : const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator( color:  Colors.white, strokeWidth: 2.0,),
                    ),
                  ),
                ],
              ),
              ),
            ),
          ],
        ));
  }
}
