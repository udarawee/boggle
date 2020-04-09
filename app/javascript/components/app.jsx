import React from 'react';
// import Container from '@material-ui/core/Container'
// import Grid from '@material-ui/core/Grid'
import styled from 'styled-components'
import axios from 'axios';

import { Boggle } from './boggle'

const Container = styled.div`
  max-width: 600px;
  margin: 0 auto;
  padding: 30px;
`

export const App = () => {
  const csrfToken = document.querySelector('[name=csrf-token]').content
  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken

  return (
    <Container>
      <h1>BOGGLE</h1>
        <Boggle/>
    </Container>
  )
};

