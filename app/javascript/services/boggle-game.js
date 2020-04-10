import axios from 'axios';

export class BoggleGame {

    constructor() {
        this.board = null;
        this.submittedWords = [];
        this.validWords = [];
        this.score = 0;
    }

    async init() {
        const res = await this.createBoard();
        this.board = res.board;
        this.validWords = res.valid_words;
    }

    async createBoard() {
        const response = await axios.post('/api/games')
        return response.data;
    }

    //TODO: why is this not bound properly here without arrow func (?)
    finishGame = () => {
        axios.post('/api/games/save', {
            board: this.board,
            submitted_words: this.submittedWords
        })
    }

    submitWord(word) {
        if(!this.possibleWord(word)) { return false }
        this.submittedWords.push(word);
        this.updateScore(word);
        return true;
    }

    updateScore(word) {
        this.score += word.length;
    }

    possibleWord(word) {
        return !this.submittedWords.includes(word.toUpperCase()) &&
          this.validWords.includes(word.toUpperCase())
    }
}
