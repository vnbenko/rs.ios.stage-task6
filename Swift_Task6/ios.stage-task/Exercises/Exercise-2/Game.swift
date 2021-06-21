//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {
    
    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var trump: Suit?
        
        for player in players {
            if let playerHand = player.hand {
                for card in playerHand {
                    if card.isTrump {
                        trump = card.suit
                        break
                    }
                }
            }
        }
        
        if trump == nil {
            return nil
        }
        
        for value in Value.allCases {
            for player in players {
                if let playerHand = player.hand {
                    for card in playerHand {
                        if card.suit == trump && card.value == value {
                            return player
                        }
                    }
                }
            }
        }
        
        return nil
    }
}
