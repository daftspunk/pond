import React from 'react';
import { Switch, Route } from 'react-router';
import routes from '@constants/RouteConstants';
import App from '@app/containers/App';
import IndexPage from '@components/Pages/Index/Index';

export default () => (
    <App>
        <Switch>
            <Route path={routes.INDEX} component={IndexPage} />
        </Switch>
    </App>
);
