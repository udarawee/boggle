import React, { useEffect, useState, useCallback } from 'react';
import { BoggleGame } from "../../services/boggle-game";
import TextField from '@material-ui/core/TextField'
import Box from '@material-ui/core/Box'
import Button from '@material-ui/core/Button'


export const Boggle = () => {
  const [game, setGame ]= useState(null);
  const [currentWord, setCurrentWord]= useState('');
  const [submittedWords, setSubmittedWords] = useState([])

  useEffect( () => {
    async function initGame() {
      const boggleGame = new BoggleGame();
      await boggleGame.init();
      setGame(boggleGame);
    }
    initGame()

  }, []);

  if (!game) {
    return null;
  }

  const handleKeyDown = (event => {
    if (event.key !== 'Enter') {
      // could highlight the letters in the board
      return;
    }
    setCurrentWord('');
    if(!game.submitWord(currentWord)) {
      // TODO: flash screen to show this was illegal
      return;
    }
    // only add to submitted words list
    setSubmittedWords([...submittedWords, currentWord]);
  });

  return (
      <>
        <Box>
          {game.board.map(((row, i) => <GameRow row={row} key={i}></GameRow>))}
        </Box>
        <TextField
            id="standard-basic"
            value={currentWord}
            onKeyDown={handleKeyDown}
            onChange={(e) => setCurrentWord(e.target.value)}/>
        {
          submittedWords.map((word, i) => <div key={i}>{word}</div>)
        }
        <Button variant="contained" onClick={game.finishGame}>Submit</Button>
      </>
  )
};

const GameRow = ({ row }) => {
  return (
    <div>
      { row.map((letter, i) => <GameTile letter={letter} key={i}/>) }
    </div>
  )
}


const GameTile = ({ letter }) => (
  <span>
    { letter }
  </span>
)