import { combineReducers } from 'redux';
import { connectRouter } from 'connected-react-router';
import modals from '@modules/system/actions/ModalActions';
import project from '@modules/system/actions/ProjectActions';
import website from '@modules/system/actions/WebsiteActions';
import server from '@modules/system/actions/ServerActions';
import slide from '@modules/system/actions/SlideActions';
import { reducer as formReducer } from 'redux-form';

const rootReducer = (history) => combineReducers({
    project,
    website,
    server,
    modals,
    slide,
    form: formReducer,
    router: connectRouter(history)
});

export default rootReducer;
