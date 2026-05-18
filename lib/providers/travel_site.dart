import "../models/travel_site.dart";

class TravelSiteProvider {
  TravelSite? _travelSite;
  TravelSite? get travelSite => _travelSite;
  static List<TravelSite> get mockItems => travelSites;
}

String melivecode = "https://www.melivecode.com";

List<TravelSite> travelSites = [
  TravelSite(
    id: 1,
    name: "Phi Phi Islands",
    detail:
        "Phi Phi Islands are a group of islands in Thailand between the large island of Phuket and the Malacca Coastal Strait of Thailand.",
    coverimage: "$melivecode/1.jpg",
    latitude: 7.737619,
    longitude: 98.7068755,
    createdAt: DateTime.parse("2025-12-21T13:49:23.792Z"),
  ),
  TravelSite(
    id: 2,
    name: "Eiffel Tower",
    detail:
        "Eiffel Tower is one of the most famous structures in the world. Eiffel Tower is named after a leading French architect and engineer. It was built as a symbol of the World Fair in 1889.",
    coverimage: "$melivecode/2.jpg",
    latitude: 48.8583736,
    longitude: 2.2922926,
    createdAt: DateTime.parse("2025-12-21T13:49:23.996Z"),
  ),
  TravelSite(
    id: 3,
    name: "Times Square",
    detail:
        "Times Square has become a global landmark and has become a symbol of New York City. This is a result of Times Square being a modern, futuristic venue, with huge advertising screens dotting its surroundings.",
    coverimage: "$melivecode/3.jpg",
    latitude: 40.7589652,
    longitude: -73.9893574,
    createdAt: DateTime.parse("2025-12-21T13:49:24.133Z"),
  ),
  TravelSite(
    id: 4,
    name: "Mount Fuji",
    detail:
        "Mount Fuji is the highest mountain in Japan, about 3,776 meters (12,388 feet) situated to the west of Tokyo. Mount Fuji can be seen from Tokyo on clear days.",
    coverimage: "$melivecode/4.jpg",
    latitude: 35.3606422,
    longitude: 138.7186086,
    createdAt: DateTime.parse("2025-12-21T13:49:24.270Z"),
  ),
  TravelSite(
    id: 5,
    name: "Big Ben",
    detail:
        "Westminster Palace Clock Tower which is most often referred to as Big Ben. This is actually the nickname for the largest bell that hangs in the vent above the clock face.",
    coverimage: "$melivecode/5.jpg",
    latitude: 51.5007325,
    longitude: -0.1268141,
    createdAt: DateTime.parse("2025-12-21T13:49:24.417Z"),
  ),
  TravelSite(
    id: 6,
    name: "Taj Mahal",
    detail:
        "The Taj Mahal or Tachomhal is a burial building made of ivory white marble. The Taj Mahal began to be built in 1632 and was completed in 1643.",
    coverimage: "$melivecode/6.jpg",
    latitude: 27.1751496,
    longitude: 78.0399535,
    createdAt: DateTime.parse("2025-12-21T13:49:24.589Z"),
  ),
  TravelSite(
    id: 7,
    name: "Stonehenge",
    detail:
        "Stonehenge is a monument prehistoric In the middle of a vast plain in the southern part of the British. The monument itself consists of 112 gigantic stone blocks arranged in 3 overlapping circles.",
    coverimage: "$melivecode/7.jpg",
    latitude: 51.1788853,
    longitude: -1.8284037,
    createdAt: DateTime.parse("2025-12-21T13:49:24.725Z"),
  ),
  TravelSite(
    id: 8,
    name: "Statue of Liberty",
    detail:
        "The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. The copper statue, a gift from the people of France to the people of the United States.",
    coverimage: "$melivecode/8.jpg",
    latitude: 40.689167,
    longitude: -74.044444,
    createdAt: DateTime.parse("2025-12-21T13:49:24.861Z"),
  ),
  TravelSite(
    id: 9,
    name: "Sydney Opera House",
    detail:
        "The Sydney Opera House is a multi-venue performing arts centre in Sydney. Located on the banks of the Sydney Harbour, it is often regarded as one of the most famous and distinctive buildings and a masterpiece of 20th century architecture.",
    coverimage: "$melivecode/9.jpg",
    latitude: -33.858611,
    longitude: 151.214167,
    createdAt: DateTime.parse("2025-12-21T13:49:24.999Z"),
  ),
  TravelSite(
    id: 10,
    name: "Great Pyramid of Giza",
    detail:
        "The Great Pyramid of Giza is the oldest and largest of the pyramids in the Giza pyramid complex bordering present-day Giza in Greater Cairo, Egypt. It is the oldest of the Seven Wonders of the Ancient World, and the only one to remain largely intact.",
    coverimage: "$melivecode/10.jpg",
    latitude: 29.979167,
    longitude: 31.134167,
    createdAt: DateTime.parse("2025-12-21T13:49:25.134Z"),
  ),
  TravelSite(
    id: 11,
    name: "Hollywood Sign",
    detail:
        "The Hollywood Sign is an American landmark and cultural icon overlooking Hollywood, Los Angeles, California. It is situated on Mount Lee, in the Beachwood Canyon area of the Santa Monica Mountains. Spelling out the word Hollywood in 45 ft (13.7 m)-tall white capital letters and 350 feet (106.7 m) long.",
    coverimage: "$melivecode/11.jpg",
    latitude: 34.134061,
    longitude: -118.321592,
    createdAt: DateTime.parse("2025-12-21T13:49:25.274Z"),
  ),
  TravelSite(
    id: 12,
    name: "Wat Phra Kaew",
    detail:
        "Wat Phra Kaew, commonly known in English as the Temple of the Emerald Buddha and officially as Wat Phra Si Rattana Satsadaram, is regarded as the most sacred Buddhist temple in Thailand. The complex consists of a number of buildings within the precincts of the Grand Palace in the historical centre of Bangkok.",
    coverimage: "$melivecode/12.jpg",
    latitude: 13.751389,
    longitude: 100.4925,
    createdAt: DateTime.parse("2025-12-21T13:49:25.411Z"),
  ),
];
