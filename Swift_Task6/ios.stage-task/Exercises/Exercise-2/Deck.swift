import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {
    
    //MARK: - Properties
    
    var cards = [Card]()
    var type: DeckType
    var trump: Suit?
    
    var total:Int {
        return type.rawValue
    }
}

extension Deck {
    
    init(with type: DeckType) {
        self.type = type
        self.cards = self.createDeck(suits: Suit.allCases, values: Value.allCases)
    }
    
    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var result: [Card] = []
        for suit in suits {
            for value in values {
                result.append(Card(suit: suit, value: value))
            }
        }
        
        self.cards = result
        return result
    }
    
    public mutating func shuffle() {
        self.cards.shuffle()
    }
    
    public mutating func defineTrump() {
        if self.cards.count > 0 {
            self.trump = self.cards.first!.suit
            self.setTrumpCards(for: self.trump!)
        }
    }
    
    public mutating func initialCardsDealForPlayers(players: [Player]) {
        if players.count * 6 <= self.cards.count {
            for player in players {
                if nil == player.hand {
                    player.hand = []
                }
                for _ in 1...6 {
                    player.hand!.append(self.cards.removeFirst())
                }
            }
        }
    }
    
    public mutating func setTrumpCards(for suit:Suit) {
        for index in 0...self.cards.count - 1 {
            if self.cards[index].suit == suit {
                self.cards[index].isTrump = true
            }
        }
    }
}
