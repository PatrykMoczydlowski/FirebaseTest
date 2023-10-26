import SwiftUI

struct ContentView: View {
    @State private var targetWord = "Apple" // The target word to guess
    @State private var guessedWord = "" // Initial guessed word
    @State private var guesses = [String]() // Previous guesses
    @State private var isGameOver = false
    @State private var remainingGuesses = 6

    var body: some View {
        VStack {
            Text("Wordle")
                .font(.largeTitle)
                .padding()

            Text("Guess the 5-letter word")
                .font(.headline)

            Text("Remaining Guesses: \(remainingGuesses)")
                .font(.subheadline)
                .foregroundColor(remainingGuesses > 1 ? .green : .red)

            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Text(String(guessedWord[guessedWord.index(guessedWord.startIndex, offsetBy: index)]))
                        .font(.largeTitle)
                        .frame(width: 30, height: 40)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(5)
                }
            }

            TextField("Enter your guess", text: $guessedWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Guess", action: checkGuess)
                .padding()
                .disabled(isGameOver)

            Text("Previous Guesses:")
                .font(.headline)
                .padding(.top)

            HStack {
                ForEach(guesses, id: \.self) { guess in
                    Text(guess)
                        .font(.title)
                        .padding()
                }
            }

            if isGameOver {
                Text("The word was: \(targetWord)")
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }

    func checkGuess() {
        if guessedWord.count != 5 {
            // Ensure the guess is 5 characters long
            return
        }

        guesses.append(guessedWord)
        remainingGuesses -= 1

        if guessedWord == targetWord {
            // Player guessed the word correctly
            isGameOver = true
        } else {
            // Provide hints for correct letters
            var hintWord = ""
            for (guessed, actual) in zip(guessedWord, targetWord) {
                if guessed == actual {
                    hintWord.append(guessed)
                } else if targetWord.contains(guessed) {
                    hintWord.append("?")
                } else {
                    hintWord.append("-")
                }
            }
            guessedWord = hintWord
        }

        if remainingGuesses == 0 {
            // Player ran out of guesses
            isGameOver = true
        }

        if guessedWord == targetWord {
            // Player guessed the word correctly with hints
            isGameOver = true
        }
    }
}
