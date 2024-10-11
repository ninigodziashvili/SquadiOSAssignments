import Foundation

// 1. შექმენით CreatureType enum-ი სხვადასხვა ტიპის არსებებით (მაგ: fire, water, earth, air, electric …). გამოიყენეთ associated value, რომ თითოეულ ტიპს ჰქონდეს rarity: Double მნიშვნელობა 0-დან 1-მდე. დაამატეთ computed property description, რომელიც დააბრუნებს არსების ტიპის აღწერას. 

enum CreatureType {
    case fire(rarity: Double)
    case water(rarity: Double)
    case earth(rarity: Double)
    case air(rarity: Double)
    case electric(rarity: Double)
    
    var rarity: Double {
        switch self {
        case .fire(let rarity), .water(let rarity), .earth(let rarity), .air(let rarity), .electric(let rarity):
            return min(max(rarity, 0.0), 1.0)
        }
    }
    
    var description: String {
        switch self {
        case .fire:
            return "Fire creature with rarity: \(rarity)"
        case .water:
            return "Water creature with rarity: \(rarity)"
        case .earth:
            return "Earth creature with rarity: \(rarity)"
        case .air:
            return "Air creature with rarity: \(rarity)"
        case .electric:
            return "Electric creature with rarity: \(rarity)"
        }
    }
}

let waterCreature = CreatureType.water(rarity: 0.2)
let fireCreature = CreatureType.fire(rarity: 0.4)
print(waterCreature.description)
print(fireCreature.description)

print("\n-------------\n")
/*
 2. შექმენით პროტოკოლი CreatureStats შემდეგი მოთხოვნებით:
 var health: Double
 var attack: Double
 var defense: Double
 func updateStats(health: Double, attack: Double, defense: Double) მეთოდი, რომელიც განაახლებს ამ მონაცემებს (შეგიძლიათ ფუნქციის პარამეტრები სურვილისამებრ შეცვალოთ, მაგ: დეფოლტ მნიშვნელობები გაუწეროთ 😌) 
*/

protocol CreatureStats {
    var health: Double { get }
    var attack: Double { get }
    var defense: Double { get }
    
    func updateStats(health: Double, attack: Double, defense: Double)
}

/*
 3. შექმენით კლასი Trainer შემდეგი ფროფერთებით:
     public let name: String
     private var creatures: [DigitalCreature]
     დაამატეთ public მეთოდი add(creature: DigitalCreature) რომლითაც შეძლებთ ახალი არსების დამატებას მასივში, ასევე არსებას საკუთარ თავს (self) დაუსეტავს ტრენერად.
*/

class Trainer {
    public let name: String
    private var creatures: [DigitalCreature] = []
    
    init(name: String, creatures: [DigitalCreature] = []) {
        self.name = name
        self.creatures = creatures
    }
    
    public func add(creature: DigitalCreature) {
        if !creatures.contains(where: {$0.name == creature.name}) {
            creatures.append(creature)
            creature.trainer = self
        } else {
            print("არსება \(creature.name) უკვე არის სიასი")
        }
    }
    
    public func remove(creature: DigitalCreature) {
        if creatures.contains(where: {$0.name == creature.name}) {
            creatures.removeAll(where: {$0.name == creature.name})
        } else {
            print("\(creature.name) არ არის სიაში")
        }
    }
    
    func validateCreature(name: String) -> Bool {
        creatures.contains(where: {$0.name == name})
    }
    
    deinit {
        print("ტრენერი \(name) წაიშალა")
    }

}

/*
 4. შექმენით კლასი DigitalCreature, რომელიც დააკმაყოფილებს CreatureStats პროტოკოლს. დაამატეთ:
      public let name: String
      public let type: CreatureType
      public var level: Int
      public var experience: Double
      weak public var trainer: Trainer?
      დაამატეთ deinit მეთოდი, რომელიც დაბეჭდავს შეტყობინებას არსების წაშლისას. 
*/

class DigitalCreature: CreatureStats {
    var health: Double = 0
    var attack: Double = 0
    var defense: Double = 0
    public let name: String
    public let type: CreatureType
    public var level: Int
    public var experience: Double = 0
    weak public var trainer: Trainer?
    
    init(health: Double = 0, attack: Double = 0, defense: Double = 0, name: String, type: CreatureType, level: Int, experience: Double = 0, trainer: Trainer? = nil) {
        self.health = health
        self.attack = attack
        self.defense = defense
        self.name = name
        self.type = type
        self.level = level
        self.experience = experience
        self.trainer = trainer
    }
    
    func updateStats(health: Double, attack: Double, defense: Double) {
        self.health += health
        self.attack += attack
        self.defense += defense
    }
    
    deinit {
        print("არსება \(name) წაიშალა\n")
    }
}

digitalCreature = nil
print("--------------\n")

/*
 5. შექმენით CreatureManager კლასი შემდეგი ფუნქციონალით:
      private var creatures: [DigitalCreature] - არსებების მასივი
      public func adoptCreature(_ creature: DigitalCreature) - არსების დამატება
      public func trainCreature(named name: String) - კონკრეტული არსების წვრთნა (გაითვალისწინეთ რომ წვრთნა მოხდება მხოლოდ მაშინ თუ არჩეულ არსებას ყავს მწვრთნელი!)
      public func listCreatures() -> [DigitalCreature] - ყველა არსების სიის დაბრუნება  გააფართოვეთ CreatureManage კლასი მეთოდით func trainAllCreatures(), რომელიც გაწვრთნის ყველა არსებას. 
*/

class CreatureManager{
    private var creatures: [DigitalCreature] = []
    
    init(creatures: [DigitalCreature] = []) {
        self.creatures = creatures
    }
    
    public func adoptCreatuer(_ creature: DigitalCreature) {
        if !creatures.contains(where: { $0.name == creature.name }) {
            creatures.append(creature)
        } else {
            print("არსება \(creature.name) უკვე არის სიაში")
        }
    }
    
    public func trainCreature(named name: String) {
        if let index = creatures.firstIndex(where: { $0.name == name }) {
            var creature = creatures[index]
            
            if creature.trainer != nil {
                let trainHealth: Double = creature.health + 5
                let trainAttack: Double = creature.attack + 5
                let trainDefense: Double = creature.defense + 5
                
                creature.experience += 20
                
                if creature.experience >= 100 {
                    creature.experience = creature.experience - 100
                    creature.level += 1
                }
                
                creature.updateStats(health: trainHealth, attack: trainAttack, defense: trainDefense)
                print("\(creature.name) გაიწრთვნა")
            } else {
                print("\(name) არსებას არ ყავს ტრენერი")
            }
            
        } else {
            print("\(name) არსებას არ არის გუნდში")
        }
    }
    
    public func totalExperience() -> Double {
           return creatures.reduce(0) { $0 + $1.experience }
       }
    
    public func listCreatures() {
        creatures.map { print("\nNAME: \($0.name)\nCreature Type: \($0.type)\nAttack: \($0.attack)\nDefense: \($0.defense)\nHealth: \($0.health)\nLevel: \($0.level)\nExperience: \($0.experience)") }
    }
}

extension CreatureManager {
    public func trainAll(creatures: [DigitalCreature]) {
        for creature in creatures {
            if creature.trainer != nil {
                trainCreature(named: creature.name)
            } else {
                print("\(creature.name) არსებას არ ყავს ტრენერი")
            }
        }
    }
}

// 6. შექმენით CreatureShop კლასი მეთოდით purchaseRandomCreature() -> DigitalCreature. ეს მეთოდი დააბრუნებს რანდომიზირებულად დაგენერირებულ არსებას.

class CreatureShop {
    private let creatureTypes: [CreatureType] = [
            .fire(rarity: 0.7),
            .water(rarity: 0.5),
            .earth(rarity: 0.6),
            .air(rarity: 0.8),
            .electric(rarity: 0.4)
        ]
    
     func purchaseRandomCreature() -> DigitalCreature {
        let randomName = "Creature-\(Int.random(in: 1...1000))"
        let randomType = creatureTypes.randomElement()!
        
        return DigitalCreature(health: Double(Int.random(in: 0...100)), attack: Double(Int.random(in: 0...100)), defense: Double(Int.random(in: 0...100)), name: randomName, type: randomType, level: Int.random(in: 0...100), experience: Double(Int.random(in: 0...100)))
    }
}

// 7. შექმენით გლობალური ფუნქცია updateLeaderboard(players: [CreatureManager]) -> [CreatureManager], რომელიც დაალაგებს მოთამაშეებს მათი არსებების ჯამური ძალის მიხედვით.  

func updateLeaderBoard(players: [CreatureManager]) -> [CreatureManager] {
    let sortedPlayers = players.sorted { $0.totalExperience() > $1.totalExperience() }
    return sortedPlayers
}

/*
 8. გამოვიყენოთ წინა ტასკებში შექმნილი ყველა ფუნქციონალი:
     * შექმენით რამდენიმე Trainer ობიექტი
     * შექმენით რამდენიმე CreatureManager ობიექტი
     * შექმენით ერთი ან ორი CreatureShop
     * თითოეული მენეჯერისთვის:
         * შეიძინეთ რამდენიმე შემთხვევითი არსება CreatureShop-იდან
         * მიაბარეთ რამდენიმე არსება რომელიმე ტრენერს.
         * სცადეთ არსებების წვრთნა CreatureManager-ის trainCreature(named:) მეთოდით
     * გამოიყენეთ CreatureManager-ის trainAllCreatures() მეთოდი ყველა მოთამაშის არსებების საწვრთნელად (თუ ყავს მწვრთნელი, რა თქმა უნდა)
     * განაახლეთ ლიდერბორდი updateLeaderboard() ფუნქციის გამოყენებით
     * დაბეჭდეთ თითოეული მოთამაშის არსებების სია და მათი სტატისტიკა
     * წაშალეთ ერთი არსება რომელიმე Trainer-იდან და აჩვენეთ, რომ weak reference მუშაობს სწორად (დაბეჭდეთ არსების trainer property-ს მნიშვნელობა წაშლამდე და წაშლის შემდეგ)
     * დააკვირდით deinit მეთოდის გამოძახებას არსების წაშლისას 
*/

let trainerIrakli = Trainer(name: "Irakli")
let trainerLuka = Trainer(name: "Luka")
let trainerNodo = Trainer(name: "Nodo")

let manager1 = CreatureManager()
let manager2 = CreatureManager()
let manager3 = CreatureManager()

let shop1 = CreatureShop()
let shop2 = CreatureShop()

let creature1 = shop1.purchaseRandomCreature()
let creature2 = shop1.purchaseRandomCreature()
let creature3 = shop1.purchaseRandomCreature()
let creature4 = shop1.purchaseRandomCreature()
let creature5 = shop1.purchaseRandomCreature()
let creature6 = shop1.purchaseRandomCreature()
let creature7 = shop1.purchaseRandomCreature()

manager1.adoptCreatuer(creature1)
manager1.adoptCreatuer(creature2)

manager2.adoptCreatuer(creature3)
manager2.adoptCreatuer(creature4)
manager2.adoptCreatuer(creature5)

manager3.adoptCreatuer(creature6)
manager3.adoptCreatuer(creature7)

trainerLuka.add(creature: creature1)
trainerLuka.add(creature: creature2)

trainerIrakli.add(creature: creature3)
trainerIrakli.add(creature: creature4)
trainerIrakli.add(creature: creature5)

trainerNodo.add(creature: creature6)
trainerNodo.add(creature: creature7)

manager1.trainCreature(named: creature1.name)
manager2.trainCreature(named: creature3.name)
manager3.trainCreature(named: creature6.name)

manager1.trainAll(creatures: [creature1, creature2])
manager2.trainAll(creatures: [creature3, creature4, creature5])
manager3.trainAll(creatures: [creature6, creature7])

let leaderBoard = updateLeaderBoard(players: [manager1, manager2, manager3])
leaderBoard.map { print("\n",$0.self); $0.listCreatures() }

var trainer1: Trainer? = Trainer(name: "Trainer Irakli")

var digitalCreature: DigitalCreature? = DigitalCreature(health: 5, attack: 8, defense: 3, name: "Digital creature", type: .electric(rarity: 0.6), level: 7, experience: 2)

if let creature = digitalCreature {
    
    trainer1?.add(creature: creature)
    
    print("\nარსების ტრენერია",creature.trainer?.name ?? "no trainer")
    
    trainer1?.validateCreature(name: digitalCreature?.name ?? "")
    trainer1?.remove(creature: creature)
    
}

digitalCreature = nil
print(digitalCreature?.trainer ?? "")









// ამის გარეშე ასე დაშორებით არ ისტარტებოდა კომპაილერი
print("sadsdas")
