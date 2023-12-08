import 'package:flutter/material.dart';
import 'package:holopop/shared/widgets/standard_header.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StandardHeader(headerTitle: "Privacy Policy"),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text("""
This privacy policy is intended to provide information to users of Holopop's websites, and users of the services provided by Holopop, about how Holopop uses, stores, and protects information associated with such users. By using any of the websites or services of Holopop, you represent and warrant that you have read and understood this privacy policy, and agree to its terms.
 
Effective Date Of Policy
 
The effective date of this privacy policy is 09/01/2023. Holopop reserves the right, at any time and without notice, to add to, update, change, or modify this privacy policy by posting a new version on this page.
 
Information Collected By Holopop
 
When you access Holopop websites, Holopop automatically gathers information that most web browsers automatically make available. This information may include IP addresses, Internet domain names, and types of devices and web browsers accessing Holopop websites. Such information is anonymous and is not meant to personally identify you.
 
Holopop websites also use cookies, which are files that are placed on your computer when you visit Holopop websites. The purpose of cookies includes identifying you as a unique user of Holopop websites and services, tailoring your experience on Holopop websites, and enabling third-parties (such as Google) to optimize and serve advertisements to you.
 
If you do not wish to have cookies placed on your computer, you have several options, including: (a) not accessing Holopop websites or using Holopop services; (b) setting your web browser to refuse cookies; and (c) opting out of or customizing the use of third-party cookies through various websites operated by such third parties or by others (i.e., Google, Facebook, and Network Advertising Initiative). Please note that blocking or customizing the use of cookies may affect your experience on Holopop websites or with Holopop services.
 
If you decide to use certain features of Holopop websites or services (such as submitting an inquiry or ordering a product or service), you will be asked to provide certain personally identifiable information, which can include your name, phone number, email address, mailing address, credit/debit card number and expiration date, and social security number. You are under no obligation to provide such information, but refusing to do so may prevent your ability to use certain features of Holopop websites or services.
 
How Holopop Uses The Information It Collects
 
With respect to non-personally identifiable information automatically collected from you when you access Holopop websites and information gathered through the use of cookies, Holopop uses such information to: (1) help diagnose problems with our server and administer our websites; (2) track the usage of our websites so we can better understand who is using our websites and services and how they are using them; and (3) share with advertisers to help them better understand our services and the preferences of our customers.
 
Holopop may combine certain demographic information obtained from you when you use certain features of Holopop websites or services (such as submitting an inquiry, registering or ordering a product or service) with site usage data to provide profiles, in aggregate form, about our users and their preferences. The aggregate, composite information may be shared with our advertisers.
 
The personally identifiable information you voluntarily provide to Holopop when you decide to use certain features of Holopop websites or services (such as submitting an inquiry, registering or ordering a product or service) may be used for the following purposes: (1) contacting you regarding Holopop's products or services, including those which you have ordered or requested; (2) billing you for the products or services your ordered or requested; (3) providing the information to third parties such as shipping companies, merchant account and payment gateway service providers, governmental entities, and our product and service distributors to the extent necessary to provide the products and services that you order or request; (4) providing the information to those who assist Holopop with providing its products and services; (5) providing the information when required to do so by law or if necessary to protect the property or rights of Holopop, third parties, or the public; (6) providing the information to a successor of Holopop in the event of a merger, acquisition, bankruptcy, or sale of Holopop's assets; (7) providing the information to consumer credit reporting services, collection agencies, attorneys, and others in the event you fail to pay any amounts owed to Holopop; and (8) providing the information to advertisers or other third parties if we determine, in our sole discretion, that you would be interested in the products or services offered by such advertisers or third parties.
 
Security Of Information Provided To Holopop
 
Holopop takes security seriously and uses commercially reasonable safeguards to protect against the unauthorized access, use, modification, destruction or disclosure of any information you provide to us. However, Holopop cannot guarantee that any information provided to us or obtained by us will not be accessed, hacked, disclosed, altered, or destroyed by unauthorized parties.
 
Children's Privacy
 
Holopop does not solicit or knowingly collect personal information from minors. If Holopop obtains actual knowledge that it has collected personal information from a minor, we will delete such information from our database. Because Holopop does not collect personal information from minors, we have no such information to use or disclose to third parties.
 
Parents of minors of any age may contact our Privacy Coordinator at the mailing address or e-mail address indicated below in order to: (1) access personally identifiable information Holopop has collected from their child; (2) correct or modify such information; (3) request to have such information deleted; and (4) request that we no longer collect or maintain such information.
 
How To Request Changes To The Personally Identifiable Information We Collect
 
You can review and request changes to the personally identifiable information that Holopop has collected from you by contacting our Privacy Coordinator at the mailing address or e-mail address indicated below.
 
Do-Not-Track Disclosure
 
Holopop does not respond to "Do Not Track" signals sent by browsers.
 
Consent To Receive Communications
 
By providing your name, email, mailing address, and/or phone number to Holopop, you consent to receive electronic and other communications from Holopop. You may opt out of receiving electronic communications at any time by: (a) following the unsubscribe instructions contained in each communication; or (b) by contacting our Privacy Coordinator at the mailing address or e-mail address indicated below.
 
Third-Party Websites
 
Holopop is not responsible for the content of websites operated by third parties to which it may provide links on Holopop's websites or for the websites of advertisers. Such third parties and advertisers may also have privacy policies that are different from this privacy policy. Therefore, you should inform yourself of the privacy policies and practices of any websites of third parties or advertisers.
 
Contacting Us
 
If you have any questions about this privacy policy, Holopop websites, or Holopop products and services, please contact our Privacy Coordinator at the mailing address or e-mail address indicated below:
 
Holopop
Attn: Privacy Coordinator
P.O. Box 5143
Virginia Beach, VA 23471
support@holopop.cards"""
              )
            )
          )
        )
      ],
    );
  }

}