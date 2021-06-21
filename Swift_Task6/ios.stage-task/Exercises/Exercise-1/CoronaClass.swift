import Foundation

class CoronaClass {
    
    private var seatsArray = [Int]()
    private var seatsCount: Int
    
    var seats: [Int] {
        get {
            self.seatsArray.sorted()
        }
        set {
            self.seatsArray = newValue
        }
    }

    init(n: Int) {
        self.seatsCount = n
    }
    
    func seat() -> Int {
        var seat = 0
        var distance = 0
        
        if self.seats.count < self.seatsCount && !self.seats.isEmpty {
            if self.seats.first == 0 && self.seats.count == 1 || self.seats.last != self.seatsCount - 1 {
                seat = self.seatsCount - 1
            }
            else {
                for index in 1..<self.seats.count {
                    if (self.seats[index] - self.seats[index - 1]) / 2 > distance {
                        distance = (self.seats[index] - self.seats[index - 1]) / 2
                        seat = self.seats[index - 1] + distance
                    }
                }
            }
        }
        self.seats.append(seat)
        print(seat)
        return seat
    }
    
    func leave(_ p: Int) {
        if let index = self.seats.firstIndex(of: p) {
            self.seats.remove(at: index)
        }
    }
}
