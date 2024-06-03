import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class MembersCounter extends StatelessWidget {
 // final String email;

  const MembersCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
              color: Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(90)
            ),child: Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
            ));
      },
    );
  }
}
class PledgesCounter extends StatelessWidget {
  // final String email;

  const PledgesCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pledges')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class UserPledgesCounter extends StatelessWidget {
   final String email;

  //const UserPledgesCounter({super.key});
   UserPledgesCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pledges')
          .where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class SongsCounter extends StatelessWidget {
  // final String email;

  const SongsCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('songs')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class TeamsCounter extends StatelessWidget {
  // final String email;

  const TeamsCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('teams')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class EventsCounter extends StatelessWidget {
  // final String email;

  const EventsCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class DevelopmentsCounter extends StatelessWidget {
  // final String email;

  const DevelopmentsCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('developments')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class PrayerCellsCounter extends StatelessWidget {
 //  final String email;

 // const PrayerCellsCounter({super.key});
  PrayerCellsCounter({super.key, });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('prayercells')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class PrayerUserCellsCounter extends StatelessWidget {
  final String email;

  // const PrayerCellsCounter({super.key});
  PrayerUserCellsCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('prayercellattendance')
      .where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class PrayerUserCellsCounterDate extends StatelessWidget {


  // const PrayerCellsCounter({super.key});
  PrayerUserCellsCounterDate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('prayercelldates')
          //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class SermonsCounter extends StatelessWidget {
  // final String email;

  const SermonsCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sermons')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class PrayerCellMembersCounter extends StatelessWidget {
   final String email;

  const PrayerCellMembersCounter({required this.email});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('prayercellmembers')
      .where('prayercellid', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}
class PastorsCounter extends StatelessWidget {
  // final String email;

  const PastorsCounter({super.key});
  //MembersCounter({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pastors')
      //.where('email', isEqualTo: email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text('');
        }
        int count = snapshot.data!.docs.length;
        return Container(
            decoration:BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(90)
            ),child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: Text('$count',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),),
        ));
      },
    );
  }
}











