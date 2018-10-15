import { combineReducers } from 'redux';
import { routerReducer as router } from 'react-router-redux';
import modals from '../actions/ModalActions';
import project from '../actions/ProjectActions';
import website from '../actions/WebsiteActions';

const rootReducer = combineReducers({
    project,
    modals,
    router
});

export default rootReducer;
