import axios from 'axios';

export class BoggleGame {

    constructor() {
        this.board = null;
        this.submittedWords = [];
    }

    async init() {
        this.board = await this.createBoard()
    }

    async createBoard() {
        const response = await axios.post('/api/games')
        return response.data.board;
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
