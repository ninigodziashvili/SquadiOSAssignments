import UIKit

//MARK: 1. შექმენით CreatureType enum-ი სხვადასხვა ტიპის არსებებით (მაგ: fire, water, earth, air, electric …). გამოიყენეთ associated value, რომ თითოეულ ტიპს ჰქონდეს rarity: Double მნიშვნელობა 0-დან 1-მდე. დაამატეთ computed property description, რომელიც დააბრუნებს არსების ტიპის აღწერას. 

enum CreatureType {
    case fire(rarity: Double)
    case water(rarity: Double)
    case earth(rarity: Double)
    case air(rarity: Double)
    case electric(rarity: Double)
    
    var description: String {
        switch self {
        case .fire(let rarity):
            return "The rarity of fire creature: \(rarity)"
        case .water(let rarity):
            return "The rarity of water creature: \(rarity)"
        case .earth(let rarity):
            return "The rarity of earth reature: \(rarity)"
        case .air(let rarity):
            return "The rarity of air creature: \(rarity)"
        case .electric(let rarity):
            return "The rarity of electric creature: \(rarity)"
        }
    }
}

//MARK: 2. შექმენით პროტოკოლი CreatureStats შემდეგი მოთხოვნებით:
//    * var health: Double
//    * var attack: Double
//    * var defense: Double
//    * func updateStats(health: Double, attack: Double, defense: Double) მეთოდი, რომელიც განაახლებს ამ მონაცემებს (შეგიძლიათ ფუნქციის პარამეტრები სურვილისამებრ შეცვალოთ, მაგ: დეფოლტ მნიშვნელობები გაუწეროთ 😌) 
protocol CreatureStats {
    var health: Double { get set }
    var attack: Double { get set }
    var defense: Double { get set }
    
    func updateStats(health: Double, attack: Double, defense: Double)
}

//MARK: 3. შექმენით კლასი Trainer შემდეგი ფროფერთებით:
//    * public let name: String
//    * private var creatures: [DigitalCreature]
//    * დაამატეთ public მეთოდი add(creature: DigitalCreature) რომლითაც შეძლებთ ახალი არსების დამატებას მასივში, ასევე არსებას საკუთარ თავს (self) დაუსეტავს ტრენერად.

class Trainer {
    public let name: String
    private var creatures: [DigitalCreature] = []
    
    init(name: String) {
        self.name = name
    }
    
    public func add(creature: DigitalCreature) {
        if !creatures.contains(where: {$0.name == creature.name}) {
            creatures.append(creature)
            creature.trainer = self
        } else {
            print("This creature already exists!")
        }
    }
}

//MARK: 4. შექმენით კლასი DigitalCreature, რომელიც დააკმაყოფილებს CreatureStats პროტოკოლს. დაამატეთ:
//    * public let name: String
//    * public let type: CreatureType
//    * public var level: Int
//    * public var experience: Double
//    * weak public var trainer: Trainer?
//    * დაამატეთ deinit მეთოდი, რომელიც დაბეჭდავს შეტყობინებას არსების წაშლისას. 

class DigitalCreature: CreatureStats {
    var health: Double
    var attack: Double
    var defense: Double
    
    func updateStats(health: Double = 100.0, attack: Double = 10.0, defense: Double = 10.0) {
        self.health = health
        self.attack = attack
        self.defense = defense
        print("""
              Creature stats updated:
              Health = \(self.health)
              Attack = \(self.attack)
              Defense = \(self.defense)
              """)
    }
    
    public let name: String
    public let type: CreatureType
    public var level: Int
    public var experience: Double
    weak public var trainer: Trainer?
    
    init(health: Double, attack: Double, defense: Double, name: String, type: CreatureType, level: Int, experience: Double, trainer: Trainer?) {
        self.health = health
        self.attack = attack
        self.defense = defense
        self.name = name
        self.type = type
        self.level = level
        self.experience = experience
        self.trainer = trainer
    }
    
    deinit {
        print("Creature was deinitialized.")
    }
}

//MARK: 5. შექმენით CreatureManager კლასი შემდეგი ფუნქციონალით:
//    * private var creatures: [DigitalCreature] - არსებების მასივი
//    * public func adoptCreature(_ creature: DigitalCreature) - არსების დამატება
//    * public func trainCreature(named name: String) - კონკრეტული არსების წვრთნა (გაითვალისწინეთ რომ წვრთნა მოხდება მხოლოდ მაშინ თუ არჩეულ არსებას ყავს მწვრთნელი!)
//    * public func listCreatures() -> [DigitalCreature] - ყველა არსების სიის დაბრუნება.
//      გააფართოვეთ CreatureManager კლასი მეთოდით func trainAllCreatures(), რომელიც გაწვრთნის ყველა არსებას. 

class CreatureManager {
    private var creatures: [DigitalCreature]
    
    init(creatures: [DigitalCreature]) {
        self.creatures = creatures
    }
    
    
    public func adoptCreature(_ creature: DigitalCreature) {
        if !creatures.contains(where: { $0.name == creature.name }) {
            creatures.append(creature)
            print("\(creature.name) has been adopted!")
        } else {
            print("This creature is already adopted!")
        }
    }
    
    public func trainCreature(named name: String) {
        if let creature = creatures.first(where: { $0.name == name }) {
            if creature.trainer != nil {
                print("\(creature.name) has been trained")
                creature.experience += 1.0
            } else {
                print("Training is not possible due to \(creature.name) does not have trainer!")
            }
        }
    }
    
    public func listCreatures() -> [DigitalCreature] {
        creatures
    }
}

extension CreatureManager {
    
    func trainAllCreatures() {
        let creaturesWithTrainer = creatures.filter {$0.trainer != nil}
        if creaturesWithTrainer.isEmpty {
            print("There are no creatures with trainers to train!")
        } else {
            creaturesWithTrainer.forEach {
                trainCreature(named: $0.name)
            }
        }
    }
}

//MARK: 6. შექმენით CreatureShop კლასი მეთოდით purchaseRandomCreature() -> DigitalCreature. ეს მეთოდი დააბრუნებს რანდომიზირებულად დაგენერირებულ არსებას. 

class CreatureShop {
    
    func purchaseRandomCreature() -> DigitalCreature {
        let types: [CreatureType] = [
            .fire(rarity: Double.random(in: 0.1...1.0)),
            .water(rarity: Double.random(in: 0.1...1.0)),
            .earth(rarity: Double.random(in: 0.1...1.0)),
            .air(rarity: Double.random(in: 0.1...1.0)),
            .electric(rarity: Double.random(in: 0.1...1.0))
        ]
        
        guard let randomType = types.randomElement() else {
            fatalError("Error: Could not generate a random creature type.")
        }
        
        let randomName = generateRandomName()
        let randomHealth = Double.random(in: 0.0...100.0)
        let randomAttack = Double.random(in: 0.0...10.0)
        let randomDefense = Double.random(in: 0.0...10.0)
        let randomLevel = Int.random(in: 1...10)
        let randomExperience = Double.random(in: 0.0...100.0)
        
        let randomCreature = DigitalCreature(
            health: randomHealth,
            attack: randomAttack,
            defense: randomDefense,
            name: randomName,
            type: randomType,
            level: randomLevel,
            experience: randomExperience,
            trainer: nil
        )
        
        print("A new random creature has been generated: \(randomCreature.name)")
        return randomCreature
    }
    
    private func generateRandomName() -> String {
        let names = [
            "Fawkes", "Hedwig", "Buckbeak", "Norbert", "Fluffy",
            "Dobby", "Thestral", "Niffler", "Blast-Ended Skrewt", "Acromantula",
            "Basilisk", "Graphorn", "Bowtruckle", "Erumpent", "Chimera",
            "Jobberknoll", "Manticore", "Puffskein", "Boggart", "Kneazle"
        ]
        
        // Safely select a random name
        if let name = names.randomElement() {
            return name
        } else {
            return "Unknown Creature"
        }
    }
}

//MARK: 7. შექმენით გლობალური ფუნქცია updateLeaderboard(players: [CreatureManager]) -> [CreatureManager], რომელიც დაალაგებს მოთამაშეებს მათი არსებების ჯამური ძალის მიხედვით.  
func updateLeaderboard(players: [CreatureManager]) -> [CreatureManager] {
    return players.sorted {
        let totalStrength1 = $0.listCreatures().reduce(0) { $0 + ($1.attack + $1.defense) }
        let totalStrength2 = $1.listCreatures().reduce(0) { $0 + ($1.attack + $1.defense) }
        return totalStrength1 > totalStrength2
    }
}

//MARK: 8. გამოვიყენოთ წინა ტასკებში შექმნილი ყველა ფუნქციონალი:
//    * შექმენით რამდენიმე Trainer ობიექტი
//    * შექმენით რამდენიმე CreatureManager ობიექტი
//    * შექმენით ერთი ან ორი CreatureShop
//    * თითოეული მენეჯერისთვის:
//        * შეიძინეთ რამდენიმე შემთხვევითი არსება CreatureShop-იდან
//        * მიაბარეთ რამდენიმე არსება რომელიმე ტრენერს.
//        * სცადეთ არსებების წვრთნა CreatureManager-ის trainCreature(named:) მეთოდით
//    * გამოიყენეთ CreatureManager-ის trainAllCreatures() მეთოდი ყველა მოთამაშის არსებების საწვრთნელად (თუ ყავს მწვრთნელი, რა თქმა უნდა)
//    * განაახლეთ ლიდერბორდი updateLeaderboard() ფუნქციის გამოყენებით
//    * დაბეჭდეთ თითოეული მოთამაშის არსებების სია და მათი სტატისტიკა
//    * წაშალეთ ერთი არსება რომელიმე Trainer-იდან და აჩვენეთ, რომ weak reference მუშაობს სწორად (დაბეჭდეთ არსების trainer property-ს მნიშვნელობა წაშლამდე და წაშლის შემდეგ)
//    * დააკვირდით deinit მეთოდის გამოძახებას არსების წაშლისას 

let trainer1 = Trainer(name: "Ana")
let trainer2 = Trainer(name: "Alex")

let creatureManager1 = CreatureManager(creatures: [])
let creatureManager2 = CreatureManager(creatures: [])

let creatureShop1 = CreatureShop()
let creatureShop2 = CreatureShop()

let purchasedCreature1 = creatureShop1.purchaseRandomCreature()
let purchasedCreature2 = creatureShop2.purchaseRandomCreature()

let creaturesArray: [DigitalCreature] = [purchasedCreature1, purchasedCreature2]

creatureManager1.adoptCreature(purchasedCreature1)
creatureManager2.adoptCreature(purchasedCreature2)

creatureManager1.trainCreature(named: purchasedCreature1.name)
creatureManager2.trainCreature(named: purchasedCreature2.name)

creatureManager1.trainAllCreatures()
creatureManager2.trainAllCreatures()


//MARK: 9. შექმენით BattleSimulator კლასი, რომელიც მართავს ორ DigitalCreature-ს შორის ბრძოლას.
//    * გამოიყენეთ weak/unowned მიმთითებლები სათანადოდ, რათა თავიდან აიცილოთ ე.წ memory leak.
//    * დაამატეთ მეთოდი simulateBattle(between creature1: DigitalCreature, and creature2: DigitalCreature) -> DigitalCreature, რომელიც დააბრუნებს გამარჯვებულს. მეთოდის ლოგიკას როგორს გააკეთებთ თქვენს ფანტაზიაზეა დამოკიდებული 🙌
//    * გამართეთ რამდენიმე ბრძოლა და დაბეჭდეთ შედეგები. 🤺


