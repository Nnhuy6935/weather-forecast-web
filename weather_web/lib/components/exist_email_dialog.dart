import 'package:email_repository/email_repository.dart';
import 'package:flutter/material.dart';

class ExistEmailDialog extends StatelessWidget{
  final String email;
  final EmailRepository emailRepository;
  const ExistEmailDialog({
    required this.email,
    required this.emailRepository,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.sizeOf(context).width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Width * 0.3
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Register Notification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16,),
            Text(
              '$email register successfully. Do you want to unsubscribe this email?'
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async{
                    try{
                      await emailRepository.unsubscribeEmail(email);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('unsubscribed $email')));
                    }catch(error){
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $error')));
                    }
                  }, 
                  child: const Text('unsubscribe'),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text('Close'),
                )
              ],
            )
          ],
        ),
      ),  
    );
  }
}