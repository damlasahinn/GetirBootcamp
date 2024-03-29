import UIKit
import Foundation


/** 1. Static fonksiyon tanimlamasi neden yapilir?
 Genellikle sınıfın kendisiyle ilişkili ancak herhangi bir sınıf örneğiyle doğrudan ilişkilendirilmeyen işlevleri yerine getirmek için kullanılır.
 - Utility Fonksiyonlar: Bir sınıf ve yapı ile ilişkili yardımcı fonksiyonlar oluşturmak için kullanılır.
 - Factory Metotlar: Belirli koşullara bağlı olarak farklı örnekler oluşturmak için kullanılan fabrika methodları tanımlamak için kullanılabilir.
 - Singleton Deseni: Bir sınıfın yalnızca bir örneğinin oluşturulmasını sağlamak için kullanılır.
 - Bir uygulamanın genel ayarlarına erişim sağlayan bir yönetici sınıfı, bu ayarları saklamak ve değiştirmek için statik değişkenler ve fonksiyonlar kullanabilir.
 - Performans Optimizasyonu: Statik metotlar, sınıf örneklerine bağlı olmadıkları için, bazı durumlarda nesne oluşturma maliyetini azaltabilir ve böylece performansı iyileştirebilir.
 */

/** 2. UIViewController yasam dongusunu arastiriniz, metotlarin kullanim senaryolari icin birer ornek yaziniz. (loadView gibi metotlari da arastiriniz. -- olabilecek tum metotlari)
 - loadView: Controller yaratılması gerektiğinde çağrılır. viewDidLoad() view’ın yüklenmesi bittiğinde, loadView() ise view yüklenmeye başladığı anda çağrılır.
 - viewDidLoad: Controller yüklendikten sonra çağrılıt. İlk kurulum işlemleri burada yapılır.
 - viewWillAppear: Controller ekrana yüklenmeye başladığı and çağrılır.Uygulama arka plandan ön plana gelirken veya üzerindeki başka bir ekran kapatıldığında vs bir çok kez çağrılabilir.
 - viewWillLayoutSubviews: UIViewController'ın görünümü (view) yeni alt görünümler eklemek ya da mevcutları yeniden düzenlemek üzere olduğunda çağrılır. Bu, görünümün boyutlarının değiştiği (örneğin, cihazın yönünün değişmesi veya bir üst görünümün boyutunun değişmesi gibi) zamanlarda gerçekleşebilir
 - viewDidLayoutSubviews: viewWillLayoutSubviews metodunun tam tersi olarak, alt görünümlerin yerleşiminin güncellendiği ve sabitlendiği zaman çağrılır. Bu, görünümün boyutlarının veya yerleşiminin değiştiği her durumda çalışır ve geliştiricilere alt görünümleri ile ilgili son düzenlemeleri yapma fırsatı verir.
 - viewDidAppear: Controller kullanıcıya gösterildikten sonra çağrılır. API üzerinden data almak, storage(coreData, userDefaults vs) kullanmak, location servislerini aktifleştirmek gibi işlemler burada yapılabilir.
 - viewWillDisappear: Controller’a ait View’ın uygulamanın View hiyerarşisinden silinmesinden hemen sonra çağrılır.
 - viewDidDisappear: View controller'ın görünümü kullanıcı arayüzünden tamamen kaybolduktan sonra çağrılır. Animasyonları durdurma veya kullanıcı arayüzünden kaldırıldığında devam etmemesi gereken işlemleri durdurma işlemleri burada yapılır.
 */

/** 3. Decodable Nedir? Encodable nedir? Hangisini ne zaman kullanıyorsun?  typealias Codable = Decodable & Encodable şeklinde tanımlanmasının nedeni nedir?
Decodable: Bir sınıfın, struct'ın veya enum'un JSON verisini kendi titipine dönüştürürebilmesini sağlar. Yani dışarıdan gelen veriyi, belirli bir modelin instance'ına çevirmek için kullanılır. Örneğin, bir web servisinden gelen JSON verisini bir Swift nesnesine dönüştürmek için bu protokol kullanılır.
Encodable: Uygulamamız içindeki verileri dışarıya göndermek istediğimizde, yani bir nesneyi JSON'a dönüştürmek ve bu JSON verisini bir sunucuya göndermek gerektiğinde Encodable kullanılır. Bu durum genellikle kullanıcı tarafından girilen verilerin kaydedilmesi veya bir sunucuya gönderilmesi gereken durumlarda kullanılır.
Codable: Decodable ve Encodable protokollerinin birleşimidir. Verilerin hem kodlanabilir hem de çözülebilir olması gereken durumlarda kullanılır. Bu typealias tanımı: aynı nesnenin hem girdi hem çıktı olarak kullanılacağı yerlerde yazım kolaylığı ve okunabilirliği sağlamak içindir. Hem Encodable hem de Decodable protokollerini aynı anda kabul etmiş olur.
 */

/** 4. Notification Center ile add observer sonrası memory leak oluşmaması için ne yapılmalı?
 NotificationCenter kullanırken memory leak (bellek sızıntısı) oluşmaması için observer'ları doğru bir şekilde yönetmek önemlidir. Observerları ekledikten sonra onları uygun zamanda kaldırmak gerekir.
 1. Observerları kaldırma: deinit {
 NotificationCenter.default.removeObserver(self)
}
2. weak self kullanımı: Closure'lar içinde self kullanırken, memory leak'lere sebep olabilecek güçlü referans döngülerini önlemek için 'weak self' ya da 'unowned self kullanılmalı.
 NotificationCenter.default.addObserver(forName: .someNotification, object: nil, queue: .main) { [weak self] notification in
     self?.doSomething()
 }
3. Otomatic Observer kaldırma: Swift 4 ve üzeri versiyonlarda, NotificationCenter artık observer'ları otomatik olarak kaldırmaktadır,
 4. Block Based Observer: Observer'ları blok bazında eklemek daha yönetilebilir ve mempry leak riskini azaltabilir. Blok bazında bir observer eklediğimizde, dönüş değeri olarak 'NSObjectProtocol' alırız. Bu referansı kullanarak doğrudan obserever'ı kaldırabiliriz.
 let observer = NotificationCenter.default.addObserver(forName: .someNotification, object: nil, queue: nil) { _ in
     // Handle notification
 }

 NotificationCenter.default.removeObserver(observer)

 **/

//Exercism
// 1. Manage robot factory settings
class Robot {
    private static var usedNames = Set<String>()
    var name: String
    
    init() {
        self.name = Robot.generateUniqueName()
    }
    
    func resetName() {
        self.name = Robot.generateUniqueName()
    }
    
    private static func generateUniqueName() -> String {
        var newName: String
        repeat {
            newName = generateRandomName()
        } while usedNames.contains(newName)
        usedNames.insert(newName)
        return newName
    }
    
    private static func generateRandomName() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        
        var name = ""
        
        for _ in 0..<2 {
            name += String(letters.randomElement()!)
        }
        
        for _ in 0..<3 {
            name += String(numbers.randomElement()!)
        }
        return name
    }
}



var robot = Robot()
print(robot.name)
robot.resetName()

//2. Write a robot simulator.
enum Direction {
    case north, east, south, west
}

class SimulatedRobot {
    var x = 0
    var y = 0
    var direction: Direction
    
    init(x: Int = 0, y: Int = 0, bearing: Direction) {
        self.x = x
        self.y = y
        self.direction = bearing
    }
    
    func turnRight() {
        switch direction {
            case .north:
               direction = .east
            case .east:
               direction = .south
            case .south:
               direction = .west
            case .west:
               direction = .north
        }
    }

    func turnLeft() {
        switch direction {
            case .north:
              direction = .west
            case .west:
              direction = .south
            case .south:
              direction = .east
            case .east:
              direction = .north
        }
    }

    func advance() {
        switch direction {
            case .north:
             y += 1
            case .east:
             x += 1
            case .south:
             y -= 1
            case .west:
             x -= 1
        }
    }
    
    func move(commands: String) {
        for command in commands {
            switch command {
            case "R":
                turnRight()
            case "A":
                advance()
            case "L":
                turnLeft()
            default:
                break
            }
        }
    }
    
    var state: (x: Int, y: Int, bearing: Direction) {
        return (x, y, direction)
    }
}

var robot1 = SimulatedRobot(x: 0, y: 0, bearing: .north)
print("Test 1 - Initial state: Position (\(robot1.x), \(robot1.y)) facing \(robot1.direction)")
robot1.move(commands: "RAALAL")
print("Test 1 - Final state: Position (\(robot1.x), \(robot1.y)) facing \(robot1.direction)")

//3.Your task is to determine what Bob will reply to someone when they say something to him or ask him a question.

class Bob {
    static func response(_ message: String) -> String {
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let isQuestion = trimmed.hasSuffix("?")
        let isYelling = trimmed.uppercased() == trimmed && trimmed.lowercased() != trimmed
        let isSilence = trimmed.isEmpty
        
        if isYelling && isQuestion {
            return "Calm down, I know what I'm doing!"
        } else if isQuestion {
            return "Sure."
        } else if isYelling {
            return "Whoa, chill out!"
        } else if isSilence {
            return "Fine. Be that way!"
        } else {
            return "Whatever."
        }
    }
}

print(Bob.response("How are you?"))

//4.Your task is to convert a number into its corresponding raindrop sounds.

func raindrops(_ number: Int) -> String {
    var result = ""

    if number % 3 == 0 { result += "Pling" }
    if number % 5 == 0 { result += "Plang" }
    if number % 7 == 0 { result += "Plong" }

    if result.isEmpty {
        return "\(number)"
    } else {
        return result
    }
}

print(raindrops(28))
print(raindrops(30))

//5. Calculate leap year
class Year {
    var year: Int
    
    init(calendarYear: Int) {
        self.year = calendarYear
    }
    
    var isLeapYear: Bool {
        if year % 4 != 0 {
            return false
        } else if year % 100 != 0 {
            return true
        } else if year % 400 == 0 {
            return true
        } else {
            return false
        }
    }
}
let year1996 = Year(calendarYear: 1996)
print(year1996.isLeapYear)

let year1900 = Year(calendarYear: 1900)
print(year1900.isLeapYear)

//6.Binary Search Algorithm

enum BinarySearchError: Error {
    case valueNotFound
}

class BinarySearch {
    class BinarySearch {
        let list: [Int]

        init(_ list: [Int]) {
            self.list = list
        }

        func searchFor(_ value: Int) throws -> Int {
            var lowerBound = 0
            var upperBound = list.count

            while lowerBound < upperBound {
                let midIndex = lowerBound + (upperBound - lowerBound) / 2
                let midValue = list[midIndex]

                if midValue == value {
                    return midIndex // The value was found, return its index.
                } else if midValue < value {
                    lowerBound = midIndex + 1
                } else {
                    upperBound = midIndex
                }
            }

            throw BinarySearchError.valueNotFound // The value was not found.
        }
    }
}

//7.Given a person's allergy score, determine whether or not they're allergic to a given item, and their full list of allergies.
class Allergies {
    private var score: UInt
    
    init(score: UInt) {
        self.score = score
    }
    
    private let orderedAllergies: [(name: String, score: UInt)] = [
        ("eggs", 1),
        ("peanuts", 2),
        ("shellfish", 4),
        ("strawberries", 8),
        ("tomatoes", 16),
        ("chocolate", 32),
        ("pollen", 64),
        ("cats", 128)
    ]
    
    func allergicTo(item: String) -> Bool {
        return orderedAllergies.contains { $0.name == item && (score & $0.score) != 0 }
    }
    
    func list() -> [String] {
       orderedAllergies.filter { allergicTo(item: $0.name) }.map { $0.name }
    }
    
}

let tomAllergies = Allergies(score: 34)
print("Is Tom allergic to peanuts? \(tomAllergies.allergicTo(item: "peanuts"))") // true
print("Is Tom allergic to chocolate? \(tomAllergies.allergicTo(item: "chocolate"))") // true
print("All of Tom's allergies: \(tomAllergies.list())")

//8. Create a program that implements the Sieve of Eratosthenes algorithm to find prime numbers.

func sieve(limit: Int) -> [Int] {
    guard limit >= 2 else { return [] }

    var sieve = [Bool](repeating: true, count: limit + 1)
    var primes = [Int]()

    sieve[0] = false
    sieve[1] = false

    for number in 2...limit where sieve[number] {
        primes.append(number)

        var multiple = number * number
        while multiple <= limit {
            sieve[multiple] = false
            multiple += number
        }
    }

    return primes
}

let primes = sieve(limit: 30)

print(primes)

//9. Given a number n, determine what the nth prime is.
enum PrimeError: Error {
    case noZerothPrime
}

func isPrimeNumber(_ number: Int) -> Bool {
    if number <= 1 {
        return false
    }
    if number <= 3 {
        return true
    }
    for i in 2...Int(sqrt(Double(number))) {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func nthPrime(_ n: Int) throws -> Int {
    guard n > 0 else {
        throw PrimeError.noZerothPrime
    }
    
    var count = 0
    var number = 1
    while count < n {
        number += 1
        if isPrimeNumber(number) {
            count += 1
        }
    }
    return number
}

do {
    let prime = try nthPrime(6)
    print(prime)
} catch let error as PrimeError {
    print(error)
} catch {
    print(error)
}

//10. Given a word, compute the Scrabble score for that word.

func score(_ word: String) -> Int {
    let letterValues: [Character: Int] = [
        "A": 1, "E": 1, "I": 1, "O": 1, "U": 1, "L": 1, "N": 1, "R": 1, "S": 1, "T": 1,
        "D": 2, "G": 2,
        "B": 3, "C": 3, "M": 3, "P": 3,
        "F": 4, "H": 4, "V": 4, "W": 4, "Y": 4,
        "K": 5,
        "J": 8, "X": 8,
        "Q": 10, "Z": 10
    ]

    let uppercasedWord = word.uppercased()
    return uppercasedWord.reduce(0) { $0 + (letterValues[$1] ?? 0) }
}
let scrabbleScore = score("cabbage")
print(scrabbleScore)

//Euler
// 6.Sum Square Difference

let sumOfSquares = (1...100).reduce(0) { $0 + $1 * $1 }
let squareOfSum = Int(pow(Double((1...100).reduce(0) { $0 + $1}), 2))

let difference = squareOfSum - sumOfSquares
print(difference)

// 7.10001st Prime

func isPrime(_ number: Int) -> Bool {
    if number <= 1 { return false }
    if number <= 3 { return true }
    if number % 2 == 0 || number % 3 == 0 { return false }
    var i = 5
    while i * i <= number {
        if number % i == 0 || number % (i + 2) == 0 { return false }
        i += 6
    }
    return true
}

func findPrime(at position: Int) -> Int {
    var count = 0
    var number = 1
    
    while count < position {
        number += 1
        if isPrime(number) {
            count += 1
        }
    }
    return number
}

let prime10001 = findPrime(at: 10001)
print(prime10001)


//Closure ile veri taşıma bir sayfa closure tanımla. var callback: ((String -> Void)? vc.callback = { test in değişken


//masksToBounds ne işe yarar? masksToBounds ile clipsToBounds fark nedir?
/**
 Ana fark, birinin CALayer ile (masksToBounds) ve diğerinin UIView ile (clipsToBounds) ilişkilendirilmiş olmasıdır.
 'masksToBounds' true olduğunda layerın içeriği sınırları dışına taşmaz. Örneğin, bir görünümün köşelerini yuvarlaklaştırdığınızda ve alt katmanların (sublayers) yuvarlak köşelerin dışına taşmasını istemediğinizde masksToBounds özelliğini true olarak ayarlarsınız.
 'clipsToBounds true olduğunda UIView'in subviews'ları UIView'in sınırları dışında çıktığında kırpılır.
 */
