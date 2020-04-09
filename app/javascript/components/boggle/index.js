import React, { useEffect, useState } from 'react';
import styled from 'styled-components';

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
    <Container>
      <div>
        <Box>
          {game.board.map(((row, i) => <GameRow row={row} key={i}></GameRow>))}
        </Box>
        <InputContainer>
          <TextField
              id="standard-basic"
              value={currentWord}
              onKeyDown={handleKeyDown}
              onChange={(e) => setCurrentWord(e.target.value)}/>
          <Button variant="contained" onClick={game.finishGame}>Submit</Button>
        </InputContainer>
      </div>
      <WordListContainer>
        <h2>Your Words</h2>
        <WordList>
          {
            submittedWords.map((word, i) => <div key={i}>{word}</div>)
          }
        </WordList>
      </WordListContainer>
    </Container>
  )
};

const GameTile = styled.span`
    display: inline-flex;
    width: 60px;
    font-size: 36px;
    height: 60px;
    align-items: center;
    justify-content: center;
    border: 1px solid black;
    border-radius: 50%;
    margin-bottom: 10px;
    margin-right: 10px;  
`;

const GameRow = ({ row }) => {
  return (
    <div>
      { row.map((letter, i) => <GameTile key={i}>{letter}</GameTile>) }
    </div>
  )
};

const InputContainer = styled.div`
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
`
const Container = styled.div`
  display: flex;
  justify-content: space-between;
`

const WordList = styled.div`
  border: 1px solid black;
  padding: 30px;
`

const WordListContainer = styled.div`
  width: 40%;
`