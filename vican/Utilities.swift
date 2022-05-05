//
//  Utilities.swift
//  vican
//
//  Created by Oybek Melikulov on 5/5/22.
//

import Foundation

struct RhymeRes: Codable {
	let word: String
	let score: Int
	let numSyllables: Int
}

extension StringProtocol { // for Swift 4 you need to add the constrain `where Index == String.Index`
	var byWords: [SubSequence] {
		var byWords: [SubSequence] = []
		enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
			byWords.append(self[range])
		}
		return byWords
	}
}
