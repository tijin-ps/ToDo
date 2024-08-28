import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        backgroundColor: Colors.yellow.shade700,
      ),
      body: Container(
        color: Colors.black, 
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Welcome to [TODO]!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.yellow.shade700,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Privacy Policy:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow.shade700, 
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We take your privacy seriously and are committed to protecting your personal information. Please read our privacy policy below:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.yellow.shade700, 
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
**Privacy Policy**

At [TODO APP], we take your privacy seriously and are committed to protecting your personal information. This privacy policy explains how we collect, use, and disclose your personal information when you use our website or services.

**Information We Collect**

We collect information from you when you register on our site, place an order, subscribe to our newsletter, respond to a survey, or fill out a form. We may also collect information automatically as you use our website, such as your IP address, device type, and browsing activity.

**How We Use Your Information**

We use your personal information for the following purposes:

* To provide and improve our services: We use your information to deliver the services you have requested, such as processing orders or sending newsletters. We also use your information to improve our website and services.
* To communicate with you: We may use your information to communicate with you about your account or order, or to send you promotional materials.
* To comply with legal obligations: We may use your information to comply with applicable laws, regulations, and legal processes.

**How We Share Your Information**

We may share your personal information with third parties in the following circumstances:

* Service providers: We may share your information with service providers who perform services on our behalf, such as payment processors or shipping providers.
* Business partners: We may share your information with our business partners for joint marketing and other purposes.
* Legal purposes: We may disclose your information in response to a subpoena, court order, or other legal process, or to establish or exercise our legal rights.
* Business transfers: We may share your information in connection with a merger, acquisition, or sale of all or a portion of our assets.

**Your Choices**

You have the following choices regarding your personal information:

* Access and update your information: You can access and update your personal information by logging into your account or contacting us.
* Opt out of marketing communications: You can opt out of receiving marketing communications from us by following the unsubscribe instructions included in the communication or by contacting us.
* Manage your cookie preferences: You can manage your cookie preferences by adjusting your browser settings or using our cookie consent tool.

**Security**

We take reasonable measures to protect your personal information from unauthorized access, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, so we cannot guarantee the absolute security of your information.

**Changes to this Policy**

We may update this privacy policy from time to time. If we make material changes to this policy, we will notify you by email or by posting a notice on our website prior to the effective date of the changes.

**Contact Us**

If you have any questions or concerns about this privacy policy, please contact us at [0481-3422710].
                  ''',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.yellow.shade700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
