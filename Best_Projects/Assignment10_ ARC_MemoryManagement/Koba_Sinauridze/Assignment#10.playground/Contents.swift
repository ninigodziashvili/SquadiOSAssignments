import UIKit

// კობა სინაურიძე _ Assignment 10. ARC და მეხსიერების უსაფრთხოება

// 1. შექმენით CreatureType enum-ი სხვადასხვა ტიპის არსებებით (მაგ: fire, water, earth, air, electric …). გამოიყენეთ associated value, რომ თითოეულ ტიპს ჰქონდეს rarity: Double მნიშვნელობა 0-დან 1-მდე. დაამატეთ computed property description, რომელიც დააბრუნებს არსების ტიპის აღწერას.
enum CreatureType {
    case fire(rarity: Double)
    case water(rarity: Double)
    case earth(rarity: Double)
    case air(rarity: Double)
    case electric(rarity: Double)
    
    var description: String {
        switch self {
        case .fire(rarity: let rarity):
            return "fire creature, rarity: \(rarity)"
        case .water(rarity: let rarity):
            return "water creature, rarity: \(rarity)"
        case .earth(rarity: let rarity):
            return "earth creature, rarity: \(rarity)"
        case .air(rarity: let rarity):
            return "air creature, rarity: \(rarity)"
        case .electric(rarity: let rarity):
            return "electric creature, rarity: \(rarity)"
        }
    }
}

/* 2. შექმენით პროტოკოლი CreatureStats შემდეგი მოთხოვნებით:
 * var health: Double
 * var attack: Double
 * var defense: Double
 * func updateStats(health: Double, attack: Double, defense: Double) მეთოდი, რომელიც განაახლებს ამ მონაცემებს (შეგიძლიათ ფუნქციის პარამეტრები სურვილისამებრ შეცვალოთ, მაგ: დეფოლტ მნიშვნელობები გაუწეროთ 😌)*/
protocol CreatureStats {
    var heath: Double { get }
    var attack: Double { get }
    var defense: Double { get }
    
    func updateStats(health: Double, attack: Double, defense: Double)
}

/* 3. შექმენით კლასი Trainer შემდეგი ფროფერთებით:
 * public let name: String
 * private var creatures: [DigitalCreature]
 * დაამატეთ public მეთოდი add(creature: DigitalCreature) რომლითაც შეძლებთ ახალი არსების დამატებას მასივში, ასევე არსებას საკუთარ თავს (self) დაუსეტავს ტრენერად. */
class Trainer {
    public let name: String
    private var creatures: [DigitalCreature]
    
    init(name: String, creatures: [DigitalCreature]) {
        self.name = name
        self.creatures = creatures
    }
    
    deinit {
        print("Trainer has been deinitialized")
    }
    
    public func add(creature: DigitalCreature) {
        self.creatures.append(creature)
        creature.trainer = self
    }
}

/* 4. შექმენით კლასი DigitalCreature, რომელიც დააკმაყოფილებს CreatureStats პროტოკოლს. დაამატეთ:
 * public let name: String
 * public let type: CreatureType
 * public var level: Int
 * public var experience: Double
 * weak public var trainer: Trainer?
 * დაამატეთ deinit მეთოდი, რომელიც დაბეჭდავს შეტყობინებას არსების წაშლისას*/
class DigitalCreature: CreatureStats {
    var heath: Double
    var attack: Double
    var defense: Double
    public let name: String
    public let type: CreatureType
    public var experience: Double
    weak public var trainer: Trainer?
    
    init(heath: Double, attack: Double, defense: Double, name: String, type: CreatureType, experience: Double, trainer: Trainer? = nil) {
        self.heath = heath
        self.attack = attack
        self.defense = defense
        self.name = name
        self.type = type
        self.experience = experience
        self.trainer = trainer
    }
    
    deinit {
        print("creature has been deinitialized")
    }
    
    func updateStats(health: Double, attack: Double, defense: Double) {
        self.heath += health
        self.attack += attack
        self.defense += defense
    }
    func totalPower() -> Double {
        return ((self.attack + self.defense + self.heath)/3)
    } // ეს 7. დავალებისთვის დავამატე
}

/* 5. შექმენით CreatureManager კლასი შემდეგი ფუნქციონალით:
 * private var creatures: [DigitalCreature] - არსებების მასივი
 * public func adoptCreature(_ creature: DigitalCreature) - არსების დამატება
 * public func trainCreature(named name: String) - კონკრეტული არსების წვრთნა (გაითვალისწინეთ რომ წვრთნა მოხდება მხოლოდ მაშინ თუ არჩეულ არსებას ყავს მწვრთნელი!)
 * public func listCreatures() -> [DigitalCreature] - ყველა არსების სიის დაბრუნება. გააფართოვეთ CreatureManage კლასი მეთოდით func trainAllCreatures(), რომელიც გაწვრთნის ყველა არსებას*/
class CreatureManager {
    private var creatures: [DigitalCreature]
    
    init(creatures: [DigitalCreature]) {
        self.creatures = creatures
    }
    
    public func adoptCreature(_ creature: DigitalCreature) {
        creatures.append(creature)
    }
    public func trainCreature(named name: String) {
        for creature in creatures {
            if creature.name == name && creature.trainer != nil {
                creature.updateStats(health: 5.0, attack: 1.5, defense: 0.5)
                print("\(creature.name)'s stats has been updated! (health: \(creature.heath), Attack: \(creature.attack), Defense: \(creature.defense))")
            } else {
                print("Creature isn't avaialbe for train")
            }
        }
    }
    public func listCreatures() -> [DigitalCreature] {
        var listOfCreatures: [DigitalCreature] = []
        for creature in creatures {
            listOfCreatures.append(creature)
        }
        return listOfCreatures
    }
    public func creaturesDescription() {
        self.listCreatures().forEach { DigitalCreature in
            print("\(DigitalCreature.name)'s stats are: health: \(DigitalCreature.heath), attack: \(DigitalCreature.attack), defense \(DigitalCreature.defense) ")

        }
    }
}

extension CreatureManager {
    func trainAllCreatures() {
        for creature in self.creatures {
            if creature.trainer != nil {
                creature.updateStats(health: 5.0, attack: 1.5, defense: 0.5)
                print("\(creature.name)'s stats has been updated! (health: \(creature.heath), Attack: \(creature.attack), Defense: \(creature.defense))")
            } else {
                print("\(creature.name) can't be trained because it doesn't have Trainer!")
            }
        }
    }
}
 // 6. შექმენით CreatureShop კლასი მეთოდით purchaseRandomCreature() -> DigitalCreature. ეს მეთოდი დააბრუნებს რანდომიზირებულად დაგენერირებულ არსებას. 
class CreatureShop {
    let ArrayOfRandomRarityTypes: [CreatureType] = [.air(rarity:Double.random(in: 0...1)), .earth(rarity:Double.random(in: 0...1)), .fire(rarity:Double.random(in: 0...1)), .water(rarity:Double.random(in: 0...1)), .electric(rarity:Double.random(in: 0...1))]

    func purchaseRandomCreature(name: String) -> DigitalCreature {
        var randomCreature = DigitalCreature(heath: Double.random(in: 0...5), attack: Double.random(in: 0...3), defense: Double.random(in: 0...1), name: name, type: ArrayOfRandomRarityTypes[Int.random(in: 0..<ArrayOfRandomRarityTypes.count)], experience: 0)
        return randomCreature
    }
}

// 7. შექმენით გლობალური ფუნქცია updateLeaderboard(players: [CreatureManager]) -> [CreatureManager], რომელიც დაალაგებს მოთამაშეებს მათი არსებების ჯამური ძალის მიხედვით.  

func updateLeaderboard(players: [CreatureManager]) -> [CreatureManager] {
    var leaderBoard: [CreatureManager] = players

    leaderBoard.sort { creatureManagerOne, creatureManagerTwo in
        creatureManagerOne.listCreatures().reduce(0) { $0 + $1.experience } > creatureManagerTwo.listCreatures().reduce(0) { $0 + $1.experience }
    }
    return leaderBoard
}

/*8. გამოვიყენოთ წინა ტასკებში შექმნილი ყველა ფუნქციონალი:
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
 * დააკვირდით deinit მეთოდის გამოძახებას არსების წაშლისას*/

var trainerOne = Trainer(name: "Trainer One", creatures: [])
var trainerTwo = Trainer(name: "Trainer Two", creatures: [])

var playerOne = CreatureManager(creatures: [])
var playerTwo = CreatureManager(creatures: [])

let creatureShop = CreatureShop()

let randomCreatureOne = creatureShop.purchaseRandomCreature(name: "RandomCreatureOne")
randomCreatureOne.experience = 5
playerOne.adoptCreature(randomCreatureOne)
let randomCreatureTwo = creatureShop.purchaseRandomCreature(name: "RandomCreatureTwo")
randomCreatureTwo.experience = 10
playerTwo.adoptCreature(randomCreatureTwo)

trainerOne.add(creature: randomCreatureOne)
trainerTwo.add(creature: randomCreatureTwo)

playerOne.trainCreature(named: "RandomCreatureOne")
playerTwo.trainCreature(named: "RandomCreatureTwo")

playerTwo.trainAllCreatures()

updateLeaderboard(players: [playerOne, playerTwo])

playerOne.creaturesDescription()
playerTwo.creaturesDescription()


randomCreatureOne

randomCreatureOne.trainer = nil

randomCreatureOne

/* 9. შექმენით BattleSimulator კლასი, რომელიც მართავს ორ DigitalCreature-ს შორის ბრძოლას.
 * გამოიყენეთ weak/unowned მიმთითებლები სათანადოდ, რათა თავიდან აიცილოთ ე.წ memory leak.
 * დაამატეთ მეთოდი simulateBattle(between creature1: DigitalCreature, and creature2: DigitalCreature) -> DigitalCreature, რომელიც დააბრუნებს გამარჯვებულს. მეთოდის ლოგიკას როგორს გააკეთებთ თქვენს ფანტაზიაზეა დამოკიდებული 🙌
 * გამართეთ რამდენიმე ბრძოლა და დაბეჭდეთ შედეგები. 🤺*/

class BattleSimulator {
    func simulateBattle(between creature1: DigitalCreature, and creature2: DigitalCreature) -> String {
        var winner: String = ""
        print("Round Begin!")
        creature1.heath -= (creature2.attack - creature1.defense)
        creature2.heath -= (creature1.attack - creature2.defense)
        print("\(creature1.name)'s health: \(creature1.heath)")
        print("\(creature2.name)'s health: \(creature2.heath)")
        
        if creature1.heath < 0 && creature2.heath > creature1.heath {
            creature2.experience += 10
            creature1.experience += 2
            winner = "\(creature2.name) is the Winner!"
        } else if creature2.heath < 0 && creature1.heath > creature2.heath {
            creature1.experience += 10
            creature2.experience += 2
            winner = "\(creature1.name) is the Winner!"
        } else {
            print("Round is Over, Get Ready For The Next Round")
        }
        return winner
    }
}

var creatureOne = DigitalCreature(heath: 5.0, attack: 1.5, defense: 1, name: "Creature One", type: .air(rarity: 0), experience: 0)
var creatureTwo = DigitalCreature(heath: 5, attack: 3, defense: 0, name: "Creature Two", type: .earth(rarity: 0), experience: 0)

let battleField = BattleSimulator()

battleField.simulateBattle(between: creatureOne, and: creatureTwo)
battleField.simulateBattle(between: creatureOne, and: creatureTwo)
battleField.simulateBattle(between: creatureOne, and: creatureTwo)

