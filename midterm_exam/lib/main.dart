import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MaterialApp(
      title: "Midterm Proj",
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ));

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SafeArea(
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/landPageBG.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "kcal",
                        style: TextStyle(
                          fontSize: 70.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "ZUAMICA",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      )
    );
  }
}


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildpageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: isActive ? 12.0 : 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.redAccent : Colors.redAccent[100],
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => print("skip"),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 520.0,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      buildForOnboardScreen(
                          imageAddress: "assets/healthy.png",
                          textTitle: "Eat Healthy",
                          description:
                              "Maintaining good health should be the primary focus of everyone."),
                      buildForOnboardScreen(
                          imageAddress: "assets/cook.png",
                          textTitle: "Healthy Recipe",
                          description:
                              "Browse thousands of healthy recipes from all over the world."),
                      buildForOnboardScreen(
                          imageAddress: "assets/track.png",
                          textTitle: "Track Your Health",
                          description:
                              "With amzing inbuilt tools you can track your progress."),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildpageIndicator(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBar(),
                            ));
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 20.0)
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[300],
                        minimumSize: const Size(300.0, 60.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Already Have An Account? "),
            Text("Log In", style: TextStyle(color: Colors.green),)
          ],
        ),
      ),
    );
  }
}

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class FavoriteContent {
  String imageAddress;
  String title;
  FavoriteDetail favoriteDetail;

  FavoriteContent(
      {required this.imageAddress,
      required this.title,
      required this.favoriteDetail});
}

class FavoriteDetail {
  String imageAddress;
  String title;
  String altName;
  List<String> description;
  List<String> detailImageAddresses;

  FavoriteDetail(
      {required this.imageAddress,
      required this.title,
      required this.altName,
      required this.description,
      required this.detailImageAddresses});
}

class RecipeContent {
  String imageAddress;
  String time;
  String numOfServing;
  String foodName;
  String shortDescription;
  RecipeDetail recipeDetail;

  RecipeContent(
      {required this.imageAddress,
      required this.time,
      required this.numOfServing,
      required this.foodName,
      required this.shortDescription,
      required this.recipeDetail});
}

class RecipeDetail {
  String description;
  List<String> directions;
  List<RecipeIngredients> recipeIngredients;

  RecipeDetail(
      {required this.description,
      required this.directions,
      required this.recipeIngredients});
}

class RecipeIngredients {
  String imageAddresses;
  String name;
  String amount;

  RecipeIngredients(
      {required this.imageAddresses, required this.name, required this.amount});
}

class _FavoritesState extends State<Favorites> {
  int _isFoodSelected = 1;
  List<FavoriteContent> favoriteList = [
    FavoriteContent(
      imageAddress: "assets/cookie.png",
      title: "Cookie",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/cookie.png",
          title: "Cookie",
          altName: "Biscuit",
          description: [
            "A cookie is a baked or cooked food that is typically small, flat and sweet. It usually contains flour, sugar, egg, and some type of oil, fat, or butter. It may include other ingredients such as raisins, oats, chocolate chips, nuts, etc.",
            "In most English-speaking countries except for the United States, cruncy cookies are called biscuits. Many Canadians also use this term. Chewier biscuits are sometimes called cookies even in the United Kingdom.[3]Some cookies may also be named by their shape, such as date squares or bars.",
          ],
          detailImageAddresses: [
            "assets/cookiedetail1.jpg",
            "assets/cookiedetail2.jpg"
          ]),
    ),
    FavoriteContent(
      imageAddress: "assets/burger.png",
      title: "Burger",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/burger.png",
          title: "Burger",
          altName: "Hamburger",
          description: [
            "Faucibus a pellentesque sit amet porttitor eget. Morbi tristique senectus et netus et. Scelerisque fermentum dui faucibus in ornare quam viverra orci sagittis. Tincidunt arcu non sodales neque sodales. Massa tincidunt dui ut ornare lectus sit amet est. Et netus et malesuada fames. In hac habitasse platea dictumst quisque sagittis purus sit amet. Nisi quis eleifend quam adipiscing vitae proin sagittis. Congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque. Euismod in pellentesque massa placerat duis ultricies lacus. Enim nulla aliquet porttitor lacus. Tincidunt vitae semper quis lectus. Duis ultricies lacus sed turpis tincidunt id aliquet risus. Nibh tellus molestie nunc non blandit massa. Ipsum dolor sit amet consectetur adipiscing elit. Ornare arcu odio ut sem nulla pharetra diam sit. Hendrerit dolor magna eget est lorem. Luctus accumsan tortor posuere ac ut consequat semper. Integer eget aliquet nibh praesent. In metus vulputate eu scelerisque felis imperdiet proin.",
            "Id nibh tortor id aliquet lectus proin nibh nisl. In hac habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc consequat. Adipiscing commodo elit at imperdiet. Scelerisque felis imperdiet proin fermentum leo. Mauris cursus mattis molestie a iaculis at erat pellentesque adipiscing. Suspendisse sed nisi lacus sed viverra. Dui accumsan sit amet nulla facilisi morbi tempus iaculis urna. Proin libero nunc consequat interdum. Ultrices eros in cursus turpis massa tincidunt dui ut ornare.",
          ],
          detailImageAddresses: [
            "assets/burgerdetail1.jpg",
            "assets/burgerdetail2.jpg",
            "assets/burgerdetail3.jpg",
          ]),
    ),
    FavoriteContent(
      imageAddress: "assets/cupcake.png",
      title: "Cakes",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/cupcake.png",
          title: "Cakes",
          altName: "Fondant",
          description: [
            "A cake is a sweet food made by baking a mixture of flour, eggs, sugar, and fat in an oven. Cakes may be large and cut into slices or small and intended for one person only.",
            "According to the food historians, the ancient Egyptians were the first culture to show evidence of advanced baking skills. The Oxford English Dictionary traces the English word cake back to the 13th century. It is a derivation of 'kaka', an Old Norse word. Medieval European bakers often made fruitcakes and gingerbread.",
          ],
          detailImageAddresses: [
            "assets/cakedetail1.png",
            "assets/cakedetail2.png",
            "assets/cakedetail3.png",
            "assets/cakedetail4.png",
            "assets/cakedetail5.png",
          ]),
    ),
    FavoriteContent(
      imageAddress: "assets/pizza.png",
      title: "Pizza",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/pizza.png",
          title: "Pizza",
          altName: "Pie",
          description: [
            "pizza, dish of Italian origin consisting of a flattened disk of bread dough topped with some combination of olive oil, oregano, tomato, olives, mozzarella or other cheese, and many other ingredients, baked quickly—usually, in a commercial setting, using a wood-fired oven heated to a very high temperature—and served hot.",
            "One of the simplest and most traditional pizzas is the Margherita, which is topped with tomatoes or tomato sauce, mozzarella, and basil. Popular legend relates that it was named for Queen Margherita, wife of Umberto I, who was said to have liked its mild fresh flavour and to have also noted that its topping colours—green, white, and red—were those of the Italian flag.",
            "Italy has many variations of pizza. The Neapolitan pizza, or Naples-style pizza, is made specifically with buffalo mozzarella (produced from the milk of Italian Mediterranean buffalo) or fior di latte (mozzarella produced from the milk of prized Agerolese cows) and with San Marzano tomatoes or pomodorino vesuviano (a variety of grape tomato grown in Naples). Roman pizza often omits tomatoes (an early 16th-century import) and uses onions and olives. The Ligurian pizza resembles the pissaladière of Provence in France, adding anchovies to olives and onions. Pizza has also spread from Italy throughout much of the rest of the world, and, in regions outside of Italy, the toppings used vary with the ingredients available and the flavour profile preferred.",
          ],
          detailImageAddresses: [
            "assets/pizzadetail1.png",
            "assets/pizzadetail2.png",
            "assets/pizzadetail3.png",
          ]),
    ),
    FavoriteContent(
      imageAddress: "assets/hotdog.png",
      title: "Hotdog",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/hotdog.png",
          title: "Hotdog",
          altName: "Footlong",
          description: [
            "A hot dog (less commonly spelled hotdog) is a dish consisting of a grilled or steamed sausage served in the slit of a partially sliced bun. The term hot dog can also refer to the sausage itself. The sausage used is a wiener (Vienna sausage) or a frankfurter (Frankfurter Würstchen, also just called frank).",
            "But references to dachshund sausages and ultimately hot dogs can be traced to German immigrants in the 1800s. German immigrants brought not only the sausage with them in the late 1800s, but also dachshund dogs. Kraig says the name hot dog probably began as a joke about the Germans' small, long, thin dogs.",
          ],
          detailImageAddresses: [
            "assets/hotdogdetail1.png",
            "assets/hotdogdetail2.png",
            "assets/hotdogdetail3.png",
            "assets/hotdogdetail4.png",
          ]),
    ),
    FavoriteContent(
      imageAddress: "assets/fries.png",
      title: "Fries",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/fries.png",
          title: "Fries",
          altName: "Chips",
          description: [
            "A thin strip of potato, usually cut 3 to 4 inches in length and about 1/4 to 3/8 inches square that are deep fried until they are golden brown and crisp textured on the outside while remaining white and soft on the inside.",
            "Some claim that fries originated in Belgium, where villagers along the River Meuse traditionally ate fried fish. ... It's said that this dish was discovered by American soldiers in Belgium during World War I and, since the dominant language of southern Belgium is French, they dubbed the tasty potatoes “French” fries.",
          ],
          detailImageAddresses: [
            "assets/friesdetails1.png",
            "assets/friesdetails2.png",
            "assets/friesdetails3.png",
            "assets/friesdetails4.png",
          ]),
    ),
    FavoriteContent(
      imageAddress: "assets/donut.png",
      title: "Donut",
      favoriteDetail: FavoriteDetail(
          imageAddress: "assets/donut.png",
          title: "Donut",
          altName: "Oily Cakes",
          description: [
            "a small cake of sweetened or, sometimes, unsweetened dough fried in deep fat, typically shaped like a ring or, when prepared with a filling, a ball.",
            "Hanson Gregory, an American, claimed to have invented the ring-shaped doughnut in 1847 aboard a lime-trading ship when he was 16 years old. Gregory was dissatisfied with the greasiness of doughnuts twisted into various shapes and with the raw center of regular doughnuts.",
          ],
          detailImageAddresses: [
            "assets/donutdetails1.png",
            "assets/donutdetails2.png",
            "assets/donutdetails3.png",
            "assets/donutdetails4.png",
          ]),
    ),
  ];
  List<RecipeContent> recipeList = [
    RecipeContent(
      imageAddress: "assets/fishSteakWithVeggies.jpeg",
      time: "55",
      numOfServing: "3",
      foodName: "Fish Steaks With Veggie Sauce",
      shortDescription:
          "Boneless with stakes with crispy fried sauce and toppings",
      recipeDetail: RecipeDetail(
        description:
            "Grilled Fish Steak is a delicious Mediterranean recipe made by marinating fish fillets in garlic, green chillies and a blend of spices. Tender fish fillets smeared in a simple marinade of lime juice and salt, seared golden. Delicious isn't it?",
        directions: [
          "To prepare this amazing non-vegetarian recipe, take the fish fillets and massage it gently with oil, keep aside in a plate",
          "Grind together the garlic, turmetic powder, red chilli powder, and salt. Add oil to it and grind to form a paste. Rub this all over the fish fillets and keep aside to marinate for 15 to 30 minutes.",
          "Grill the marinated fish on a preheated grill or oven till golden and crisp on both sides or for 5 minutes. Transfer to a plate."
        ],
        recipeIngredients: [
          RecipeIngredients(
            imageAddresses: "assets/fish.png",
            name: "Fish",
            amount: "250mg",
          ),
          RecipeIngredients(
            imageAddresses: "assets/lemon.png",
            name: "Lemon Juice",
            amount: "3 tbsp",
          ),
          RecipeIngredients(
            imageAddresses: "assets/cabbage.png",
            name: "Cabbage",
            amount: "50mg",
          ),
          RecipeIngredients(
            imageAddresses: "assets/greenchillies.png",
            name: "Green Chillies",
            amount: "3 pieces",
          ),
          RecipeIngredients(
            imageAddresses: "assets/fish.png",
            name: "Fish",
            amount: "250mg",
          ),
          RecipeIngredients(
            imageAddresses: "assets/lemon.png",
            name: "Lemon Juice",
            amount: "3 tbsp",
          ),
          RecipeIngredients(
            imageAddresses: "assets/cabbage.png",
            name: "Cabbage",
            amount: "50mg",
          ),
          RecipeIngredients(
            imageAddresses: "assets/greenchillies.png",
            name: "Green Chillies",
            amount: "3 pieces",
          ),
        ],
      ),
    ),
    RecipeContent(
        imageAddress: "assets/chocolambveggies.jpg",
        time: "25",
        numOfServing: "1",
        foodName: "Choco Lamb Veggies",
        shortDescription:
            "Deeply fried lamb meat with choco dips and fresh vegetables.",
        recipeDetail: RecipeDetail(
            description:
                "This amazingly decadent chocolate lamb chili is made with chopped lamb stew meat, a mix of beans and smoky spices. The flavor is a bit reminiscent of Mexican mole sauce making this lamb chili recipe one of kind!",
            directions: [
              "season the lamb meat generously with Kosher salt and pepper.",
              "Heat some ghee or olive oil in a large pot or Dutch oven over medium-high heat. Add the lamb to the pot and cook until browned on all sides.",
              "Remove the lamb to a plate with a slotted spoon and drain the excess liquid left in the pot.",
              "Return the pot to the stove and add some more ghee or olive oil. Add the onions and garlic and sauté for about 5 minutes until softened.",
              "Add the spices, bay leaf, cocoa powder and tomato paste, stir until well combined and cook for a minute until fragrant.",
              "Return the browned lamb to the pot and stir until combined.",
              "Add the diced tomatoes and broth. Stir everything together and bring the mixture to a simmer over high heat.",
              "Once simmering, cover the pot with a lid leaving it slightly askew, reduce the heat to medium-low and cook for 30 minutes.",
              "After 30 minutes, remove the lid, add the beans and the chopped chocolate. Stir to combine and cook for 5 more minutes.",
              "Garnish the chili with chopped fresh cilantro, sliced jalapeños if you like heat, sliced green onions and/or some ripe avocado slices before serving.",
            ],
            recipeIngredients: [
              RecipeIngredients(
                  imageAddresses: "assets/americanlamb.png",
                  name: "American Lamb",
                  amount: "1/4kg"),
              RecipeIngredients(
                imageAddresses: "assets/onion.png",
                name: "Onion",
                amount: "1 medium",
              ),
              RecipeIngredients(
                imageAddresses: "assets/garlic.png",
                name: "Garlic",
                amount: "3 cloves",
              ),
              RecipeIngredients(
                imageAddresses: "assets/cocoapowder.png",
                name: "Cocoa Powder",
                amount: "2tbsp",
              ),
              RecipeIngredients(
                imageAddresses: "assets/spices.png",
                name: "Spices",
                amount: "1/2 tsp",
              ),
              RecipeIngredients(
                imageAddresses: "assets/tomatopaste.png",
                name: "Tomato Paste",
                amount: "2 tbsp",
              ),
              RecipeIngredients(
                imageAddresses: "assets/dicedtomato.png",
                name: "Diced Tomato",
                amount: "28 oz",
              ),
              RecipeIngredients(
                imageAddresses: "assets/chocolate.png",
                name: "Chocolate",
                amount: "2 oz",
              ),
            ])),
    RecipeContent(
      imageAddress: "assets/muttonkebabnuggets.jpeg",
      time: "45",
      numOfServing: "5",
      foodName: "Mutton Kebab Nuggets",
      shortDescription: "Cruncy mutton kebabs with chilli toppings and sauce.",
      recipeDetail: RecipeDetail(
          description:
              "Kababs originated from the Middle Eastern Cuisine and are a popular food through out the world. Traditionally kabab or kebab were chunks of meat grilled over charcoal fire. But in the modern days, thesea re also grilled in ovens and even fried.",
          directions: [
            "Drain any excess moisture from the keema before proceeding. Place it in a bowl. Please use finely minced keema as we don't process it further",
            "Add flour and bread crumbs. You can also skip flour and just use bread crumbs.",
            "Sprinikle salt, garam masala and corian powder.",
            "Add onions, mint, coriander and green chilies.",
            "Next squeeze in the lemon juice",
            "Add ginger garlic paste",
            "Mix everythign together. The mixture has to be firm and not soggy other wise the kababs will break while grilling or frying",
            "Divide the mixture to 12 parts and flatten them. You don't need to grease your hands",
            "Heat oil in a pan. When it is hot, drop them and deep fry",
            "Flip them and fry until golden. Half way through you will need to fry on a medium flame.",
            "Fry them until golden crisp",
            "Remove to a kitchen tissue.",
            "Serve mutton kabab with miont chutney or as a side in your meal.",
          ],
          recipeIngredients: [
            RecipeIngredients(
                imageAddresses: "assets/mutton.png",
                name: "Mutton",
                amount: "400g"),
            RecipeIngredients(
                imageAddresses: "assets/onion.png",
                name: "Onion",
                amount: "1 Medium"),
            RecipeIngredients(
                imageAddresses: "assets/breadcrumbs.png",
                name: "Bread Crumbs",
                amount: "1/2 cup"),
            RecipeIngredients(
              imageAddresses: "assets/corianderpowder.png",
              name: "Coriander Powder",
              amount: "1 tsp",
            ),
            RecipeIngredients(
              imageAddresses: "assets/mintleaves.png",
              name: "Mint Leaves",
              amount: "1/2 cup",
            ),
            RecipeIngredients(
              imageAddresses: "assets/greenchillies.png",
              name: "Green Chillies",
              amount: "1 or 2",
            ),
            RecipeIngredients(
              imageAddresses: "assets/salt.png",
              name: "salt",
              amount: "3/4 tsp",
            ),
            RecipeIngredients(
              imageAddresses: "assets/gingergarlicpaste.png",
              name: "Gigner Garlic Paste",
              amount: "1 1/2 tbsp",
            ),
            RecipeIngredients(
              imageAddresses: "assets/lemonjuice.png",
              name: "Lemon Juice",
              amount: "2 tbsp",
            ),
          ]),
    ),
    RecipeContent(
      imageAddress: "assets/chickenlegpiece.jpg",
      time: "25",
      numOfServing: "2",
      foodName: "Chicken Leg Piece",
      shortDescription:
          "Crispy chicken leg pieces with side veggies and sauce.",
      recipeDetail: RecipeDetail(
          description:
              "A chicken leg comes from the leg of the chicken, all the way from claw to what would be the animal's hip. It comes in two parts — the drumstick and the thigh — either attached together or as separate cuts (called a leg quarter). Like the wing, this part of the bird gets a lot of exercise in comparison to other muscles, which is why chicken legs have darker meat. This also means a bit more fat, an addition that adds to the leg's flavor and juiciness.",
          directions: [
            "Prepare the vegetables : Finely chop the onion, slice the carrots into thin rounds (3-4 mm thick), cut the mushrooms into quarters. Pour the wine into a small bowl then soak the raisins. Set aside.",
            "Heat the oil in a pan over medium heat, then add the chicken drumsticks and sauté thoroughly on each side until golden, about 7-8 min. Take the chicken pieces out of the pan then set them aside on the warmed serving plate in the oven.",
            "Add the onion to the pan, then sauté 2-3 min. Add the carrots and mushrooms then cook 2-3 min. Add the raisins and wine. Scrape the bottom of the pan thoroughly as the wine comes to a boil.",
            "Put the chicken back into the pan, then add the diced tomatoes and herbes de Provence. Season with salt and pepper to taste. Cover, then simmer 20-25 min until the chicken is tender. Serve.",
          ],
          recipeIngredients: [
            RecipeIngredients(
                imageAddresses: "assets/onion.png", name: "Onion", amount: "1"),
            RecipeIngredients(
                imageAddresses: "assets/carrots.png",
                name: "Carrots",
                amount: "2 pcs"),
            RecipeIngredients(
                imageAddresses: "assets/buttonmushroom.png",
                name: "Button Mushrooms",
                amount: "8 pcs"),
            RecipeIngredients(
                imageAddresses: "assets/whitewine.png",
                name: "White Wine",
                amount: "1/2 cup"),
            RecipeIngredients(
                imageAddresses: "assets/raisins.png",
                name: "Raisins",
                amount: "3 tbsp"),
            RecipeIngredients(
                imageAddresses: "assets/canolaoil.png",
                name: "Canola Oil",
                amount: "2 tbsp"),
            RecipeIngredients(
                imageAddresses: "assets/drumstick.png",
                name: "Drumstick",
                amount: "8 pcs"),
            RecipeIngredients(
                imageAddresses: "assets/cannedtomatodice.png",
                name: "Canned Tomatoes",
                amount: "1 1/2 cup"),
            RecipeIngredients(
                imageAddresses: "assets/herbesdeprovence.png",
                name: "Herbes de Provence",
                amount: "2 tsp"),
            RecipeIngredients(
                imageAddresses: "assets/salt.png",
                name: "Salt",
                amount: "1 pinch"),
          ]),
    ),
    RecipeContent(
      imageAddress: "assets/fruitveggiemix.jpg",
      time: "15",
      numOfServing: "1",
      foodName: "Fruit Veggie Mix With Meat",
      shortDescription:
          "Crunchy deep fried meat mixed with fruits and vegetables.",
      recipeDetail: RecipeDetail(
          description:
              "Chop Suey which literally means “assorted pieces” is a stir-fry dish popular in Chinese cooking. It traditionally includes bite-sized meat such as pork, chicken, or shrimp. and assorted vegetables such as celery, broccoli, carrots, or cabbage flash-cooked in a starch-thickened sauce.",
          directions: [
            "Fill a bowl halfway with ice and enough water to cover ice. Add 1/2 teaspoon salt for each quart of water. Set aside.",
            "In a saucepan over medium heat, bring 3 cups of salted water to a boil. Add carrots and cook for about 1 minute or until half done. With a slotted spoon, remove from pan and plunge into bowl of ice bath. ",
            "Add broccoli and cauliflower to the boiling water and cook for about 2 to 3 minutes or until half-done. With a slotted spoon, remove from pan and plunge into the ice bath.",
            "Add cabbage to the boiling water and cook for about 30 seconds or until half-done. With a slotted spoon, remove from pan and plunge into the ice bath.",
            "Add peppers to the boiling water and cook for about 30 seconds or until half-done. With a slotted spoon, remove from pan and plunge into the ice bath",
            "Reserve 2 cups of the poaching liquid (the one used to blanch vegetables).",
            "Drain vegetables from the ice bath when they are cold.",
            "In a wok or wide skillet over medium heat, heat about 2 tablespoons of the oil.",
            "Add chicken liver in a single layer and fry until lightly browned on all sides but not fully cooked. Remove from pan and keep warm.",
            "Discard excess oil and wipe down the pan. Add the remaining 1 tablespoon of oil and heat.",
            "Add onions and garlic and cook until softened.",
            "Add chicken and cook, stirring regularly, until color changes.",
            "In a bowl, combine the reserved poaching liquid and oyster sauce. Add to the pan and bring to a boil. Continue to cook, skimming scum that may float on top, for about 4 to 5 minutes or until chicken is cooked through.",
            "Add the liver and cook for 1 to 2 minutes.",
            "Add parboiled vegetables, baby corn, and quail eggs, stirring gently to combine, and cook for about 3 to 5 minutes.",
            "In a bowl, combine 1/4 cup of cold water and corn starch and stir until corn starch is dissolved. Add mixture to the pan, stirring gently. Cook for about 1 to 2 minutes or until sauce is thickened.",
            " Season with salt and pepper to taste. Serve hot.",
          ],
          recipeIngredients: [
            RecipeIngredients(
                imageAddresses: "assets/carrots.png",
                name: "Carrot",
                amount: "1"),
            RecipeIngredients(
                imageAddresses: "assets/broccoli.png",
                name: "Broccoli",
                amount: "1/2"),
            RecipeIngredients(
                imageAddresses: "assets/cauliflower.png",
                name: "Cauliflower",
                amount: "1/2"),
            RecipeIngredients(
                imageAddresses: "assets/cabbage.png",
                name: "Cabbage",
                amount: "1/2"),
            RecipeIngredients(
                imageAddresses: "assets/redbellpepper.png",
                name: "Red Bell Pepper",
                amount: "1/2"),
            RecipeIngredients(
                imageAddresses: "assets/canolaoil.png",
                name: "Canola Oil",
                amount: "3 tbsp"),
            RecipeIngredients(
                imageAddresses: "assets/chickenliver.png",
                name: "Chicken Liver",
                amount: "1/2 cup"),
            RecipeIngredients(
                imageAddresses: "assets/onion.png", name: "Onion", amount: "1"),
            RecipeIngredients(
                imageAddresses: "assets/garlic.png",
                name: "Garlic",
                amount: "2 cloves"),
            RecipeIngredients(
                imageAddresses: "assets/mutton.png",
                name: "Chicken Thigh",
                amount: "2"),
            RecipeIngredients(
                imageAddresses: "assets/oystersauce.png",
                name: "Oyster Sauce",
                amount: "2 tbsp"),
            RecipeIngredients(
                imageAddresses: "assets/babycorn.png",
                name: "Baby Corn",
                amount: "5 pcs"),
            RecipeIngredients(
                imageAddresses: "assets/quailegg.png",
                name: "Quail Egg",
                amount: "6 pcs"),
            RecipeIngredients(
                imageAddresses: "assets/water.png",
                name: "Water",
                amount: "1/4 cup"),
            RecipeIngredients(
                imageAddresses: "assets/cornstarch.png",
                name: "Corn starch",
                amount: "1 tbsp"),
            RecipeIngredients(
                imageAddresses: "assets/salt.png",
                name: "Salt",
                amount: "1 pinch"),
          ]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isFoodSelected = 1;
                  });
                },
                child: _isFoodSelected == 1
                    ? buildSelection(
                        theColor: Colors.green.shade300,
                        theText: "Food",
                        placement: "left",
                        textColor: Colors.grey.shade50)
                    : buildSelection(
                        theColor: Colors.green.shade50,
                        theText: "Food",
                        placement: "left",
                        textColor: Colors.green.shade300),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isFoodSelected = 0;
                  });
                },
                child: _isFoodSelected == 1
                    ? buildSelection(
                        theColor: Colors.green.shade50,
                        theText: "Recipe",
                        placement: "right",
                        textColor: Colors.green.shade300)
                    : buildSelection(
                        theColor: Colors.green.shade300,
                        theText: "Recipe",
                        placement: "right",
                        textColor: Colors.grey.shade50,
                      ),
              )
            ],
          ),
          SizedBox(
            height: 580,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              //child: _isFoodSelected == 1 ? buildFoodGridView(favoriteList: favoriteList, theContext: context) : buildRecipeListView(recipeList: recipeList, theContext: context),
              child: _isFoodSelected == 1
                  ? (favoriteList.isNotEmpty
                      ? buildFoodGridView(
                          favoriteList: favoriteList, theContext: context)
                      : buildEmpty(theText: "food"))
                  : (recipeList.isNotEmpty
                      ? buildRecipeListView(
                          recipeList: recipeList, theContext: context)
                      : buildEmpty(theText: "recipe")),
            ),
          ),
        ],
      ),
      //body: _isFoodSelected == 1 ? buildFoodGridView(favoriteList: favoriteList) : buildEmpty(theText: "Food is not Selected"),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const Center(
      child: Text(
        'Home',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Search',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Camera',
        style: optionStyle,
      ),
    ),
    const Favorites(),
    const Center(
      child: Text(
        'Profile',
        style: optionStyle,
      ),
    ),
  ];

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _currentPage = "Home";
      } else if (index == 1) {
        _currentPage = "Search";
      } else if (index == 2) {
        _currentPage = "Camera";
      } else if (index == 3) {
        _currentPage = "Favorites";
      } else {
        _currentPage = "Settings";
      }
    });
  }

  String _currentPage = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPage,
            style: const TextStyle(
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[50],
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade300,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                )),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
              label: 'Favorites'),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTappedItem,
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key, required this.favoriteDetail})
      : super(key: key);

  final FavoriteDetail favoriteDetail;
  static const TextStyle descriptionStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
    wordSpacing: 4.0,
    height: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text(
          "Foods",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 12, bottom: 12, right: 12),
        child: ListView(
          children: [
            Column(
              children: [
                buildDetailHeader(favoriteDetail: favoriteDetail),
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 10, right: 5),
                  child: Column(
                    children: favoriteDetail.description
                        .map(
                          (e) => Column(
                            children: [
                              Text(e, style: descriptionStyle),
                              const SizedBox(
                                height: 20.0,
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Gallery",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                    height: 300,
                    child: buildDetailedImageGallery(
                        favoriteDetail: favoriteDetail)),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 60,
        width: 275,
        child: FloatingActionButton(
          backgroundColor: Colors.red[300],
          child: const Text(
            "Add to Favorite",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {},
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }
}

class RecipeDetailedScreen extends StatelessWidget {
  const RecipeDetailedScreen({Key? key, required this.recipeContent})
      : super(key: key);

  final RecipeContent recipeContent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.black87),
                ),
                title: const Text(
                  "Recipes",
                  style: TextStyle(color: Colors.black, fontSize: 17.0),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.grey[50]),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Image(
                  image: AssetImage(recipeContent.imageAddress),
                  fit: BoxFit.cover,
                ),
                height: 200,
                width: 450,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  children: [
                    buildRecipeHeader(recipeContent: recipeContent),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              recipeContent.foodName,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            flex: 2,
                          ),
                          const Expanded(
                              child: SizedBox(
                                width: 10,
                              ),
                              flex: 1),
                          Expanded(
                             flex: 1,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.shade50,
                                ),
                              child: Icon(Icons.favorite_outline, color: Colors.green.shade300,)),
                           
                          ),
                        ],
                      ),
                    ),
                    Text(
                      recipeContent.recipeDetail.description,
                      style: const TextStyle(
                          fontSize: 19.0, height: 1.5, color: Colors.black54),
                    ),
                    Container(
                      child: const Text(
                        "Ingredients",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    buildRecipeIngredients(
                        recipeDetail: recipeContent.recipeDetail),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      child: const Text(
                        "Directions",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recipeContent.recipeDetail.directions
                            .map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Step " +
                                            (recipeContent
                                                        .recipeDetail.directions
                                                        .indexOf(e) +
                                                    1)
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                            fontSize: 19.0,
                                            height: 1.5,
                                            color: Colors.black54),
                                      )),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 50),
                        child: buildAddToFavoriteButton),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildFoodItem(
        {required String imageAddress,
        required String theText,
        required FavoriteDetail theDetail,
        required BuildContext context}) =>
    Container(
      color: Colors.yellow[100],
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FoodDetailScreen(favoriteDetail: theDetail)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                imageAddress,
              ),
              height: 40.0,
              width: 40.0,
            ),
            const SizedBox(width: 10.0),
            Text(theText),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );

Widget buildForOnboardScreen(
        {required String imageAddress,
        required String textTitle,
        required String description}) =>
    Padding(
      padding: const EdgeInsets.only(
          top: 40.0, right: 40.0, left: 40.0, bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
              "kcal",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF81C784),
              ),
            ),
          ),
          Center(
            child: Image(
              image: AssetImage(imageAddress),
              height: 300.0,
              width: 300.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              textTitle,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );

Widget buildFoodGridView(
        {required List favoriteList, required BuildContext theContext}) =>
    GridView.count(
      childAspectRatio: (300.0 / 100.0),
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5.0,
      children: favoriteList
          .map((e) => buildFoodItem(
              imageAddress: e.imageAddress,
              theText: e.title,
              theDetail: e.favoriteDetail,
              context: theContext))
          .toList(),
    );

Widget buildSelection(
        {required Color theColor,
        required String theText,
        required String placement,
        required Color textColor}) =>
    Container(
      height: 60.0,
      width: 180.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theColor,
        borderRadius: placement == "left"
            ? const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
      ),
      child: Text(
        theText,
        style: theText == "Food"
            ? TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 18)
            : TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );

Widget buildEmpty({required String theText}) => Center(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                theText == "food"
                    ? const Image(
                        image: AssetImage("assets/foodEmptyBG.png"),
                        height: 150,
                        width: 150,
                      )
                    : const Image(
                        image: AssetImage("assets/recipeEmptyBG.png"),
                        height: 150,
                        width: 150,
                      ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "No $theText\s Found",
                    style: const TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  "You don't have any $theText. Go ahead, search and save your favorite $theText ",
                  style: const TextStyle(color: Colors.black54, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          buildSearchButton,
        ],
      ),
    );

Widget buildDetailHeader({required FavoriteDetail favoriteDetail}) => Container(
      height: 90.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage(favoriteDetail.imageAddress),
            height: 55,
            width: 55,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favoriteDetail.title,
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                "Alternative Name: " + favoriteDetail.altName,
                style: const TextStyle(fontSize: 15.0),
              ),
            ],
          ),
        ],
      ),
    );

Widget buildDetailedImageGallery({required FavoriteDetail favoriteDetail}) =>
    ListView(
      children: favoriteDetail.detailImageAddresses
          .map(
            (e) => Row(
              children: [
                Image.asset(
                  e,
                  height: 400.0,
                  width: 200.0,
                ),
                const SizedBox(width: 10),
              ],
            ),
          )
          .toList(),
      scrollDirection: Axis.horizontal,
    );

Widget buildRecipeItem(
        {required RecipeContent recipeContent,
        required BuildContext theContext}) =>
    Stack(children: [
      Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.brown[50],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              theContext,
              MaterialPageRoute(
                  builder: (context) => RecipeDetailedScreen(
                        recipeContent: recipeContent,
                      )),
            );
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Image(
                  image: AssetImage(recipeContent.imageAddress),
                  height: 150,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        const Icon(Icons.timer),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(recipeContent.time),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("min"),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.people_outline),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(recipeContent.numOfServing),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("serve"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.deepOrange,
                        ),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.deepOrange,
                        ),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.deepOrange,
                        ),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.deepOrange,
                        ),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.deepOrange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    recipeContent.foodName,
                    style: const TextStyle(fontSize: 16.0),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(recipeContent.shortDescription,
                      style: const TextStyle(
                          fontSize: 15.0, color: Colors.black54))),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 13.0, top: 13.0),
          child: const Icon(Icons.favorite_outline, color: Colors.white,),
          )
      )
    ]);

Widget buildRecipeListView(
        {required List recipeList, required BuildContext theContext}) =>
    ListView(
      children: recipeList
          .map((e) => Column(
                children: [
                  buildRecipeItem(recipeContent: e, theContext: theContext),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              ))
          .toList(),
    );

Widget buildRecipeHeader({required RecipeContent recipeContent}) => Container(
      height: 60.0,
      //margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(
                  width: 5,
                ),
                Text(recipeContent.time),
                const SizedBox(
                  width: 5,
                ),
                const Text("min"),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.people_outline),
                const SizedBox(
                  width: 5,
                ),
                Text(recipeContent.numOfServing),
                const SizedBox(
                  width: 5,
                ),
                const Text("serve"),
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.deepOrange,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.deepOrange,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.deepOrange,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.deepOrange,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.deepOrange,
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget buildRecipeIngredients({required RecipeDetail recipeDetail}) => SizedBox(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: recipeDetail.recipeIngredients
            .map((e) => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[200],
                  ),
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(e.imageAddresses),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        e.name,
                        textAlign: TextAlign.center,
                      ),
                      Text(e.amount),
                    ],
                  ),
                ))
            .toList(),
      ),
    );

Widget get buildAddToFavoriteButton => SizedBox(
      height: 60,
      width: 275,
      child: FloatingActionButton(
        backgroundColor: Colors.red[300],
        child: const Text(
          "Add to Favorite",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
    );

Widget get buildSearchButton => SizedBox(
      height: 60,
      width: 275,
      child: FloatingActionButton(
        backgroundColor: Colors.red[300],
        child: const Text(
          "Search",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
    );
