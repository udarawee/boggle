export class BoggleGame {

    constructor() {
        this.board = null;
        this.submittedWords = [];
    }

    async init() {
        this.board = await this.createBoard()
    }

    createBoard() {
        // TODO: Replace with call to server
        return Promise.resolve([
            ['A', 'B', 'C', 'D'],
            ['E', 'F', 'G', 'H'],
            ['I', 'J', 'K', 'L'],
            ['M', 'N', 'O', 'P'],
        ])
    }

    finishGame() {

    }

    submitWord(word) {
        if(!this.possibleWord(word)) { return false }
        this.submittedWords.push(word);
        return true;
    }

    //TODO: implement
    possibleWord(word) {
        return true;
    }
}
