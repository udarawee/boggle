import React from 'react';
import Container from '@material-ui/core/Container'
import Grid from '@material-ui/core/Grid'
import axios from 'axios';

import { Boggle } from './boggle'

export const App = () => {
  const csrfToken = document.querySelector('[name=csrf-token]').content
  axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken

  return (
    <Container>
      <Grid container justify="center">
        <Grid item xs={1}>
          <Boggle/>
        </Grid>
      </Grid>
    </Container>
  )
};

