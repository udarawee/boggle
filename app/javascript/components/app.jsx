import React from 'react';
import Container from '@material-ui/core/Container'
import Grid from '@material-ui/core/Grid'

import { Boggle } from './boggle'

export const App = () => (
    <Container>
        <Grid container justify="center">
            <Grid item xs={1}>
                <Boggle />
            </Grid>
        </Grid>
    </Container>
);
