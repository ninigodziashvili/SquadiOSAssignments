import Cocoa

func separator (task: Int) {
    print("\n_________ დავალება #\(task)_________\n")}

//1. შექმენით "Genre" ტიპის enum, რომელიც შეიცავს წიგნის ჟანრებს (მაგ: fiction, nonFiction, mystery, sciFi, biography). დაამატეთ computed property "description", რომელიც დააბრუნებს ჟანრის აღწერას.
separator(task: 1)


enum Genre: String {
   case fiction = "Fiction"
   case nonFiction = "Non-Fiction"
   case mystery = "Mystery"
   case sciFi = "Science Fiction"
   case biography = "Biography"

    var description: String {
       switch self {
       case .fiction:
           return "ფიქცია არის წიგნების ჟანრი, რომელიც მოიცავს ისტორიებს."
       case .nonFiction:
           return "არამხატვრული არის წიგნები, რომლებიც დაფუძნებულია რეალურ ფაქტებზე."
       case .mystery:
           return "მისტიკური წიგნები ფოკუსირებულია დანაშაულის ამოხსნაზე ან საიდუმლოების გახსნაზე."
       case .sciFi:
           return "სამეცნიერო ფანტასტიკა შეიცავს მომავლის კონცეფციებს და განვითარებულ ტექნოლოგიებს."
       case .biography:
           return "ბიოგრაფია არის პიროვნების ცხოვრების დეტალური აღწერა."
       }
   }
}
let selectedGenre = Genre.mystery
print("Genre: \(selectedGenre.rawValue)")
print("Description: \(selectedGenre.description)")


/*2. შექმენით enum "ReadingLevel" მნიშვნელობებით: beginner, intermediate, advanced. შემდეგ შექმენით პროტოკოლი "Readable" შემდეგი მოთხოვნებით:
 
 - "title: String" ფროფერთი

 - "author: String" ფროფერთი

 - "publicationYear: Int" ფროფერთი

 - "readingLevel: ReadingLevel" ფროფერთი

 - "read()" მეთოდი, რომელიც დაბეჭდავს ინფორმაციას წიგნის წაკითხვის შესახებ, მაგ: "გილოცავთ თქვენ ერთ კლიკში წაიკითხეთ წიგნი" ან რამე სხვა, მიეცით ფანტაზიას გასაქანი 🤘*/
separator(task: 2)

enum ReadingLevel {
   case beginner
   case intermediate
   case advanced
}

protocol Readable {
   var title: String { get }
   var author: String { get }
   var publicationYear: Int { get }
   var readingLevel: ReadingLevel { get }
   func read()//გაგრძელება მე-3 დავალებაში
}
//3. შექმენით სტრუქტურა "Book", რომელიც დააკმაყოფილებს "Readable" პროტოკოლს. დაამატეთ "genre: Genre" ფროფერთი და "description()" მეთოდი, რომელიც დაბეჭდავს სრულ ინფორმაციას წიგნზე.
separator(task: 3)


struct Book: Readable {
   var title: String
   var author: String
   var publicationYear: Int
   var readingLevel: ReadingLevel
   var genre: Genre

   func read() {//მე-2 დავალების პატარა ნაწილი
       switch readingLevel {
       case .beginner:
           print("გილოცავთ! თქვენ წაიკითხეთ წიგნი \(title)!")
       case .intermediate:
           print("თქვენ საკმაოდ კარგად ერკვევით საკითხში და წაიკითხეთ წიგნი \(title).")
       case .advanced:
           print("გილოცავთ! თქვენ ფანტასტიკურად გაართვით თავი წიგნს \(title)!")
       }
   }

   func description() {
       print("""
       Title: \(title)
       Author: \(author)
       Publication Year: \(publicationYear)
       Genre: \(genre.rawValue)
       Genre Description: \(genre.description)
       """)
   }
}

let newBook = Book(
    title: "1984",
    author: "George Orwell",
    publicationYear: 1949,
    readingLevel: .advanced,
    genre: .fiction
)

newBook.description()

/*4. შექმენით "Library" კლასი შემდეგი ფროფერთებით:
 
 - "name: String" - ბიბლიოთეკის სახელი

 - "books: [Book]" - წიგნების მასივი



 დაამატეთ მეთოდები:

 - "add(book: Book)" - წიგნის დამატება

 - "removeBookWith(title: String)" - წიგნის წაშლა სათაურის მიხედვით

 - "listBooks()" - ყველა წიგნის ჩამონათვალის დაბეჭდვა


  გააფართოეთ “Library” კლასი “filterBooks” მეთოდით რომელიც არგუმენტად მიიღებს ქლოჟერს და დააბრუნებს ამ ქლოჟერის გამოყენებით გაფილტრულ წიგნთა მასივს.*/
separator(task: 4)

class Library {
    var name: String
    var books: [Book]
    
    init(name: String, books: [Book] = []) {
        self.name = name
        self.books = books
    }
    
    func add(book: Book) {
        books.append(book)
        print("წიგნი '\(book.title)' დამატებულია ბიბლიოთეკაში '\(name)'")
    }
    
    func removeBookWith(title: String) {
        if let index = books.firstIndex(where: { $0.title == title }) {
            let removedBook = books.remove(at: index)
            print("წიგნი '\(removedBook.title)' წაშლილია ბიბლიოთეკიდან '\(name)'")
        } else {
            print("წიგნი '\(title)' ვერ მოიძებნა ბიბლიოთეკაში '\(name)'")
        }
    }
    
    func listBooks() {
        if books.isEmpty {
            print("ბიბლიოთეკა '\(name)' ცარიელია.")
        } else {
            print("ბიბლიოთეკა '\(name)' შეიცავს შემდეგ წიგნებს:")
            for book in books {
                print("- \(book.title) by \(book.author)")
            }
        }
    }
    
    func filterBooks(using closure: (Book) -> Bool) -> [Book] {
        return books.filter(closure)
    }
}

let book1 = Book(title: "1984", author: "George Orwell", publicationYear: 1949, readingLevel: .advanced, genre: .fiction)
let book2 = Book(title: "The Selfish Gene", author: "Richard Dawkins", publicationYear: 1976, readingLevel: .advanced, genre: .nonFiction)
let book3 = Book(title: "The Hobbit", author: "J.R.R. Tolkien", publicationYear: 1937, readingLevel: .beginner, genre: .fiction)

let myLibrary = Library(name: "City Library")

myLibrary.add(book: book1)
myLibrary.add(book: book2)
myLibrary.add(book: book3)

myLibrary.listBooks()

myLibrary.removeBookWith(title: "The Hobbit")
myLibrary.listBooks()

let filteredBooks = myLibrary.filterBooks { $0.genre == .fiction }
print("\nFiltered Books (Fiction):")
for book in filteredBooks {
    print("- \(book.title)")
}

//5.  შექმენით generic ფუნქცია groupBooksByLevel<T: Readable>(_ books: [T]) -> [ReadingLevel: [T]], რომელიც დააჯგუფებს წიგნებს კითხვის დონის მიხედვით. გამოიყენეთ ეს ფუნქცია ბიბლიოთეკის წიგნებზე და დაბეჭდეთ შედეგი.
separator(task: 5)

func groupBooksByLevel<T: Readable>(_ books: [T]) -> [ReadingLevel: [T]] {
    var groupedBooks: [ReadingLevel: [T]] = [:]

    for book in books {
        groupedBooks[book.readingLevel, default: []].append(book)
    }

    return groupedBooks
}

let groupedBooks = groupBooksByLevel(myLibrary.books)

for (level, books) in groupedBooks {
    print("\nReading Level: \(level)")
    for book in books {
        print("- \(book.title) by \(book.author)")
    }
}

/*6. შექმენით "LibraryMember" კლასი შემდეგი ფროფერთებით:
 
 - "id: Int"

 - "name: String"

 - "borrowedBooks: [Book]"



 დაამატეთ მეთოდები:

 - "borrowBook(_ book: Book, from library: Library)" - წიგნის გამოწერა ბიბლიოთეკიდან

 - "returnBook(_ book: Book, to library: Library)" - წიგნის დაბრუნება ბიბლიოთეკაში*/
separator(task: 6)

class LibraryMember {
    var id: Int
    var name: String
    var borrowedBooks: [Book] = []
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func borrowBook(_ book: Book, from library: Library) {
        if let index = library.books.firstIndex(where: { $0.title == book.title }) {
            borrowedBooks.append(book)
            library.books.remove(at: index)
            print("\(name)-მ წარმატებით აიღო '\(book.title)' ბიბლიოთეკიდან '\(library.name)'.")
        } else {
            print(" წიგნი '\(book.title)' არ არის ხელმისაწვდომი ბიბლიოთეკაში '\(library.name)'.")
        }
    }
    
    func returnBook(_ book: Book, to library: Library) {
        if let index = borrowedBooks.firstIndex(where: { $0.title == book.title }) {
            borrowedBooks.remove(at: index)
            library.add(book: book)
            print("\(name)-მ დააბრუნა '\(book.title)' ბიბლიოთეკაში '\(library.name)'.")
        } else {
            print("\(name)-ს არ აქვს წიგნი '\(book.title)'.")
        }
    }
}


let member = LibraryMember(id: 1, name: "ანა")

// წიგნის აღება
member.borrowBook(book1, from: myLibrary)
member.borrowBook(book2, from: myLibrary)


// წიგნის დაბრუნება
member.returnBook(book1, to: myLibrary)

/*7. შექმენით მინიმუმ 5 "Book" ობიექტი და 1 "Library" ობიექტი. დაამატეთ წიგნები ბიბლიოთეკაში "add(book:)" მეთოდის გამოყენებით. შემდეგ:
 
 - გამოიყენეთ "listBooks()" მეთოდი ყველა წიგნის ჩამოსათვლელად

 - წაშალეთ ერთი წიგნი "removeBookWith(title:)" მეთოდის გამოყენებით

 - გამოიყენეთ "filterBooks" მეთოდი და დაბეჭდეთ მხოლოდ ის წიგნები, რომლებიც გამოცემულია 2000 წლის შემდეგ*/
separator(task: 7)

// ახალი წიგნების შექმნა
let book4 = Book(title: "The Catcher in the Rye", author: "J.D. Salinger", publicationYear: 1951, readingLevel: .beginner, genre: .fiction)
let book5 = Book(title: "To Kill a Mockingbird", author: "Harper Lee", publicationYear: 1960, readingLevel: .intermediate, genre: .fiction)
let book6 = Book(title: "The Da Vinci Code", author: "Dan Brown", publicationYear: 2003, readingLevel: .advanced, genre: .mystery)
let book7 = Book(title: "The Girl with the Dragon Tattoo", author: "Stieg Larsson", publicationYear: 2005, readingLevel: .advanced, genre: .mystery)
let book8 = Book(title: "Educated", author: "Tara Westover", publicationYear: 2018, readingLevel: .intermediate, genre: .biography)


// წიგნების დამატება ბიბლიოთეკაში
myLibrary.add(book: book2)
myLibrary.add(book: book3)
myLibrary.add(book: book4)
myLibrary.add(book: book5)
myLibrary.add(book: book6)
myLibrary.add(book: book7)
myLibrary.add(book: book8)

// ყველა წიგნის ჩამოთვლა
myLibrary.listBooks()

// ერთი წიგნის წაშლა
myLibrary.removeBookWith(title: "The Catcher in the Rye")

// ყველა წიგნის ჩამოთვლა წაშლის შემდეგ
myLibrary.listBooks()

// 2000 წლის შემდეგ გამოცემული წიგნები
let booksAfter2000 = myLibrary.filterBooks { $0.publicationYear > 2000 }

print("\n2000 წლის შემდეგ გამოცემული წიგნები:")
for book in booksAfter2000 {
    print("- \(book.title) by \(book.author) (\(book.publicationYear))")
}

/*8. შექმენით მინიმუმ 2 "LibraryMember" ობიექტი. თითოეული წევრისთვის:
 
 - გამოიწერეთ 2 წიგნი "borrowBook(_:from:)" მეთოდის გამოყენებით

 - დააბრუნეთ 1 წიგნი "returnBook(_:to:)" მეთოდის გამოყენებით

 დაბეჭდეთ თითოეული წევრის გამოწერილი წიგნების სია*/
separator(task: 8)

// ორი წევრის შექმნა
let member1 = LibraryMember(id: 1, name: "ანა")
let member2 = LibraryMember(id: 2, name: "სერგო")

// პირველი წევრი გამოიწერს 2 წიგნს
member1.borrowBook(book1, from: myLibrary)
member1.borrowBook(book2, from: myLibrary)

// მეორე წევრი გამოიწერს 2 წიგნს
member2.borrowBook(book3, from: myLibrary)
member2.borrowBook(book8, from: myLibrary)

// თითოეული წევრი დააბრუნებს 1 წიგნს
member1.returnBook(book1, to: myLibrary)
member2.returnBook(book3, to: myLibrary)

// თითოეული წევრის გამოწერილი წიგნების სიის დაბეჭდვა
print("\n\(member1.name)-ის გამოწერილი წიგნები:")
for book in member1.borrowedBooks {
    print("- \(book.title) by \(book.author)")
}

print("\n\(member2.name)-ის გამოწერილი წიგნები:")
for book in member2.borrowedBooks {
    print("- \(book.title) by \(book.author)")
}
