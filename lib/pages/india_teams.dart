import 'package:flutter/material.dart';
import 'package:wellnesswalkathon/data_constants/stepcount_data.dart';
import 'package:wellnesswalkathon/pages/walkthon_stats/animater_text.dart';
import 'package:wellnesswalkathon/style/text_style.dart';

class IndiaTeamsDashboard extends StatefulWidget {
  const IndiaTeamsDashboard({super.key});

  @override
  State<IndiaTeamsDashboard> createState() => _IndiaTeamsDashboardState();
}

class _IndiaTeamsDashboardState extends State<IndiaTeamsDashboard> {

  List<String> totalEmployees = [" Sheetal Shivanand Nayak ",
    " Marzban S Wadia ",
    " Suri Babu Irakam ",
    " Ashutosh Kulkarni ",
    " Babitha Krishnamurthy ",
    " Praveen AP ",
    " Santhosh D ",
    " Ajay Kumar S ",
    " Sanjana Verma  ",
    " Srinivas Murarishetty ",
    " Manjunath Chulaki ",
    " Shashi Mohan Gupta ",
    " Asha Roy ",
    " Rizvan Pathan ",
    " Emy Panickacheril ",
    " Deepak Rathi ",
    " MB Kiran Kumar ",
    " Madhavi Burra ",
    " Amit Koppalkar ",
    " Yogesh Mohan Sinha ",
    " Mohammad Feroz ",
    " Saleem Baig Mogal Akbar ",
    " Sadhvi Chandra ",
    " Saurabh Kumar ",
    " Senthil KP ",
    " Rathnapriya Ramaswamy ",
    " Rao Prashanth ",
    " Penumatsa Raju ",
    " Sandhya P ",
    " Rajeswari C ",
    " Gopi Akkineni ",
    " Satheesh Soman ",
    " Lucky Saxena ",
    " Pradeep Beerelli ",
    " Sudharsan KB ",
    " Shubhashini Shankar ",
    " Divya Chandrashekar ",
    " Iqbal Ali Mohammed ",
    " Shriram Gaitonde ",
    " Vipin Anikat ",
    " Prashanti Kanugula ",
    " Amrita Khandelwal ",
    " RamaRao Paturi ",
    " Vivek Mathur ",
    " Pavan Katikaneni ",
    " Venkata Gajula ",
    " Rakesh Jakka ",
    " Sushma Nagapuri ",
    " Hyma Penmatsa ",
    " Bibhudatta Ghadei ",
    " Amit Deshmane ",
    " Ankika Priya ",
    " Gujjala Pullaiah ",
    " Durga Devi Matta ",
    " Vidya S ",
    " Rupa Maddodi ",
    " Suresh Kumar Kasandi ",
    " Ramya A ",
    " Suraj Chavadi ",
    " Sandeep Nayak ",
    " Ayyappan Arunachalam ",
    " Rajesh Koona ",
    " Rathnakar Shetty ",
    " Mangesh Sawant ",
    " Bhargavi Gopalakrishnan ",
    " Madhuri Rao ",
    " Nandakishore Akalankam ",
    " Bala Nivedhitha Bala Subrahmanyian ",
    " Janarthanan Ramadoss ",
    " Keshava Prasad Madangallu ",
    " Atul Purushan ",
    " Sanjeev Upadhyay ",
    " Haribaskar Nanjappan ",
    " Ramakrishnan Subramanian ",
    " Samuel Uchula ",
    " Ramya M ",
    " Srinivas Yacham ",
    " Manan Aeron ",
    " Ashish Panda ",
    " AshwathReddy KS Reddy ",
    " Ramesh Soma ",
    " Nagaraja K ",
    " Bhaskar Mahabala Acharya ",
    " KVRNSN Murthy ",
    " Arvind Kumar ",
    " Yadavendra Satishkumar ",
    " Bimal Mahapatra ",
    " Manu TC ",
    " Gorantla Maheswari ",
    " Nirisha Turaga ",
    " Chaitra S ",
    " Hareesh Mamillapalli ",
    " Ravi Kumar VP ",
    " Pravin Kumar Thallapally ",
    " Kanishka Singh ",
    " Ravikumar Raju Alluri ",
    " Nagesh Patil ",
    " Rani Ponugumati ",
    " Karthik Gummadidala ",
    " POOJA K S ",
    " Manasa H S ",
    " Gopal Nuli ",
    " Gaurav Sharma ",
    " Asif Manzoor Reshi ",
    " Paritosh Mangrulkar ",
    " Arul Jothi ",
    " Vishnu Prasad ",
    " Sachidananda Shetty ",
    " Manish Vazirani ",
    " Aditya Ghosh ",
    " Lalu P J ",
    " Rajesh Poddaturi ",
    " Umesh Gowdru Channabasappa ",
    " Uday Nagpal ",
    " Mayur Koli ",
    " Gowsic S ",
    " Kiran Kesav A ",
    " Suresh Kumar T ",
    " Phanidranath Oruganti ",
    " Vipan Vipan ",
    " Vasudeva Rao Thumati ",
    " Shiv Shankar Upadhyay ",
    " Vikalp Nagar ",
    " Prasun Dixit ",
    " Sandhya Tadikonda ",
    " Kamalakar Bille ",
    " Blessy Kotrika ",
    " Vinil Kumar Peddi Peddi ",
    " Sreeharsha D M ",
    " Eswar Reddy Desam ",
    " Raju K ",
    " Gatla Sai Krishna ",
    " Deepak Maurya ",
    " Lakshmana Prasad ",
    " Manish Parlani ",
    " Priyanka Sirla ",
    " Prajyot Kataria ",
    " Sidhant Padhiary ",
    " Koustuv Ganguly ",
    " Ramesh Poshala ",
    " Gollapudi Sri Nalini ",
    " Prudhivi Kishore ",
    " Jaismeen Kaur ",
    " Abhishek Bharathkumar ",
    " Babin Shashindra Jeppu ",
    " Suman B ",
    " Surya Prakash Chirravuri ",
    " Kalyan Edulapalli ",
    " Gowrishankar Yarra ",
    " Vinay Kumar Varma Nadimpalli ",
    " Nishant Jain ",
    " Sukumar Venkatesan ",
    " Samuel Parsa ",
    " Sumukh B S ",
    " Shalini Gangrade ",
    " Rishitha Madireddy ",
    " Sreeja Bhogadi ",
    " Sparsh Kumar ",
    " Mahesh Chepuri ",
    " Manikantan Kurupatta Menatta ",
    " Chitimalla Sowmya ",
    " Suravarapu Rajesh ",
    " Abhishek Roychowdhury ",
    " Suganthi Sukumar ",
    " Sabyasachi Chakraborty ",
    " Sai Teja Bhavani ",
    " Umesh Khamkar ",
    " Eshwar Reddy ",
    " Naveen Beemanapally ",
    " Madhavi Dharanikota ",
    " Kumaraguru G ",
    " Kalyani K  ",
    " Dinesh Khandal ",
    " Shreyas Shanbhag ",
    " Sathyanarayanan Narayanan  ",
    " Gouthamraj Gaburi ",
    " Gopalkrishna Kulkarni ",
    " Rashid Anwar ",
    " Piyush Bhalerao ",
    " Sandeep Sarkar ",
    " Snehita Reddy Polaggari ",
    " Vikash Rai ",
    " Gowthami Rangasamy ",
    " Vedansh Sahu ",
    " Sakshi  ",
    " Shrirang Mohan Gombi ",
    " Rahul Jadhav ",
    " Sameer Jain  ",
    " Naresh Kumar Ankam ",
    " Tirumalesha Dadige ",
    " Manikandan Johnraj ",
    " Anurag Porel ",
    " Anvitha Namasani ",
    " Swetha Udhaya Kumar ",
    " Santosini Dwibedi ",
    " Shreya Padhi ",
    " Areeba Tanayeem ",
    " Jagadeesh Nallasani ",
    " Sowjanya Magapu ",
    " Srikanth Basetty ",
    " Vaibhav Sawant ",
    " Saidulu Mallikanti ",
    " Rajesh Bathina ",
    " Avanti Boinepalli ",
    " Anil C S Shetty ",
    " Ranganathan K S ",
    " Sriteja Sabbineni ",
    " S Swaminathan ",
    " Nidhi Mishra  ",
    " Aiman Sarin ",
    " Swathi M ",
    " Vinitha Gowrabathina ",
    " Samarth Shah ",
    " Ram Batthula ",
    " Mayank Srivastava  ",
    " Deepak Wanjare  ",
    " Soumya Ranjan Sahoo ",
    " Nagakshitha Babbula ",
    " Aashish Chandra Thakur ",
    " Ajay Babu Chigurupati ",
    " Anjali Jagavkar ",
    " Avinash Sareka ",
    " Krishna Chaitanya Madduri ",
    " Lahari Thalla ",
    " Madhavi Latha C ",
    " Naresh Pamarthi ",
    " Pavan Kumar Balusu ",
    " Pavani Palavalasa ",
    " Sravanthi Mandhala ",
    " Rini Varghese ",
    " Pradeep Gupta ",
    " Priyanka Swarnkar ",
    " Kamal Prakash Pandey ",
    " Kranti Kumar Danalakota ",
    " Pranjal Tiwari ",
    " Jigesh Vachhrajani ",
    " Laxmi Thakkannavar ",
    " Kusum ",
    " Sharanya S ",
    " Chandrashekhar P ",
    " Prathamesh Narasimha Pai ",
    " Samiksha Shukla ",
    " Karthick Madhesan ",
    " Gurkeerat Singh Kalra ",
    " Nagesh M S ",
    " Nitin Bukharia ",
    "  Sai Krishna Uppuluri ",
    "  Prasad Sistla ",
    " Gururaj B R ",
    "  Taher Kanchwala ",
    " Bhupesh Rai ",
    " Vikas Jain ",
    " Sai Abhishek Uriti  ",
    " Basavaraj Malawad ",
    " Mahesh Subbarao Ramagopal ",
    " Umapathi Naidu Gali ",
    " Vijayakumar Jabannavar ",
    " Sanjoy Paul ",
    " Shwetha Shivalingappa ",
    " Vysakh S Kumar  ",
    " Satya Manishankar ",
    " Sayak Ghorai ",
    " Samiksha  ",
    " Varanasi Dhana Sree ",
    " Vinayak Chandavar ",
    " Darshan Acharya ",
    " Bhaskar Kumar Chukka ",
    " Jothish Chandr Jannela ",
    " Shubham Chandra ",
    " Vivek Siddharth Parsa ",
    " Ruchitha Trivedi ",
    " Lalit Sharma ",
    " Vivek Patel ",
    " Chandrakant Vashisth "];

  List<String> participents = [" Ashutosh Kulkarni ",
    " Blessy Kotrika ",
    " Madhuri Rao ",
    " Manan Aeron ",
    " Manish Vazirani ",
    " Pranjal Tiwari ",
    " Sudharsan KB ",
    " Suri Irakam ",
    " Vipan Vipan ",
    " Samiksha Shukla ",
    " Koustuv Ganguly ",
    " Kishore Prudhivi ",
    " Prajyot Kataria ",
    " Preeti Surya Prakash ",
    " Prashanti Kanugula ",
    " Ramakrishnan Subramanian ",
    " Gatla Sai Krishna ",
    " Nagakshitha Babbula ",
    " Nirisha Turaga ",
    " Shalini Gangrade ",
    " Uday Nagpal ",
    " Umesh GC ",
    " Vishnu Prasad ",
    " Nidhi Mishra ",
    " Kumaraguru G ",
    " Kushal Gowda M V ",
    " Preetesh Shetty ",
    " Sai Jahnavi Pasumarthi ",
    " Samiksha Shahi ",
    " Sayak Ghorai ",
    " Deepika A Reddy ",
    " Varanasi Dhana Sree ",
    " Bhaskar Acharya ",
    " Gouthamraj Gaburi ",
    " Iqbal Ali Mohammed ",
    " Manish Parlani ",
    " Paritosh Mangrulkar ",
    " Piyush Bhalerao ",
    " Ram Babu Batthula ",
    " Sadhvi Chandra ",
    " Shubhashini Shankar ",
    " Uma Gorantla Maheswari ",
    " Venkata Gajula ",
    " Karthik Gummadidala ",
    " Pradeep Beerelli ",
    " Sanjana Verma ",
    " Saurabh Kumar ",
    " AP Praveen ",
    " Nagesh MS ",
    " Gaurav Achra ",
    " Hareesh Mamillapalli ",
    " Mayur Koli ",
    " Sabyasachi Chakraborty ",
    " Saleem Mogal Akbar ",
    " Anurag Porel ",
    " Anvitha Namasani ",
    " Deepak Wanjare ",
    " Eswar Reddy Desam ",
    " Lahari Thalla ",
    " Nagaraja K ",
    " RamaRao Paturi ",
    " Vinil Kumar Peddi Peddi ",
    " Ramya A ",
    " C.Madhavi latha ",
    " Rajesh Koona ",
    " Rathnakar Shetty ",
    " Sandhya Tadikonda ",
    " Amit Deshmane ",
    " Aiman Sarin ",
    " Areeba Tanayeem ",
    " Samarth Shah ",
    " Arvind Kumar ",
    " Chandrashekhara P ",
    " Gaurav Sharma ",
    " Madhavi Burra ",
    " Mangesh Sawant ",
    " Ravi Kumar VP ",
    " Samuel Uchula ",
    " Santhosh Kanne ",
    " Suresh Kumar Kasandi ",
    " Laxmi Thakkannavar ",
    " Rajesh Suravarapu ",
    " Saidulu Mallikanti ",
    " DS Jaya Madhavi ",
    " Rizvan Pathan ",
    " Shriram Gaitonde ",
    " Prathamesh Pai ",
    " Yadavendra ",
    " Santhosh D ",
    " Lucky Saxena ",
    " Sravanthi Mandhala ",
    " Srinivas Yacham ",
    " Hemavathi Byrappa ",
    " Swathi M ",
    " Sharanya S ",
    " Ankika Priya ",
    " Rohit Amula ",
    " Vinakaya Nirati ",
    " Rishitha Maddireddy ",
    " Kusum Kusum ",
    " Atul Kumar Joshi ",
    " Murthy Kancherla ",
    " Sumukh B S ",
    " Darshan Acharya ",
    " Suman B ",
    " Vivek Mathur ",
    " Sowmya Chitimalla ",
    " Daniya Biradar ",
    " Suresh Kumar T "];



  @override
  void initState() {
    // TODO: implement initState
    getDebutants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GE Appliances India Teams - [MARCH - JUNE] 2025 Step Count',
          style: AppTextStyles.headline.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTextStyles.primaryBlue,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Card(
                          elevation: 8,
                          color:
                              index % 2 == 0
                                  ? Colors.blue.shade200
                                  : Colors.green.shade200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SelectableText(
                                      '${data.name}', // Replace with actual data
                                      style: AppTextStyles.headline.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 22,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    AnimatedCounter(
                                      targetValue: data.members!.length.toDouble(),
                                      duration: const Duration(seconds: 2),
                                      style: AppTextStyles.headline.copyWith(
                                        color: AppTextStyles.primaryBlue,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // IconGeneratorWidget(
                                    //   iconCount: data.members!.length,
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Divider(
                                    color: Colors.black87,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // AnimatedCounter(
                                      //   targetValue: (int.tryParse(data.total.toString()) ?? 0).toDouble(),
                                      //   duration: const Duration(seconds: 2),
                                      //   style: AppTextStyles.headline.copyWith(
                                      //     color: AppTextStyles.black,
                                      //     fontSize: 55,
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // )
                                      SelectableText(
                                        AppTextStyles().formatIndianNumber(
                                          int.parse(data.total.toString()),
                                        ), // Replace with actual data
                                        style: AppTextStyles.body.copyWith(
                                          fontSize: 55,
                                          fontWeight: FontWeight.normal,
                                          color: AppTextStyles.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No data found');
                }
              },
              future: StepCountData().getTeamData(),
            ),
          ),
        ),
      ),
    );
  }

  void getDebutants() {
    List<String> debutants = [];
    for (var emp in totalEmployees) {
      if (!participents.contains(emp)) {
        debutants.add(emp);
      }
    }
    print('Total Debutants: ${debutants.length}');
    for (var debutant in debutants) {
      print(debutant);
    }
  }
}

class IconGeneratorWidget extends StatelessWidget {
  final int iconCount;

  IconGeneratorWidget({required this.iconCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(iconCount, (index) {
        return Icon(
          size: 30,
          Icons.account_circle, // Replace with any icon
          color: AppTextStyles.primaryBlue,
        );
      }),
    );
  }
}
