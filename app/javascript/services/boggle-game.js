import axios from 'axios';
import md5 from 'js-md5';

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

    submitWord(word) {
        if(!this.isValidWord(word)) { return false }
        this.submittedWords.push(word);
        this.updateScore(word);
        return true;
    }

    updateScore(word) {
        this.score += word.length;
    }

    isValidWord(word) {
        return !this.submittedWords.includes(word.toUpperCase()) &&
          this.validWords.includes(md5(word.toUpperCase()))
    }
}
