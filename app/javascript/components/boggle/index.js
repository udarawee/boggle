import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import Countdown from 'react-countdown';

import { BoggleGame } from "../../services/boggle-game";
import TextField from '@material-ui/core/TextField'
import Box from '@material-ui/core/Box'

const THREE_MINUTES = 1000*60*3

export const Boggle = () => {
  const [game, setGame ]= useState(null);
  const [currentWord, setCurrentWord]= useState('');
  const [wordIsValid, setWordIsValid]= useState(true);
  const [submittedWords, setSubmittedWords] = useState([])
  const [timeLeft] = useState(Date.now() + THREE_MINUTES)
  const [gameOver, setGameOver] = useState(false)
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
      setWordIsValid(true)
      return;
    }
    if(!game.submitWord(currentWord)) {
      setCurrentWord('');
      setWordIsValid(false)
      return;
    }
    setWordIsValid(true)
    // only add to submitted words list
    setSubmittedWords([...submittedWords, currentWord]);
    setCurrentWord('');
  });

  return (
    <Container>
      <div>
        <Box>
          {game.board.map(((row, i) => <GameRow row={row} key={i}></GameRow>))}
        </Box>
        { !gameOver &&
          <InputContainer>
            <TextField
                error={!wordIsValid}
                id="standard-basic"
                value={currentWord}
                onKeyDown={handleKeyDown}
                onChange={(e) => setCurrentWord(e.target.value.toUpperCase())}
                placeholder="Enter words"
                helperText={!wordIsValid && 'invalid word'}/>
          </InputContainer>
        }
      </div>
      <WordListContainer>
        { !gameOver && <Countdown
          date={timeLeft}
          renderer={props => <div>{`${props.minutes}:${props.seconds}`}</div>}
          onComplete={() => setGameOver(true)}
        /> }
        <h2>{gameOver && 'Game Over'}</h2>
        <h2>Score {`${game.score}`}</h2>
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