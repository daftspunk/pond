import React from 'react'
import { render } from 'react-dom'
import { AppContainer } from 'react-hot-loader'
import Root from './containers/Root'
import { configureStore, history } from './store/configureStore'
import bindTitlebar from './utils/bindTitlebar'
import Application from './services/Foundation/Application'
import './app.global.scss'

const store = configureStore();
const app = new Application(store);

render(
    <AppContainer>
        <Root store={store} history={history} />
    </AppContainer>,
    document.getElementById('root')
);

if (module.hot) {
    module.hot.accept('./containers/Root', () => {
        // eslint-disable-next-line global-require
        const NextRoot = require('./containers/Root').default;
        render(
            <AppContainer>
                <NextRoot store={store} history={history} />
            </AppContainer>,
            document.getElementById('root')
        );
    });
}

bindTitlebar();

app.boot();
