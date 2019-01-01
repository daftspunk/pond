import { combineReducers } from 'redux';
import { routerReducer as router } from 'react-router-redux';
import modals from '../actions/ModalActions';
import project from '../actions/ProjectActions';

const rootReducer = combineReducers({
    project,
    modals,
    router
});

export default rootReducer;
