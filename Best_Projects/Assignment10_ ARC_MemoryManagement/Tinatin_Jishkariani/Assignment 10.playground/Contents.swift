import Foundation

/*
 Topic 1: შექმენით CreatureType enum-ი სხვადასხვა ტიპის არსებებით (მაგ: fire, water, earth, air, electric …). გამოიყენეთ associated value, რომ თითოეულ ტიპს ჰქონდეს rarity: Double მნიშვნელობა 0-დან 1-მდე. დაამატეთcomputed property description, რომელიც დააბრუნებს არსების ტიპის აღწერას. 
 */

enum CreatureType {
    case fire(rarity: Double)
    case water(rarity: Double)
    case earth(rarity: Double)
    case air(rarity: Double)
    case electric(rarity: Double)
    
    var description: String {
        switch self {
        case .fire(let rarity):
            return "Fire type creature with rarity \(rarity)"
        case .water(let rarity):
            return "Water type creature with rarity \(rarity)"
        case .earth(let rarity):
            return "Earth type creature with rarity \(rarity)"
        case .air(let rarity):
            return "Air type creature with rarity \(rarity)"
        case .electric(let rarity):
            return "Electric type creature with rarity \(rarity)"
        }
    }
}

/*
 Topic 2: შექმენით პროტოკოლი CreatureStats შემდეგი მოთხოვნებით: var health: Double; var attack: Double; var defense: Double; func updateStats(health: Double, attack: Double, defense: Double) მეთოდი, რომელიც განაახლებს ამ მონაცემებს
 */

protocol CreatureStats {
    var health: Double { get set }
    var attack: Double { get set }
    var defense: Double { get set }
    
    func updateStats(health: Double, attack: Double, defense: Double)
}

/*
 Topic 3: შექმენით კლასი Trainer შემდეგი ფროფერთებით: public let name: String; private var creatures: [DigitalCreature]; დაამატეთ public მეთოდი add(creature: DigitalCreature) რომლითაც შეძლებთ ახალი არსების დამატებას მასივში, ასევე არსებას საკუთარ თავს (self) დაუსეტავს ტრენერად.
 */
class Trainer {
    public let name: String
    private var creatures: [DigitalCreature]
    
    init(name: String) {
        self.name = name
        self.creatures = []
    }
    
    public func add(creature: DigitalCreature) {
        creatures.append(creature)
        creature.trainer = self
    }
}

/*
 Topic 4: შექმენით კლასი DigitalCreature, რომელიც დააკმაყოფილებს CreatureStats პროტოკოლს. დაამატეთ: public let name: String; public let type: CreatureType; public var level: Int; public var experience: Double; weak public var trainer: Trainer?; დაამატეთ deinit მეთოდი, რომელიც დაბეჭდავს შეტყობინებას არსების წაშლისას.
 */

class DigitalCreature: CreatureStats {
    public let name: String
    public let type: CreatureType
    public var level: Int
    public var experience: Double
    weak public var trainer: Trainer?
    
    public var health: Double
    public var attack: Double
    public var defense: Double
    
    init(name: String, type: CreatureType, level: Int = 1, experience: Double = 0) {
        self.name = name
        self.type = type
        self.level = level
        self.experience = experience
        self.health = 100.0
        self.attack = 10.0
        self.defense = 5.0
    }
    
    func updateStats(health: Double, attack: Double, defense: Double) {
        self.health = health
        self.attack = attack
        self.defense = defense
    }
    
    deinit {
        print("\(name) has been removed from the game.")
    }
}

/*
 Topic 5: შექმენით CreatureManager კლასი შემდეგი ფუნქციონალით: private var creatures: [DigitalCreature] - არსებების მასივი; public func adoptCreature(_ creature: DigitalCreature) - არსების დამატება; public func trainCreature(named name: String) - კონკრეტული არსების წვრთნა (გაითვალისწინეთ რომ წვრთნა მოხდება მხოლოდ მაშინ თუ არჩეულ არსებას ყავს მწვრთნელი!); public func listCreatures() -> [DigitalCreature] - ყველა არსების სიის დაბრუნება. გააფართოვეთ CreatureManage კლასი მეთოდით func trainAllCreatures(), რომელიც გაწვრთნის ყველა არსებას.
 */
class CreatureManager {
    private var creatures: [DigitalCreature]
    
    init() {
        self.creatures = []
    }
    
    public func adoptCreature(_ creature: DigitalCreature) {
        creatures.append(creature)
    }
    
    public func trainCreature(named name: String) {
        if let creature = creatures.first(where: { $0.name == name }),
           creature.trainer != nil {
            creature.experience += 10
            print("\(creature.name) has been trained and gained 10 experience points.")
        } else {
            print("Creature not found or doesn't have a trainer.")
        }
    }
    
    public func listCreatures() -> [DigitalCreature] {
        return creatures
    }
    
    public func trainAllCreatures() {
        for creature in creatures where creature.trainer != nil {
            creature.experience += 10
            print("\(creature.name) has been trained and gained 10 experience points.")
        }
    }
}

/*
 Topic 6: შექმენით CreatureShop კლასი მეთოდით purchaseRandomCreature() -> DigitalCreature. ეს მეთოდი დააბრუნებს რანდომიზირებულად დაგენერირებულ არსებას. 
 */

class CreatureShop {
    private let creatureTypes: [CreatureType] = [
        .fire(rarity: 0.3),
        .water(rarity: 0.3),
        .earth(rarity: 0.3),
        .air(rarity: 0.3),
        .electric(rarity: 0.3)
    ]
    
    public func purchaseRandomCreature() -> DigitalCreature {
        let randomType = creatureTypes.randomElement()!
        let randomName = "Creature\(Int.random(in: 1000...9999))"
        return DigitalCreature(name: randomName, type: randomType)
    }
}

/*
 Topic 7: შექმენით გლობალური ფუნქცია updateLeaderboard(players: [PlayerProfile]) -> [PlayerProfile], რომელიც დაალაგებს მოთამაშეებს მათი არსებების ჯამური ძალის მიხედვით.
 */
struct PlayerProfile {
    let name: String
    let creatures: [DigitalCreature]
}

func updateLeaderboard(players: [PlayerProfile]) -> [PlayerProfile] {
    return players.sorted { player1, player2 in
        let power1 = player1.creatures.reduce(0) { $0 + $1.attack + $1.defense }
        let power2 = player2.creatures.reduce(0) { $0 + $1.attack + $1.defense }
        return power1 > power2
    }
}

/*
 Topic 8: გამოვიყენოთ წინა ტასკებში შექმნილი ყველა ფუნქციონალი: შექმენით რამდენიმე Trainer ობიექტი; შექმენით რამდენიმე CreatureManager ობიექტი; შექმენით ერთი ან ორი CreatureShop; თითოეული მენეჯერისთვის: ეიძინეთ რამდენიმე შემთხვევითი არსება CreatureShop-იდან; მიაბარეთ რამდენიმე არსება რომელიმე ტრენერს.; სცადეთ არსებების წვრთნა CreatureManager-ის trainCreature(named:) მეთოდით; გამოიყენეთ CreatureManager-ის trainAllCreatures() მეთოდი ყველა მოთამაშის არსებების საწვრთნელად (თუ ყავს მწვრთნელი, რა თქმა უნდა); განაახლეთ ლიდერბორდი updateLeaderboard() ფუნქციის გამოყენებით; დაბეჭდეთ თითოეული მოთამაშის არსებების სია და მათი სტატისტიკა; წაშალეთ ერთი არსება რომელიმე Trainer-იდან და აჩვენეთ, რომ weak reference მუშაობს სწორად (დაბეჭდეთ არსების trainer property-ს მნიშვნელობა წაშლამდე და წაშლის შემდეგ); დააკვირდით deinit მეთოდის გამოძახებას არსების წაშლისას.
 */

let trainer1 = Trainer(name: "Tiko")
let trainer2 = Trainer(name: "Tiffany")

let manager1 = CreatureManager()
let manager2 = CreatureManager()

let shop = CreatureShop()

for _ in 1...3 {
    let creature1 = shop.purchaseRandomCreature()
    let creature2 = shop.purchaseRandomCreature()
    
    trainer1.add(creature: creature1)
    trainer2.add(creature: creature2)
    
    manager1.adoptCreature(creature1)
    manager2.adoptCreature(creature2)
}

manager1.trainCreature(named: manager1.listCreatures()[0].name)
manager2.trainAllCreatures()

let players = [
    PlayerProfile(name: trainer1.name, creatures: manager1.listCreatures()),
    PlayerProfile(name: trainer2.name, creatures: manager2.listCreatures())
]
let leaderboard = updateLeaderboard(players: players)

for player in leaderboard {
    print("\(player.name)'s creatures:")
    for creature in player.creatures {
        print("- \(creature.name): Health: \(creature.health), Attack: \(creature.attack), Defense: \(creature.defense)")
    }
}

func demonstrateWeakReference() {
    
    if var removedCreature = manager1.listCreatures().first {
        print("Before removal: \(removedCreature.name)'s trainer is \(removedCreature.trainer?.name ?? "None")")
        removedCreature = DigitalCreature(name: "Temp", type: .fire(rarity: 0.5))
        print("After removal: \(removedCreature.name)'s trainer is \(removedCreature.trainer?.name ?? "None")")
    }
}

demonstrateWeakReference()
