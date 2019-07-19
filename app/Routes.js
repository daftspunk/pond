import React from 'react';
import { Switch, Route, Redirect } from 'react-router';
import * as routes from './constants/RouteConstants';
import App from './containers/App';
import IndexPage from './components/Pages/Index/Index';

export default () => (
    <App>
        <Switch>
            <Route path={routes.INDEX} component={IndexPage} />
        </Switch>
    </App>
);
